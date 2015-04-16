//
//  SearchAirportController.m
//  Test
//
//  Created by Ilia Isupov on 15.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "SearchAirportController.h"
#import "SearchAirpotrsAPI.h"

#import "Airport.h"

#import "Constants.h"

NSInteger const MinQueryLength = 2;

@interface SearchAirportController (Private)

-(void)loadAirports:(NSString*)query;
-(void)airportsFound:(NSArray*)airports;
-(void)failedToLoadAirportsWithError:(NSError*)error;

-(UITableViewCell*)tableView:(UITableView*)tableView airportCellForIndexPath:(NSIndexPath*)indexPath;
-(UITableViewCell*)nothingFoundCellForTableView:(UITableView*)tableView;
-(UITableViewCell*)loadingCellForTableView:(UITableView*)tableView;

-(void)keyboardWillShow:(NSNotification*)notification;
-(void)keyboardWillHide:(NSNotification*)notification;
-(void)setTableContentInsets:(UIEdgeInsets)insets withAnimationDuration:(float)duration;

@end

@interface SearchAirportController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UISearchBar* searchBar;
@property (nonatomic, weak) IBOutlet UITableView* table;

@end

@implementation SearchAirportController {
    SearchAirpotrsAPI* _searchAirportsAPI;
    NSArray* _airports;
}

#pragma mark - Initialization and dealloc
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        __weak SearchAirportController* weakSelf = self;
        _searchAirportsAPI = [[SearchAirpotrsAPI alloc] init];
        _searchAirportsAPI.onAirportsFound = ^(NSArray* airports) {
            [weakSelf airportsFound:airports];
        };
        _searchAirportsAPI.onError = ^(NSError* error) {
            [weakSelf failedToLoadAirportsWithError:error];
        };
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIViewContoller lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [self.searchBar becomeFirstResponder];
}

#pragma mark - UITableViewDataSource implementation
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
    if (_airports.count) {
        numberOfRows = _airports.count;
    } else {
        numberOfRows = 1;
    }
    if (_searchAirportsAPI.isLoading) {
        numberOfRows++;
    }
    return numberOfRows;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (_airports.count) {
            return [self tableView:tableView airportCellForIndexPath:indexPath];
        } else {
            return [self nothingFoundCellForTableView:tableView];
        }
    }
    
    if (indexPath.row == [self tableView:tableView numberOfRowsInSection:0] - 1 && _searchAirportsAPI.isLoading) {
        return [self loadingCellForTableView:tableView];
    } else {
        return [self tableView:tableView airportCellForIndexPath:indexPath];
    }
    
    return [self tableView:tableView airportCellForIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate implementation

#pragma mark - UISearchBarDelegate implementation
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length >= MinQueryLength) {
        [self loadAirports:searchText];
    }
}

@end

@implementation SearchAirportController (Private)

-(void)loadAirports:(NSString*)query {
    BOOL isLoadingRowNeeded = !_searchAirportsAPI.isLoading;
    [_searchAirportsAPI searchAirports:query];
    if (isLoadingRowNeeded) {
        NSIndexPath* indexPath = [NSIndexPath indexPathForItem:[self tableView:_table numberOfRowsInSection:0] - 1 inSection:0];
        [_table insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }

}

-(void)airportsFound:(NSArray*)airports {
    _airports = airports;
    [_table reloadData];
}

-(void)failedToLoadAirportsWithError:(NSError*)error {
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                               message:[error localizedDescription]
                              delegate:nil
                     cancelButtonTitle:NSLocalizedString(@"OK", nil)
                     otherButtonTitles:nil] show];
    [_table reloadData];
}

-(UITableViewCell*)tableView:(UITableView*)tableView airportCellForIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:AirportCell];
    Airport* airport = [_airports objectAtIndex:indexPath.row];
    cell.textLabel.text = airport.city;
    cell.detailTextLabel.text = airport.country;
    return cell;
}

-(UITableViewCell*)nothingFoundCellForTableView:(UITableView*)tableView {
    return [tableView dequeueReusableCellWithIdentifier:NoAirportsFoundCell];
}

-(UITableViewCell*)loadingCellForTableView:(UITableView*)tableView {
    return [tableView dequeueReusableCellWithIdentifier:LoadingAirportsCell];
}

-(UITableViewCell*)lastTableCell {
    NSIndexPath* indexPath = [NSIndexPath indexPathForItem:[self tableView:_table numberOfRowsInSection:0] - 1 inSection:0];
    return [_table cellForRowAtIndexPath:indexPath];
}

-(void)keyboardWillShow:(NSNotification*)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.height), 0.0);
    } else {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize.width), 0.0);
    }
    NSNumber *rate = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    [self setTableContentInsets:contentInsets withAnimationDuration:rate.floatValue];
}

-(void)keyboardWillHide:(NSNotification*)notification {
    NSNumber *rate = notification.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    [self setTableContentInsets:UIEdgeInsetsZero withAnimationDuration:rate.floatValue];
}

-(void)setTableContentInsets:(UIEdgeInsets)insets withAnimationDuration:(float)duration {
    __weak SearchAirportController* weakSelf = self;
    [UIView animateWithDuration:duration animations:^{
        weakSelf.table.contentInset = insets;
        weakSelf.table.scrollIndicatorInsets = insets;
    }];
}

@end

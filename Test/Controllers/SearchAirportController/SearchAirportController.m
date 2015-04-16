//
//  SearchAirportController.m
//  Test
//
//  Created by Ilia Isupov on 15.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "SearchAirportController.h"
#import "SearchAirpotrsAPI.h"

#import "Constants.h"

@interface SearchAirportController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UISearchBar* searchBar;
@property (nonatomic, weak) IBOutlet UITableView* table;

@end

@implementation SearchAirportController {
    SearchAirpotrsAPI* _searchAirportsAPI;
    NSArray* _airports;
}

#pragma mark - Initialization
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _searchAirportsAPI = [[SearchAirpotrsAPI alloc] init];
        _searchAirportsAPI.onAirportsFound = ^(NSArray* airports) {
            NSLog(@"%@", airports);
        };
        _searchAirportsAPI.onError = ^(NSError* error) {
            NSLog(@"%@", error);
        };
    }
    return self;
}

#pragma mark - UIViewContoller lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    [self.searchBar becomeFirstResponder];
}

#pragma mark - UITableViewDataSource implementation
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_airports.count) {
        return _airports.count;
    } else {
        return 1;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - UITableViewDelegate implementation

#pragma mark - UISearchBarDelegate implementation
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}


@end

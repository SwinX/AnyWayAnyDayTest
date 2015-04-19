//
//  AirlineFaresListController.m
//  Test
//
//  Created by Ilia Isupov on 19.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "AirlineFaresListController.h"

#import "Airline.h"
#import "Fare.h"

#import "Constants.h"

@interface AirlineFaresListController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView* table;

@end

@implementation AirlineFaresListController

#pragma mark - UIViewController lifecycle implementation
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource implementation
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _airline.fares.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:FareCellId];
    Fare* fare = [_airline.fares objectAtIndex:indexPath.row];
    cell.textLabel.text = _airline.code;
    cell.detailTextLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%lu ₽", nil), fare.totalPrice];
    return cell;
}

#pragma mark - UITableViewDelegate implementation
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Selected fare:", nil)
                               message:[[_airline.fares objectAtIndex:indexPath.row] fareId]
                              delegate:nil
                     cancelButtonTitle:NSLocalizedString(@"OK", nil)
                      otherButtonTitles:nil] show];
}

@end

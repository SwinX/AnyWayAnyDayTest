//
//  ViewController.m
//  Test
//
//  Created by Ilia Isupov on 14.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "FlightSearchController.h"

@interface FlightSearchController ()

@property (nonatomic, weak) IBOutlet UITableViewCell* departurePlace;
@property (nonatomic, weak) IBOutlet UITableViewCell* arrivalPlace;
@property (nonatomic, weak) IBOutlet UITableViewCell* flightDate;
@property (nonatomic, weak) IBOutlet UITableViewCell* passengerAmount;
@property (nonatomic, weak) IBOutlet UITableViewCell* flightClass;

@end

@implementation FlightSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - UITableViewControllerDelegate implementation
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

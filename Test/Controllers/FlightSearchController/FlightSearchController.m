//
//  ViewController.m
//  Test
//
//  Created by Ilia Isupov on 14.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "FlightSearchController.h"
#import "FlightDateSelectionController.h"
#import "FlightDateSelectionControllerDelegate.h"

#import "FlightSearchData.h"

#import "Constants.h"

@interface FlightSearchController (Private)

@end

@interface FlightSearchController ()<FlightDateSelectionControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableViewCell* departurePlace;
@property (nonatomic, weak) IBOutlet UITableViewCell* arrivalPlace;
@property (nonatomic, weak) IBOutlet UITableViewCell* flightDate;
@property (nonatomic, weak) IBOutlet UITableViewCell* passengerAmount;
@property (nonatomic, weak) IBOutlet UITableViewCell* flightClass;

@property (nonatomic, strong) FlightSearchData* searchData;

@end

@implementation FlightSearchController

#pragma mark - Initialization and deallocation
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.searchData = [[FlightSearchData alloc] init];
    }
    return self;
}

#pragma mark - UIViewController lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - UITableViewControllerDelegate implementation
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([tableView cellForRowAtIndexPath:indexPath] == self.flightDate) {
        [self.navigationController pushViewController:[[FlightDateSelectionController alloc] initWithDelegate:self] animated:YES];
    }
}

#pragma mark - FlightDateSelectionControllerDelegate implementation
-(void)flightDateSelectionController:(FlightDateSelectionController *)controller didSelectDate:(NSDate *)date {
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"%@", date);
}

@end

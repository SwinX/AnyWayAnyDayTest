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
#import "SearchAirportController.h"
#import "SearchAirportControllerDelegate.h"

#import "FlightSearchData.h"
#import "Airport.h"

#import "Constants.h"

typedef enum _FlightPlaceSelection {
    FPSDeparture = 0,
    FPSArrival
}FlightPlaceSelection;

@interface FlightSearchController (Private)

-(void)startFlightPlaceSelection:(FlightPlaceSelection)selection;
-(void)displayAirport:(Airport*)airport inFlightPlaceCell:(UITableViewCell*)cell;

@end

@interface FlightSearchController ()<FlightDateSelectionControllerDelegate, SearchAirportControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableViewCell* departurePlace;
@property (nonatomic, weak) IBOutlet UITableViewCell* arrivalPlace;
@property (nonatomic, weak) IBOutlet UITableViewCell* flightDate;
@property (nonatomic, weak) IBOutlet UITableViewCell* passengerAmount;
@property (nonatomic, weak) IBOutlet UITableViewCell* flightClass;

@property (nonatomic, strong) FlightSearchData* searchData;

@end

@implementation FlightSearchController {
    FlightPlaceSelection _flightPlaceSelection;
}

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
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == _flightDate) {
        return [self.navigationController pushViewController:[[FlightDateSelectionController alloc] initWithDelegate:self] animated:YES];
    }
    
    if (cell == _departurePlace) {
        [self startFlightPlaceSelection:FPSDeparture];
    }
    
    if (cell == _arrivalPlace) {
        [self startFlightPlaceSelection:FPSArrival];
    }
}

#pragma mark - FlightDateSelectionControllerDelegate implementation
-(void)flightDateSelectionController:(FlightDateSelectionController *)controller didSelectDate:(NSDate *)date {
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"%@", date);
}

#pragma mark - SearchAirportControllerDelegate implementation
-(void)searchAirportController:(SearchAirportController*)controller didSelectAirport:(Airport*)airport {
    switch (_flightPlaceSelection) {
        case FPSDeparture:
            _searchData.departure = airport;
            [self displayAirport:airport inFlightPlaceCell:_departurePlace];
            break;
        case FPSArrival:
            _searchData.arrival = airport;
            [self displayAirport:airport inFlightPlaceCell:_arrivalPlace];
            break;
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end

@implementation FlightSearchController (Private)

-(void)startFlightPlaceSelection:(FlightPlaceSelection)selection {
    _flightPlaceSelection = selection;
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchAirportController* controller = [storyboard instantiateViewControllerWithIdentifier:SearchAirportControllerStoryboardId];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)displayAirport:(Airport*)airport inFlightPlaceCell:(UITableViewCell*)cell {
    cell.textLabel.text = airport.city;
    cell.detailTextLabel.text = airport.country;
    [cell setNeedsUpdateConstraints];
}

@end

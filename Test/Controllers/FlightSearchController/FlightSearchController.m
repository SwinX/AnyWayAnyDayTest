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
#import "FlightClass.h"

#import "Constants.h"

typedef enum _FlightPlaceSelection {
    FPSDeparture = 0,
    FPSArrival
}FlightPlaceSelection;

@interface FlightSearchController (Private)

-(void)startFlightPlaceSelection:(FlightPlaceSelection)selection;

-(void)displayFlightSearchData:(FlightSearchData*)data;
-(void)displayTitleText:(NSString*)titleText detailText:(NSString*)detailText inCell:(UITableViewCell*)cell;
-(NSString*)formattedFlightDate:(NSDate*)date;

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
    [self displayFlightSearchData:_searchData];
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
    _searchData.flightDate = date;
    [self displayFlightSearchData:_searchData];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SearchAirportControllerDelegate implementation
-(void)searchAirportController:(SearchAirportController*)controller didSelectAirport:(Airport*)airport {
    switch (_flightPlaceSelection) {
        case FPSDeparture:
            _searchData.departure = airport;
            break;
        case FPSArrival:
            _searchData.arrival = airport;
            break;
    }
    [self displayFlightSearchData:_searchData];
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

-(void)displayFlightSearchData:(FlightSearchData*)data {
    [self displayTitleText:_searchData.departure.city
                detailText:_searchData.departure.country
                    inCell:_departurePlace];
    [self displayTitleText:_searchData.arrival.city
                detailText:_searchData.arrival.country
                    inCell:_arrivalPlace];
    [self displayTitleText:nil
                detailText:[self formattedFlightDate:_searchData.flightDate]
                    inCell:_flightDate];
    [self displayTitleText:nil
                detailText:[NSString stringWithFormat:@"%lu", (unsigned long)_searchData.passengerAmount]
                    inCell:_passengerAmount];
    [self displayTitleText:nil
                detailText:_searchData.flightClass.localizedDescription
                    inCell:_flightClass];
    self.navigationItem.rightBarButtonItem.enabled = _searchData.isNesessaryDataFilled;
}

-(void)displayTitleText:(NSString*)titleText detailText:(NSString*)detailText inCell:(UITableViewCell*)cell {
    if (titleText.length) {
        cell.textLabel.text = titleText;
    }
    if (detailText.length) {
        cell.detailTextLabel.text = detailText;
    }
}

-(NSString*)formattedFlightDate:(NSDate*)date {
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    return [formatter stringFromDate:date];
}


@end

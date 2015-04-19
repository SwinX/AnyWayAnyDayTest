//
//  ViewController.m
//  Test
//
//  Created by Ilia Isupov on 14.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <ActionSheetPicker-3.0/ActionSheetPicker.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "FlightSearchController.h"

#import "FlightDateSelectionController.h"
#import "FlightDateSelectionControllerDelegate.h"
#import "SearchAirportController.h"
#import "SearchAirportControllerDelegate.h"

#import "FlightSearchData.h"
#import "Airport.h"
#import "FlightClass.h"
#import "FlightsRequestResult.h"
#import "FlightsRequestStatusResult.h"
#import "FlightsSearchResult.h"

#import "FlightsSearchAPI.h"
#import "CheckFlightsRequestStatusAPI.h"
#import "FlightsSearchResultAPI.h"

#import "Constants.h"

typedef enum _CurrentSelection {
    CSDeparture = 0,
    CSArrival,
    CSFlightDate,
    CSPassengerAmount,
    CSFlightClass
}CurrentSelection;

@interface FlightSearchController (Private)

-(void)startFlightPlaceSelection:(CurrentSelection)selection;
-(void)startFlightDateSelection;
-(void)startPassengerAmountSelection;
-(void)startFlightClassSelection;

-(NSArray*)passengerAmountPickerData;
-(NSArray*)flightClassPickerData;
-(NSInteger)selectedFlightClassIndex;

-(void)displayFlightSearchData:(FlightSearchData*)data;
-(void)displayTitleText:(NSString*)titleText detailText:(NSString*)detailText inCell:(UITableViewCell*)cell;
-(NSString*)formattedFlightDate:(NSDate*)date;

-(void)flightsSearchFinishedWithResult:(FlightsRequestResult*)result;
-(void)checkFlightsRequestStatus;
-(void)flightsRequestStatusUpdated:(FlightsRequestStatusResult*)status;
-(void)loadFlightsSearchResult;
-(void)flightsSearchResultLoaded:(FlightsSearchResult*)result;

-(void)displayFlightSearchProgress:(float)progress;
-(void)hideFlightSearchProgress;
-(void)displayFlightSearchComplete;
-(void)displayNoFlightsFound;
-(void)displayError:(NSError*)error;

@end

@interface FlightSearchController ()<FlightDateSelectionControllerDelegate, SearchAirportControllerDelegate>

@property (nonatomic, weak) IBOutlet UITableViewCell* departurePlace;
@property (nonatomic, weak) IBOutlet UITableViewCell* arrivalPlace;
@property (nonatomic, weak) IBOutlet UITableViewCell* flightDate;
@property (nonatomic, weak) IBOutlet UITableViewCell* passengerAmount;
@property (nonatomic, weak) IBOutlet UITableViewCell* flightClass;

@end

@implementation FlightSearchController {
    FlightsSearchAPI* _flightsSearchAPI;
    CheckFlightsRequestStatusAPI* _checkFlightRequestStatusAPI;
    FlightsSearchResultAPI* _flightsSearchResultAPI;
    
    FlightSearchData* _searchData;
    CurrentSelection _currentSelection;
    
    FlightsRequestResult* _flightsRequestResult;
    
    NSArray* _flightClasses;
}

#pragma mark - Initialization and deallocation
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        __weak FlightSearchController* weakSelf = self;
        _flightsSearchAPI = [[FlightsSearchAPI alloc] init];
        _flightsSearchAPI.onFlighsSearchRequestSent = ^(FlightsRequestResult* result) {
            [weakSelf flightsSearchFinishedWithResult:result];
        };
        
        _checkFlightRequestStatusAPI = [[CheckFlightsRequestStatusAPI alloc] init];
        _checkFlightRequestStatusAPI.onFlightsRequestStatusUpdated = ^(FlightsRequestStatusResult* result) {
            [weakSelf flightsRequestStatusUpdated:result];
        };
        
        _flightsSearchResultAPI = [FlightsSearchResultAPI new];
        _flightsSearchResultAPI.onFlightsSearchResultReceived = ^(FlightsSearchResult* result) {
            [weakSelf flightsSearchResultLoaded:result];
        };
        
        _searchData = [[FlightSearchData alloc] init];
        _flightClasses = [FlightClass allFlightClasses];
    }
    return self;
}

#pragma mark - UIViewController lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    [self displayFlightSearchData:_searchData];
}

#pragma mark - User actions
-(IBAction)searchFlights {
    [self displayFlightSearchProgress:0];
    [_flightsSearchAPI searchFlights:_searchData];
}


#pragma mark - UITableViewControllerDelegate implementation
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == _departurePlace) {
        [self startFlightPlaceSelection:CSDeparture];
    }
    
    if (cell == _arrivalPlace) {
        [self startFlightPlaceSelection:CSArrival];
    }
    
    if (cell == _flightDate) {
        [self startFlightDateSelection];
    }
    
    if (cell == _passengerAmount) {
        [self startPassengerAmountSelection];
    }
    
    if (cell == _flightClass) {
        [self startFlightClassSelection];
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
    switch (_currentSelection) {
        case CSDeparture:
            _searchData.departure = airport;
            break;
        case CSArrival:
            _searchData.arrival = airport;
            break;
        default:
            NSAssert(false, @"Current selection here must be either CSDeparture or CSArrival");
            break;
    }
    [self displayFlightSearchData:_searchData];
    [self.navigationController popViewControllerAnimated:YES];
}

@end

@implementation FlightSearchController (Private)

-(void)startFlightPlaceSelection:(CurrentSelection)selection {
    _currentSelection = selection;
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchAirportController* controller = [storyboard instantiateViewControllerWithIdentifier:SearchAirportControllerStoryboardId];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)startFlightDateSelection {
    _currentSelection = CSFlightDate;
    [self.navigationController pushViewController:[[FlightDateSelectionController alloc] initWithDelegate:self] animated:YES];
}

-(void)startPassengerAmountSelection {
    _currentSelection = CSPassengerAmount;
    __weak FlightSearchController* weakSelf = self;
    [ActionSheetStringPicker showPickerWithTitle:NSLocalizedString(@"Passenger amount", nil)
                                            rows:[self passengerAmountPickerData]
                                initialSelection:_searchData.passengerAmount - 1
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           __strong FlightSearchController* strongSelf = weakSelf;
                                           if (strongSelf) {
                                               strongSelf -> _searchData.passengerAmount = selectedIndex + 1;
                                               [strongSelf displayFlightSearchData:strongSelf -> _searchData];
                                           }
                                       }
                                     cancelBlock:nil
                                          origin:self.view];
}

-(void)startFlightClassSelection {
    _currentSelection = CSFlightClass;
    __weak FlightSearchController* weakSelf = self;
    [ActionSheetStringPicker showPickerWithTitle:NSLocalizedString(@"Flight class", nil)
                                            rows:[self flightClassPickerData]
                                initialSelection:[self selectedFlightClassIndex]
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           __strong FlightSearchController* strongSelf = weakSelf;
                                           if (strongSelf) {
                                               strongSelf -> _searchData.flightClass = [strongSelf -> _flightClasses objectAtIndex:selectedIndex];
                                               [strongSelf displayFlightSearchData:strongSelf -> _searchData];
                                           }
                                       }
                                     cancelBlock:nil
                                          origin:self.view];
}

-(NSArray*)passengerAmountPickerData {
    NSMutableArray* pickerData = [NSMutableArray array];
    for (int i = 1; i < MaxPassengerAmount; i++) {
        [pickerData addObject:[NSString stringWithFormat:@"%d", i]];
    }
    return pickerData;
}

-(NSArray*)flightClassPickerData {
    NSMutableArray* pickerData = [NSMutableArray array];
    for (FlightClass* flightClass in _flightClasses) {
        [pickerData addObject:flightClass.localizedDescription];
    }
    return pickerData;
}

-(NSInteger)selectedFlightClassIndex {
    for (int i = 0; i < _flightClasses.count; i++) {
        FlightClass* flightClass = [_flightClasses objectAtIndex:i];
        if (flightClass.type == _searchData.flightClass.type) {
            return i;
        }
    }
    return 0;
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

-(void)flightsSearchFinishedWithResult:(FlightsRequestResult*)result {
    if (result.error) {
        [SVProgressHUD dismiss];
        return [self displayError:result.error];
    }
    _flightsRequestResult = result;
    [self checkFlightsRequestStatus];
}

-(void)checkFlightsRequestStatus {
    [_checkFlightRequestStatusAPI checkReuqestStatus:_flightsRequestResult];
}

-(void)flightsRequestStatusUpdated:(FlightsRequestStatusResult*)status {
    if (status.error) {
        [self hideFlightSearchProgress];
        return [self displayError:status.error];
    }
    [self displayFlightSearchProgress:(status.completion / 100.0f) - 0.1f];
    if (status.completion < 100) {
        [self checkFlightsRequestStatus];
    } else {
        [self loadFlightsSearchResult];
    }
}

-(void)loadFlightsSearchResult {
    [_flightsSearchResultAPI loadFlightsSearchResult:_flightsRequestResult];
}

-(void)flightsSearchResultLoaded:(FlightsSearchResult*)result {
    if (result.error) {
        [self hideFlightSearchProgress];
        [self displayError:result.error];
    }
    [self displayFlightSearchProgress:1.0f];
    [self displayFlightSearchComplete];
    
    if (!result.airlines.count) {
        [self displayNoFlightsFound];
    } else {
        //push flights list there
    }
}

-(void)displayFlightSearchProgress:(float)progress {
    if (progress < 0.0f) {
        progress = 0.0f;
    }
    [SVProgressHUD showProgress:progress
                         status:NSLocalizedString(@"Searching flights...", nil)
                       maskType:SVProgressHUDMaskTypeGradient];
}

-(void)hideFlightSearchProgress {
    [SVProgressHUD dismiss];
}

-(void)displayFlightSearchComplete {
    [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"Complete!", nil)];
}

-(void)displayNoFlightsFound {
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"No flights found", nil)
                                message:NSLocalizedString(@"Please select other departure or arrival point or change flight date", nil)
                               delegate:nil
                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                      otherButtonTitles:nil] show];
}

-(void)displayError:(NSError*)error {
    [[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                message:[error localizedDescription]
                               delegate:nil
                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                      otherButtonTitles:nil] show];
}

@end

//
//  Constants.h
//  Test
//
//  Created by Ilia Isupov on 14.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#ifndef CONSTANTS_H
#define CONSTANTS_H

@import UIKit;

#pragma mark - API
extern NSString* const BaseURL;

#pragma mark - Storyboard IDs
extern NSString* const SearchAirportControllerStoryboardId;
extern NSString* const AirlinesListControllerStoryboardId;

#pragma mark - UITableViewCell IDs
extern NSString* const AirportCell;
extern NSString* const LoadingAirportsCell;
extern NSString* const NoAirportsFoundCell;
extern NSString* const AirlineCellId;

#pragma mark - Errors
extern NSString* const FlightDateSelectionErrorDomain;
extern NSInteger const FlightDateSelectionPastErrorCode;
extern NSInteger const FlightDateSelectionFutureErrorCode;

extern NSString* const APIErrorRequestDomain;
extern NSInteger const GeneralAPIErrorCode;

#pragma mark - Passenger calculations
extern NSInteger const MaxPassengerAmount;

#endif

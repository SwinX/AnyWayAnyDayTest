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

#pragma mark - UITableViewCell IDs
extern NSString* const AirportCell;
extern NSString* const LoadingAirportsCell;
extern NSString* const NoAirportsFoundCell;

#pragma mark - Errors
extern NSString* const FlightDateSelectionErrorDomain;
extern NSInteger const FlightDateSelectionPastErrorCode;
extern NSInteger const FlightDateSelectionFutureErrorCode;

#endif

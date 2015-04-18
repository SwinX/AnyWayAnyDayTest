//
//  FlightSearchResultAPI.h
//  Test
//
//  Created by Ilia Isupov on 18.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FlightsSearchResult;
@class FlightsRequestResult;

@interface FlightsSearchResultAPI : NSObject

@property (nonatomic, copy) void(^onFlightsSearchResultReceived)(FlightsSearchResult* result);

-(void)loadFlightsSearchResult:(FlightsRequestResult*)result;

@end

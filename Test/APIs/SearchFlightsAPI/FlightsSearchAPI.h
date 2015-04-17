//
//  SearchFlightsAPI.h
//  Test
//
//  Created by Ilia Isupov on 17.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FlightsRequestResult;
@class FlightSearchData;

@interface FlightsSearchAPI : NSObject

@property(nonatomic, copy) void(^onFlighsSearchRequestSent)(FlightsRequestResult* result);

-(void)searchFlights:(FlightSearchData*)data;

@end

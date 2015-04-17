//
//  CheckSearchAirportsRequestStatusAPI.h
//  Test
//
//  Created by Ilia Isupov on 17.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FlightsRequestStatusResult;
@class FlightsRequestResult;

@interface CheckFlightsRequestStatusAPI : NSObject

@property (nonatomic, copy) void(^onFlightsRequestStatusUpdated)(FlightsRequestStatusResult* result);

-(void)checkReuqestStatus:(FlightsRequestResult*)requestResult;

@end

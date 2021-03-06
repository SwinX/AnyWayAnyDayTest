//
//  FlightSearchData.h
//  Test
//
//  Created by Ilia Isupov on 15.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@class Airport;
@class FlightClass;

@interface FlightSearchData : NSObject

@property (nonatomic, strong) Airport* departure;
@property (nonatomic, strong) Airport* arrival;
@property (nonatomic, copy) NSDate* flightDate;
@property (nonatomic) NSUInteger passengerAmount;
@property (nonatomic) FlightClass* flightClass;

@property (nonatomic, readonly) BOOL isNesessaryDataFilled;

@end

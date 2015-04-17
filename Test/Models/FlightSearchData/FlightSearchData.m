//
//  FlightSearchData.m
//  Test
//
//  Created by Ilia Isupov on 15.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "FlightSearchData.h"

@implementation FlightSearchData

-(instancetype)init {
    if (self = [super init]) {
        self.flightDate = [NSDate date];
        self.passengerAmount = 1;
        self.flightClass = FCEconomy;
    }
    return self;
}

-(NSString*)flightClassDescription {
    switch (_flightClass) {
        case FCEconomy:
            return NSLocalizedString(@"Economy", nil);
        case FCBusiness:
            return NSLocalizedString(@"Business", nil);
    }
}

-(BOOL)isNesessaryDataFilled {
    return _departure && _arrival; //Not checking any other params because they have default values
}

@end

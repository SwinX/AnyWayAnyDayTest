//
//  FlightClass.m
//  Test
//
//  Created by Ilia Isupov on 17.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "FlightClass.h"

@implementation FlightClass

+(NSArray*)allFlightClasses {
    NSMutableArray* flightClasses = [[NSMutableArray alloc] init];
    for (int i = 0; i < FCTAmount; i++) {
        [flightClasses addObject:[[FlightClass alloc] initWithType:i]];
    }
    return flightClasses;
}

-(instancetype)initWithType:(FlightClassType)type {
    if (self = [super init]) {
        _type = type;
    }
    return self;
}

-(NSString*)localizedDescription {
    switch (_type) {
        case FCTEconomy:
            return NSLocalizedString(@"Economy", nil);
        case FCTBusiness:
            return NSLocalizedString(@"Business", nil);
        default:
            return NSLocalizedString(@"Unknown", nil);
    }
}

@end

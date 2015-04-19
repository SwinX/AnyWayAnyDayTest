//
//  Airline.m
//  Test
//
//  Created by Ilia Isupov on 18.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "Airline.h"
#import "Fare.h"

@implementation Airline

+(NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{
             @"code": @"Code",
             @"fares": @"Fares"
             };
}

+(NSValueTransformer*)faresJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[Fare class]];
}

@end

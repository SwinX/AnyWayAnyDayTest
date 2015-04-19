//
//  FlightsSearchResult.m
//  Test
//
//  Created by Ilia Isupov on 18.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "FlightsSearchResult.h"
#import "Airline.h"

@implementation FlightsSearchResult

+(NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{
             @"airlines": @"Airlines",
//             @"error": @"Error"
             };
}

+(NSValueTransformer*)airlinesJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[Airline class]];
}


@end

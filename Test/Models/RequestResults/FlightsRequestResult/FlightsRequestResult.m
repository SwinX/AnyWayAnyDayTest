//
//  FlightsRequestResult.m
//  Test
//
//  Created by Ilia Isupov on 17.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "FlightsRequestResult.h"

@implementation FlightsRequestResult

+(NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{
             @"requestId": @"Id",
             @"requestIdSynonym": @"IdSynonym",
//             @"error": @"Error"
            };
}

@end

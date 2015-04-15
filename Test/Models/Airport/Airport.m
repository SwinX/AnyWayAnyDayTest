//
//  Airport.m
//  Test
//
//  Created by Ilia Isupov on 15.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "Airport.h"

@implementation Airport

+(NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{
             @"code": @"Code",
             @"city": @"City",
             @"country": @"Country",
             @"airport": @"Airport",
             @"data": @"Data",
             @"cityCode": @"CityCode"
            };
}

@end

//
//  Fare.m
//  Test
//
//  Created by Ilia Isupov on 18.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "Fare.h"

@implementation Fare

+(NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{
             @"fareId": @"FareId",
             @"totalPrice": @"TotalAmount"
            };
}


@end

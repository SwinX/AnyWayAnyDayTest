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

-(void)setFares:(NSArray *)fares {
    _fares = [fares sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Fare* first = (Fare*)obj1;
        Fare* second = (Fare*)obj2;
        
        if (first.totalPrice < second.totalPrice) {
            return NSOrderedAscending;
        } else if (first.totalPrice > second.totalPrice) {
            return NSOrderedDescending;
        } else {
            return NSOrderedSame;
        }
    }];
}

-(NSUInteger)lowestPrice {
    if (!_fares.count) {
        return 0;
    }
    
    NSUInteger lowest = INFINITY;
    
    for (Fare* fare in _fares) {
        lowest = MIN(lowest, fare.totalPrice);
    }
    
    return lowest;
}

@end

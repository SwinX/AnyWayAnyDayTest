//
//  FlightsRequestStatusResult.m
//  Test
//
//  Created by Ilia Isupov on 17.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "FlightsRequestStatusResult.h"
#import "Constants.h"

@implementation FlightsRequestStatusResult

+(NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{
             @"completion": @"Completed",
             @"error": @"Error",
            };
}

+(NSValueTransformer*)completionJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        return [NSNumber numberWithInteger:[value integerValue]];
    }];
}


+(NSValueTransformer*)errorJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if (value) {
            return [[NSError alloc] initWithDomain:FlightsRequestStatusDomain
                                              code:FlightsRequestStatusGeneralErrorCode
                                          userInfo:@{NSLocalizedDescriptionKey: value}];
        } else {
            return nil;
        }
        
    }
                                                reverseBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
                                                    return [value localizedDescription];
                                                }];
}

-(instancetype)initWithError:(NSError*)error {
    if (self = [super init]) {
        _error = error;
    }
    return self;
}

@end

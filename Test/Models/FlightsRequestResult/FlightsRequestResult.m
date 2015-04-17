//
//  FlightsRequestResult.m
//  Test
//
//  Created by Ilia Isupov on 17.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "FlightsRequestResult.h"
#import "Constants.h"

@implementation FlightsRequestResult

+(NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{
             @"requestId": @"Id",
             @"requestIdSynonym": @"IdSynonym",
             @"error": @"Error",
            };
}


+(NSValueTransformer*)errorJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if (value) {
            return [[NSError alloc] initWithDomain:FlightsSearchRequestDomain
                                              code:FlightsSearchRequestGeneralErrorCode
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

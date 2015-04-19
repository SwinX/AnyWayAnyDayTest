//
//  RequestResult.m
//  Test
//
//  Created by Ilia Isupov on 18.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "RequestResult.h"

#import "Constants.h"

@implementation RequestResult

+(NSDictionary*)JSONKeyPathsByPropertyKey {
    return @{
             @"error": @"Error",
            };
}

+(NSValueTransformer*)errorJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        if (value) {
            return [[NSError alloc] initWithDomain:APIErrorRequestDomain
                                              code:GeneralAPIErrorCode
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

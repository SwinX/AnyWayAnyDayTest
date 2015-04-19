//
//  AirlinesDescriptor.m
//  Test
//
//  Created by Ilia Isupov on 19.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "AirlinesDescriptor.h"
#import "LoadAirlinesDescriptionAPI.h"

static AirlinesDescriptor* instance = nil;

@interface AirlinesDescriptor (Private)

-(void)airlinesDescriptionLoaded:(id)description;
-(void)parseDescriptionData:(id)descriptionData;

@end

@implementation AirlinesDescriptor {
    LoadAirlinesDescriptionAPI* _loadAirlinesDescriptionAPI;
    NSMutableDictionary* _descriptions;
    
    refresh_handler_t _refreshHandler;
}

+(instancetype)sharedDesciptor {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[AirlinesDescriptor alloc] init];
    });
    return instance;
}

-(instancetype)init {
    if (self = [super init]) {
        __weak AirlinesDescriptor* weakSelf = self;
        _loadAirlinesDescriptionAPI = [LoadAirlinesDescriptionAPI new];
        _loadAirlinesDescriptionAPI.onAirlinesDescriptionLoaded = ^(id description) {
            [weakSelf airlinesDescriptionLoaded:description];
        };
        _descriptions = [NSMutableDictionary dictionary];
    }
    return self;
}

-(void)refresh:(refresh_handler_t)completionHandler {
    _refreshHandler = completionHandler;
    [_descriptions removeAllObjects];
    [_loadAirlinesDescriptionAPI loadAirlinesDescription];
}

-(NSString*)airlineDescription:(NSString*)airlineCode {
    NSString* name = [_descriptions objectForKey:airlineCode];
    if (!name.length) {
        return airlineCode;
    }
    return name;
}

@end

@implementation AirlinesDescriptor (Private)

-(void)airlinesDescriptionLoaded:(id)description {
    if (![description isKindOfClass:[NSArray class]]) {
        if (_refreshHandler) {
            return dispatch_async(dispatch_get_main_queue(), ^{
                _refreshHandler(NO);
            });
        }
    }
    [self parseDescriptionData:description];
    return dispatch_async(dispatch_get_main_queue(), ^{
        _refreshHandler(YES);
    });
}

-(void)parseDescriptionData:(id)descriptionData {
    for (NSDictionary* descriptionItem in descriptionData) {
        [_descriptions setObject:[descriptionItem objectForKey:@"Name"]
                          forKey:[descriptionItem objectForKey:@"Code"]];
    }
}

@end

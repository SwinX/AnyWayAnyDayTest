//
//  AFHTTPRequestOperationManager.m
//  Test
//
//  Created by Ilia Isupov on 15.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "AFHTTPRequestOperationManager+SharedManager.h"

static AFHTTPRequestOperationManager* instance = nil;

@implementation AFHTTPRequestOperationManager(SharedManager)

+(void)setupSharedManagerWithURL:(NSURL *)url {
    instance = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url]; //may be restricted for single setup only
    instance.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
}

+(instancetype)sharedManager {
    return instance;
}

@end

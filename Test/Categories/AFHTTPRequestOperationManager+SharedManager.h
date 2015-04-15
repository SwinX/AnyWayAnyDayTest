//
//  AFHTTPRequestOperationManager.h
//  Test
//
//  Created by Ilia Isupov on 15.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface AFHTTPRequestOperationManager(SharedManager)

+(void)setupSharedManagerWithURL:(NSURL*)url; //must be a first call before any use of sharedManager
+(instancetype)sharedManager;

@end

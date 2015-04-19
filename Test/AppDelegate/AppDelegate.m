//
//  AppDelegate.m
//  Test
//
//  Created by Ilia Isupov on 14.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "AppDelegate.h"

#import "AFHTTPRequestOperationManager+SharedManager.h"

#import "AirlinesDescriptor.h"
#import "Constants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [AFHTTPRequestOperationManager setupSharedManagerWithURL:[NSURL URLWithString:BaseURL]];
    [[AirlinesDescriptor sharedDesciptor] refresh:^(BOOL isSuccessful) {
        NSLog(@"Initialized Airlines descriptor successfully: %d", isSuccessful);
    }];
    return YES;
}


@end

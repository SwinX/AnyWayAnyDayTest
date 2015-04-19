//
//  GetAirlinesListAPI.m
//  Test
//
//  Created by Ilia Isupov on 19.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "LoadAirlinesDescriptionAPI.h"
#import "AFHTTPRequestOperationManager+SharedManager.h"


@implementation LoadAirlinesDescriptionAPI

-(void)loadAirlinesDescription {
    __weak LoadAirlinesDescriptionAPI* weakSelf = self;
    [[AFHTTPRequestOperationManager sharedManager] GET:@"Controller/UserFuncs/BackOffice/GetAirlines/"
                                            parameters:nil
                                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                   if (weakSelf.onAirlinesDescriptionLoaded) {
                                                       weakSelf.onAirlinesDescriptionLoaded(responseObject);
                                                   }
                                               }
                                               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                   if (weakSelf.onAirlinesDescriptionLoaded) {
                                                       weakSelf.onAirlinesDescriptionLoaded(nil);
                                                   }
                                               }];
}

@end

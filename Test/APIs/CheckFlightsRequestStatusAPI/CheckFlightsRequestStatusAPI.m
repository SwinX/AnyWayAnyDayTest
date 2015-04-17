//
//  CheckSearchAirportsRequestStatusAPI.m
//  Test
//
//  Created by Ilia Isupov on 17.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "CheckFlightsRequestStatusAPI.h"
#import "AFHTTPRequestOperationManager+SharedManager.h"

#import "FlightsRequestResult.h"
#import "FlightsRequestStatusResult.h"

@implementation CheckFlightsRequestStatusAPI

-(void)checkReuqestStatus:(FlightsRequestResult*)requestResult; {
    __weak CheckFlightsRequestStatusAPI* weakSelf = self;
    [[AFHTTPRequestOperationManager sharedManager] GET:@"api2/RequestState/"
                                            parameters:@{
                                                         @"R": requestResult.requestIdSynonym,
                                                         @"_Serialize": @"JSON"
                                                        }
                                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                   FlightsRequestStatusResult* result = [MTLJSONAdapter modelOfClass:[FlightsRequestStatusResult class]
                                                                                                  fromJSONDictionary:responseObject
                                                                                                         error:nil];
                                                   if (weakSelf.onFlightsRequestStatusUpdated) {
                                                       weakSelf.onFlightsRequestStatusUpdated(result);
                                                   }
                                               }
                                               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                   if (weakSelf.onFlightsRequestStatusUpdated) {
                                                       weakSelf.onFlightsRequestStatusUpdated([[FlightsRequestStatusResult alloc] initWithError:error]);
                                                   }
                                               }];
}

@end

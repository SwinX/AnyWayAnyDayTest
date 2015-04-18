//
//  FlightSearchResultAPI.m
//  Test
//
//  Created by Ilia Isupov on 18.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "FlightsSearchResultAPI.h"
#import "AFHTTPRequestOperationManager+SharedManager.h"

#import "FlightsRequestResult.h"

@implementation FlightsSearchResultAPI

-(void)loadFlightsSearchResult:(FlightsRequestResult*)result {
    [[AFHTTPRequestOperationManager sharedManager] GET:@"api/Fares2/"
                                            parameters:@{
                                                         @"R": result.requestIdSynonym,
                                                         @"L": @"RU",
                                                         @"C": @"RUB",
                                                         @"DebugFullNames": [NSNumber numberWithBool:YES],
                                                        }
                                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                   NSLog(@"%@", responseObject);
                                               }
                                               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                   NSLog(@"%@", error);
                                               }];
}

@end

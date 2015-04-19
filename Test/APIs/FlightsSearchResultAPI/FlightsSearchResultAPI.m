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
#import "FlightsSearchResult.h"

@implementation FlightsSearchResultAPI

-(void)loadFlightsSearchResult:(FlightsRequestResult*)result {
    __weak FlightsSearchResultAPI* weakSelf = self;
    [[AFHTTPRequestOperationManager sharedManager] GET:@"api/Fares2/"
                                            parameters:@{
                                                         @"R": result.requestIdSynonym,
                                                         @"L": @"RU",
                                                         @"C": @"RUB",
                                                         @"DebugFullNames": [NSNumber numberWithBool:YES],
                                                         @"_Serialize": @"JSON"
                                                        }
                                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                   if (weakSelf.onFlightsSearchResultReceived) {
                                                       FlightsSearchResult* result = [MTLJSONAdapter modelOfClass:[FlightsSearchResult class]
                                                                                               fromJSONDictionary:responseObject
                                                                                                            error:nil];
                                                       weakSelf.onFlightsSearchResultReceived(result);
                                                   }
                                               }
                                               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                   if (weakSelf.onFlightsSearchResultReceived) {
                                                       FlightsSearchResult* result = [[FlightsSearchResult alloc] initWithError:error];
                                                       weakSelf.onFlightsSearchResultReceived(result);
                                                   }
                                               }];
}

@end

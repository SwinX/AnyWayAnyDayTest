//
//  GetAirpotrsAPI.m
//  Test
//
//  Created by Ilia Isupov on 15.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "SearchAirpotrsAPI.h"
#import "AFHTTPRequestOperationManager+SharedManager.h"
#import "Airport.h"


@implementation SearchAirpotrsAPI

-(void)searchAirports:(NSString *)query {
    __weak SearchAirpotrsAPI* weakSelf = self;
    [[AFHTTPRequestOperationManager sharedManager] GET:@"AirportNames/"
                                            parameters:@{
                                                         @"language": @"RU",
                                                         @"filter": query,
                                                         @"_Serialize": @"JSON"
                                                        }
                                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                   NSLog(@"%@", responseObject);
                                                   if (weakSelf.onAirportsFound) {
                                                       NSArray* airports = [MTLJSONAdapter modelsOfClass:[Airport class]
                                                                                           fromJSONArray:[responseObject objectForKey:@"Array"]
                                                                                                   error:nil];
                                                       weakSelf.onAirportsFound(airports);
                                                   }
                                               }
                                               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                   NSLog(@"%@", error);
                                                   if (weakSelf.onError) {
                                                       weakSelf.onError(error);
                                                   }
                                               }];
}

@end

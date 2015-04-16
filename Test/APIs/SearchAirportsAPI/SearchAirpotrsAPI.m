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

@implementation SearchAirpotrsAPI {
    AFHTTPRequestOperation* _currentOperation;
}

-(BOOL)isLoading {
    return _currentOperation != nil;
}

-(void)searchAirports:(NSString *)query {
    [self cancel]; //made in this way because requests will be sent for each letter input by user
    
    __weak SearchAirpotrsAPI* weakSelf = self;
    _currentOperation = [[AFHTTPRequestOperationManager sharedManager] GET:@"AirportNames/"
                                            parameters:@{
                                                         @"language": @"RU",
                                                         @"filter": query,
                                                         @"_Serialize": @"JSON"
                                                        }
                                               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                   __strong SearchAirpotrsAPI* strongSelf = weakSelf;
                                                   if (strongSelf) {
                                                       strongSelf -> _currentOperation = nil;
                                                   }
                                                   if (weakSelf.onAirportsFound) {
                                                       NSArray* airports = [MTLJSONAdapter modelsOfClass:[Airport class]
                                                                                           fromJSONArray:[responseObject objectForKey:@"Array"]
                                                                                                   error:nil];
                                                       weakSelf.onAirportsFound(airports);
                                                   }
                                               }
                                               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                   if (error.code == -999) {
                                                       return;
                                                   }
                                                   __strong SearchAirpotrsAPI* strongSelf = weakSelf;
                                                   if (strongSelf) {
                                                       strongSelf -> _currentOperation = nil;
                                                   }
                                                   if (weakSelf.onError) {
                                                       weakSelf.onError(error);
                                                   }
                                               }];
}

-(void)cancel {
    if (_currentOperation) {
        [_currentOperation cancel];
    }
}

@end

//
//  FlightsRequestResult.h
//  Test
//
//  Created by Ilia Isupov on 17.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "RequestResult.h"

@interface FlightsRequestResult : RequestResult

@property (nonatomic, copy) NSString* requestId;
@property (nonatomic, copy) NSString* requestIdSynonym;

@end

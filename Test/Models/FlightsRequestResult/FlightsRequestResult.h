//
//  FlightsRequestResult.h
//  Test
//
//  Created by Ilia Isupov on 17.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface FlightsRequestResult : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString* requestId;
@property (nonatomic, copy) NSString* requestIdSynonym;
@property (nonatomic, strong) NSError* error; 

-(instancetype)initWithError:(NSError*)error;

@end

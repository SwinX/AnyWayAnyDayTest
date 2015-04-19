//
//  RequestResult.h
//  Test
//
//  Created by Ilia Isupov on 18.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface RequestResult : MTLModel<MTLJSONSerializing>

@property (nonatomic) NSError* error;

-(instancetype)initWithError:(NSError*)error;

@end

//
//  Airline.h
//  Test
//
//  Created by Ilia Isupov on 18.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Airline : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString* code;
@property (nonatomic, strong) NSArray* fares;

@property (nonatomic, readonly) NSUInteger lowestPrice;

@end

//
//  Fare.h
//  Test
//
//  Created by Ilia Isupov on 18.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Fare : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString* fareId;
@property (nonatomic) NSUInteger totalPrice;

@end

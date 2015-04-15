//
//  Airport.h
//  Test
//
//  Created by Ilia Isupov on 15.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface Airport : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString* code;
@property (nonatomic, copy) NSString* city;
@property (nonatomic, copy) NSString* country;
@property (nonatomic, copy) NSString* airport;
@property (nonatomic, copy) NSString* data;
@property (nonatomic, copy) NSString* cityCode;

@end

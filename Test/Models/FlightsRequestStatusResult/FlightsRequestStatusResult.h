//
//  FlightsRequestStatusResult.h
//  Test
//
//  Created by Ilia Isupov on 17.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Mantle/Mantle.h>

@interface FlightsRequestStatusResult : MTLModel<MTLJSONSerializing>

@property (nonatomic) NSInteger completion;
@property (nonatomic) NSError* error;

-(instancetype)initWithError:(NSError*)error;

@end

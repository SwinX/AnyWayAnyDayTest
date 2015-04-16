//
//  GetAirpotrsAPI.h
//  Test
//
//  Created by Ilia Isupov on 15.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchAirpotrsAPI : NSObject

@property(nonatomic, copy) void(^onAirportsFound)(NSArray* airports);
@property(nonatomic, copy) void(^onError)(NSError* error);

@property (nonatomic, readonly) BOOL isLoading;

-(void)searchAirports:(NSString*)query
-(void)cancel;

@end

//
//  GetAirlinesListAPI.h
//  Test
//
//  Created by Ilia Isupov on 19.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoadAirlinesDescriptionAPI : NSObject

@property (nonatomic, copy) void(^onAirlinesDescriptionLoaded)(id airlinesDescriptionData);

-(void)loadAirlinesDescription;

@end

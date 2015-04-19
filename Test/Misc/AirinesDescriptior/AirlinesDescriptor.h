//
//  AirlinesDescriptor.h
//  Test
//
//  Created by Ilia Isupov on 19.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^refresh_handler_t)(BOOL isSuccessful);

@interface AirlinesDescriptor : NSObject

+(instancetype)sharedDesciptor;

-(void)refresh:(refresh_handler_t)completionHandler;

-(NSString*)airlineDescription:(NSString*)airlineCode;

@end

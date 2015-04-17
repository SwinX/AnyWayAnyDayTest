//
//  FlightClass.h
//  Test
//
//  Created by Ilia Isupov on 17.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _FlightClassType {
    FCTEconomy = 0,
    FCTBusiness,
    FCTAmount
}FlightClassType;

@interface FlightClass : NSObject

@property (nonatomic) FlightClassType type;

+(NSArray*)allFlightClasses; //returns all possible flight classess

-(instancetype)initWithType:(FlightClassType)type;

-(NSString*)localizedDescription;

@end

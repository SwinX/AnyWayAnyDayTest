//
//  FlightDateSelectionController.h
//  Test
//
//  Created by Ilia Isupov on 14.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RDVCalendarView/RDVCalendarView.h>

@protocol FlightDateSelectionControllerDelegate;

@interface FlightDateSelectionController : UIViewController<RDVCalendarViewDelegate>

@property (nonatomic, weak) id<FlightDateSelectionControllerDelegate> delegate;

-(instancetype)initWithDelegate:(id<FlightDateSelectionControllerDelegate>)delegate;

@end

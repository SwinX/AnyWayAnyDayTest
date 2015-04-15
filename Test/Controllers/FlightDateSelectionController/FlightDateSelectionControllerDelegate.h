//
//  FlightDateSelectionControllerDelegate.h
//  Test
//
//  Created by Ilia Isupov on 15.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

@import Foundation;

@class FlightDateSelectionController;

@protocol FlightDateSelectionControllerDelegate <NSObject>

-(void)flightDateSelectionController:(FlightDateSelectionController*)controller didSelectDate:(NSDate*)date;

@end

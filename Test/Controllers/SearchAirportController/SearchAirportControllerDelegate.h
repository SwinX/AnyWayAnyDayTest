//
//  SearchAirportControllerDelegate.h
//  Test
//
//  Created by Ilia Isupov on 16.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

@import Foundation;

@class SearchAirportController;
@class Airport;

@protocol SearchAirportControllerDelegate <NSObject>

-(void)searchAirportController:(SearchAirportController*)controller didSelectAirport:(Airport*)airport;

@end

//
//  SearchAirportController.h
//  Test
//
//  Created by Ilia Isupov on 15.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

@import UIKit;

@protocol SearchAirportControllerDelegate;

@interface SearchAirportController : UIViewController

@property (nonatomic, weak) id<SearchAirportControllerDelegate> delegate;

@end

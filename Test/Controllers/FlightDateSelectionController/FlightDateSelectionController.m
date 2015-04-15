//
//  FlightDateSelectionController.m
//  Test
//
//  Created by Ilia Isupov on 14.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import <RDVCalendarView/RDVCalendarView.h>
#import "FlightDateSelectionController.h"

#import "Constants.h"

@interface FlightDateSelectionController (Private)

-(void)buildCalendarView;
-(void)addCalendarViewConstraints;

-(BOOL)isDateInPast:(NSDate*)date;
-(BOOL)isDateInMoreThanYear:(NSDate*)date;

@end

@interface FlightDateSelectionController ()

@property (nonatomic, weak) IBOutlet RDVCalendarView* calendarView;

@end

@implementation FlightDateSelectionController

#pragma mark - UIViewController lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    [self buildCalendarView];
}

#pragma mark - RDVCalendarViewDelegate implementation
- (BOOL)calendarView:(RDVCalendarView *)calendarView shouldSelectCellAtIndex:(NSInteger)index {
    
    NSDate* selectedDate = [self.calendarView dateForIndex:index];
    
    if ([self isDateInPast:selectedDate]) {
        NSLog(@"Date in past!");
        return NO;
    }
    
    if ([self isDateInMoreThanYear:selectedDate]) {
        NSLog(@"Date in future!");
        return NO;
    }
    NSLog(@"Date in acceptable range!");
    return YES;
}

- (void)calendarView:(RDVCalendarView *)calendarView didSelectCellAtIndex:(NSInteger)index {
    NSLog(@"%@", [self.calendarView dateForIndex:index]);
}

@end

@implementation FlightDateSelectionController (Private)

-(void)buildCalendarView {
    RDVCalendarView* calendarView = [[RDVCalendarView alloc] initWithFrame:CGRectZero];
    calendarView.backgroundColor = [UIColor whiteColor];
    [calendarView setSeparatorStyle:RDVCalendarViewDayCellSeparatorTypeHorizontal];
    calendarView.translatesAutoresizingMaskIntoConstraints = NO;
    calendarView.delegate = self;
    self.calendarView = calendarView;
    [self.view addSubview:calendarView];
    [self addCalendarViewConstraints];
}

-(void)addCalendarViewConstraints {
    id topLayoutGuide = self.topLayoutGuide;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_calendarView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_calendarView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide]-0-[_calendarView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(topLayoutGuide, _calendarView)]];
}

-(BOOL)isDateInPast:(NSDate*)date {
    return [date timeIntervalSinceNow] < 0.0f;
}

-(BOOL)isDateInMoreThanYear:(NSDate*)date {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    NSDateComponents* components = [calendar components:NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitTimeZone fromDate:[NSDate date]];
    components.year++;
    components.day--;
    
    NSDate* nextYear = [calendar dateFromComponents:components];
    return [date compare:nextYear] == NSOrderedDescending;
}

@end

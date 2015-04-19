//
//  AirlinesListController.m
//  Test
//
//  Created by Ilia Isupov on 18.04.15.
//  Copyright (c) 2015 AnyWayAnyDay. All rights reserved.
//

#import "AirlinesListController.h"
#import "Airline.h"

#import "Constants.h"

@interface AirlinesListController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView* table;

@end

@implementation AirlinesListController

#pragma mark - UIViewController lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UITableViewDataSource implementation
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _airlines.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:AirlineCellId];
    Airline* airline = [_airlines objectAtIndex:indexPath.row];
    cell.textLabel.text = airline.code;
    cell.detailTextLabel.text = [NSString stringWithFormat:NSLocalizedString(@"From %lu ₽", nil), airline.lowestPrice];
    return cell;
}

#pragma mark - UITableViewDelegate implementation
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

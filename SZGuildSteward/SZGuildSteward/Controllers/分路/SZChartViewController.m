//
//  SZChartViewController.m
//  SZGuildSteward
//
//  Created by Stephen Zhuang on 15/4/22.
//  Copyright (c) 2015年 Stephen Zhuang. All rights reserved.
//

#import "SZChartViewController.h"
#import <PNChart.h>
#import "SZSquad.h"

@implementation SZChartViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *arr = @[@"未分配",@"上路",@"中路",@"下路"];
    self.title = [NSString stringWithFormat:@"%@战力分布",arr[_direction]];
    [self loadData];
}

- (void)loadData
{
    NSInteger combatAbove4w = [SZSquad countWhere:@"combat >= 40000 AND direction == %@",@(_direction)];
    NSInteger combatAbove3w5 = [SZSquad countWhere:@"combat >= 35000 AND combat < 40000 AND direction == %@",@(_direction)];
    NSInteger combatAbove3w = [SZSquad countWhere:@"combat >= 30000 AND combat < 35000 AND direction == %@",@(_direction)];
    NSInteger combatBelow3w = [SZSquad countWhere:@"combat < 30000 AND direction == %@",@(_direction)];
    
    PNBarChart * barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 135, SCREEN_WIDTH, 300.0)];
    barChart.yLabelFormatter = ^(CGFloat yValue){
        CGFloat yValueParsed = yValue;
        NSString * labelText = [NSString stringWithFormat:@"%1.f",yValueParsed];
        return labelText;
    };
    [barChart setXLabels:@[@"<3w",@"<3w5",@"<4w",@">4w"]];
    [barChart setYValues:@[ @(combatBelow3w),@(combatAbove3w), @(combatAbove3w5),@(combatAbove4w)]];
    [barChart strokeChart];
    [self.view addSubview:barChart];
}
@end

//
//  SZDirectionViewController.m
//  SZGuildSteward
//
//  Created by Stephen Zhuang on 15/4/22.
//  Copyright (c) 2015年 Stephen Zhuang. All rights reserved.
//

#import "SZDirectionViewController.h"
#import "SZSquad.h"
#import "SZDirectionDetailViewController.h"

@implementation SZDirectionViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"概览";
    [self.tableView setExtrueLineHidden];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSInteger squadNum = [SZSquad countWhere:@"direction == %@",@(indexPath.row + 1)];
    NSInteger paNum = [SZSquad countWhere:@"direction == %@ AND hasPA == 1",@(indexPath.row + 1)];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"队伍总数 %@, PA队 %@",@(squadNum),@(paNum)]];
    if (indexPath.row == 0) {
        [cell.textLabel setText:@"上路"];
    } else if (indexPath.row == 1) {
        [cell.textLabel setText:@"中路"];
    } else {
        [cell.textLabel setText:@"下路"];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detail"]) {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        SZDirectionDetailViewController *vc = segue.destinationViewController;
        vc.direction = indexPath.row + 1;
    }
}
@end

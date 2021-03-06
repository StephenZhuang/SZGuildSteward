//
//  SZDirectionDetailViewController.m
//  SZGuildSteward
//
//  Created by Stephen Zhuang on 15/4/22.
//  Copyright (c) 2015年 Stephen Zhuang. All rights reserved.
//

#import "SZDirectionDetailViewController.h"
#import "SZSquad.h"
#import "SZSquadTableViewCell.h"
#import "SZHero.h"
#import "SZUser.h"
#import "SZAddSquadTableViewController.h"
#import "SZChartViewController.h"

@implementation SZDirectionDetailViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *arr = @[@"未分配",@"上路",@"中路",@"下路"];
    self.title = arr[_direction];
    [self loadData];
    [self.tableView setExtrueLineHidden];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(chart)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)chart
{
    [self performSegueWithIdentifier:@"chart" sender:nil];
}

- (void)loadData
{
    _squadArray = [SZSquad where:@{@"direction" : @(_direction)} order:@{@"combat" : @"DESC"}];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _squadArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SZSquad *squad = [_squadArray objectAtIndex:indexPath.row];
    if (squad.heroes.length > 0) {
        return 105;
    } else {
        return 45;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SZSquad *squad = [_squadArray objectAtIndex:indexPath.row];
    if (squad.heroes.length > 0) {
        SZSquadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell"];
        [cell.titleLabel setText:squad.user.name];
        [cell.contentLabel setText:[NSString stringWithFormat:@"战斗力 %@",@(squad.combat)]];
        NSArray *arr = [squad.heroes componentsSeparatedByString:@","];
        for (int i = 0; i < 5; i++) {
            UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:i+1];
            if (i < arr.count) {
                SZHero *hero = [SZHero find:@"heroid == %@",arr[i]];
                NSString *path = [[NSBundle mainBundle] pathForResource:hero.heroid ofType:@"jpg"];
                UIImage *image = [UIImage imageWithContentsOfFile:path];
                [imageView setImage:image];
            } else {
                [imageView setImage:[UIImage new]];
            }
        }
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        [cell.textLabel setText:squad.user.name];
        
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"战斗力 %@",@(squad.combat)]];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak __typeof(&*self)weakSelf = self;
    SZSquad *squad = [_squadArray objectAtIndex:indexPath.row];
    SZAddSquadTableViewController *vc = [[UIStoryboard storyboardWithName:@"Member" bundle:nil] instantiateViewControllerWithIdentifier:@"SZAddSquadTableViewController"];
    vc.isEdit = YES;
    vc.user = squad.user;
    vc.squad = squad;
    vc.successBlock = ^(SZUser *user) {
        [weakSelf loadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"chart"]) {
        SZChartViewController *vc = segue.destinationViewController;
        vc.direction = _direction;
    }
}
@end

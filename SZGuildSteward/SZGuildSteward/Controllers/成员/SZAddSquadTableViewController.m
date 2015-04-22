//
//  SZAddSquadTableViewController.m
//  SZGuildSteward
//
//  Created by Stephen Zhuang on 15/4/20.
//  Copyright (c) 2015年 Stephen Zhuang. All rights reserved.
//

#import "SZAddSquadTableViewController.h"
#import "SZHeroPickerCollectionViewController.h"
#import "SZTextFieldTableViewCell.h"
#import "SZSquadTableViewCell.h"
#import "SZHero.h"

@interface SZAddSquadTableViewController ()

@end

@implementation SZAddSquadTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加队伍";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction)];
    self.navigationItem.rightBarButtonItem = item;
    
    if (!_heroArray) {
        _heroArray = [[NSMutableArray alloc] init];
    }
    
    direction = 0;
}

- (void)doneAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return 85;
    } else {
        return 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SZTextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SZTextFieldTableViewCell"];
        return cell;
    } else if (indexPath.row == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        
        
        return cell;
        
    } else {
        SZSquadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"imageCell"];
        for (int i = 0; i < 5; i++) {
            UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:i+1];
            if (i < _heroArray.count) {
                SZHero *hero = [_heroArray objectAtIndex:i];
                [imageView setImage:[UIImage imageNamed:hero.imageName]];
            } else {
                [imageView setImage:[UIImage imageNamed:@""]];
            }
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
    } else if (indexPath.row == 2) {
        SZHeroPickerCollectionViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SZHeroPickerCollectionViewController"];
        vc.selectedHeroArray = _heroArray;
        vc.selectedBlock = ^(NSMutableArray *array) {
            _heroArray = array;
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        };
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

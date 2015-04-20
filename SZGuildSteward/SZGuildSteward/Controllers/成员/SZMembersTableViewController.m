//
//  SZMembersTableViewController.m
//  SZGuildSteward
//
//  Created by Stephen Zhuang on 15/4/20.
//  Copyright (c) 2015年 Stephen Zhuang. All rights reserved.
//

#import "SZMembersTableViewController.h"
#import "SZUser.h"
#import "SZSquad.h"
#import <NSManagedObject+ActiveRecord.h>
#import "GVUserDefaults+SZDefault.h"
#import <NSArray+ObjectiveSugar.h>
#import "SZUserSquadTableViewController.h"

@interface SZMembersTableViewController ()<UIAlertViewDelegate>
@property (nonatomic , strong) NSMutableArray *userArray;
@end

@implementation SZMembersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公会成员";
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *barbuttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addMember)];
    self.navigationItem.rightBarButtonItem = barbuttonItem;
    
    _userArray = [[SZUser allWithOrder:[NSSortDescriptor sortDescriptorWithKey:@"totalCombat" ascending:NO]] mutableCopy];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

- (void)addMember
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成员昵称" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = -1;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        if (alertView.tag == -1) {
            UITextField *textField = [alertView textFieldAtIndex:0];
            NSString *string = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if (string.length > 0) {
                SZUser *user = [SZUser create];
                [GVUserDefaults standardUserDefaults].lastMaxID = @([GVUserDefaults standardUserDefaults].lastMaxID.integerValue+1);
                user.name = string;
                user.userid = [GVUserDefaults standardUserDefaults].lastMaxID.stringValue;
                user.totalCombat = 0;
                [user save];
                
                [_userArray addObject:user];
                [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:_userArray.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        } else {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:alertView.tag inSection:0];
            SZUser *user = _userArray[alertView.tag];
            [[SZSquad where:@"user.userid == %@",user.userid] each:^(SZSquad *squad) {
                [squad delete];
            }];
            [user delete];
            [_userArray removeObject:user];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
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
    return _userArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    SZUser *user = [_userArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:user.name];
    NSInteger num = user.squads.count;
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"队伍 %@, 总战力 %@",@(num),@(user.totalCombat)]];
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确定删除吗" message:@"删除成员，队伍也会一起删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag = indexPath.row;
        [alert show];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"squad"]) {
        UITableViewCell *cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        SZUser *user = [_userArray objectAtIndex:indexPath.row];
        SZUserSquadTableViewController *vc = segue.destinationViewController;
        vc.user = user;
    }
}


@end

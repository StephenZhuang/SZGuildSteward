//
//  SZUserSquadTableViewController.m
//  SZGuildSteward
//
//  Created by Stephen Zhuang on 15/4/20.
//  Copyright (c) 2015年 Stephen Zhuang. All rights reserved.
//

#import "SZUserSquadTableViewController.h"
#import "SZSquadTableViewCell.h"
#import "SZAddSquadTableViewController.h"

@interface SZUserSquadTableViewController ()
@property (nonatomic , strong) NSMutableArray *squadArray;
@end

@implementation SZUserSquadTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _user.name;
    
    UIBarButtonItem *barbuttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addSquad)];
    self.navigationItem.rightBarButtonItem = barbuttonItem;
    
    [self.tableView setExtrueLineHidden];
    _squadArray = [[NSMutableArray alloc] init];
    [self loadData];
}

- (void)loadData
{
    [_squadArray removeAllObjects];
    for (SZSquad *squad in _user.squads) {
        [_squadArray addObject:squad];
    }
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

- (void)addSquad
{
    [self performSegueWithIdentifier:@"add" sender:nil];
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
        NSArray *directionArray = @[@"未分配",@"上路",@"中路",@"下路"];
        [cell.titleLabel setText:directionArray[squad.direction]];
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
        
        [cell.textLabel setText:_user.name];
        
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"战斗力 %@",@(squad.combat)]];
        
        return cell;
    }
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        SZSquad *squad = [_squadArray objectAtIndex:indexPath.row];
        [squad delete];
        _user.totalCombat -= squad.combat;
        [_user save];
        [self loadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak __typeof(&*self)weakSelf = self;
    SZSquad *squad = [_squadArray objectAtIndex:indexPath.row];
    SZAddSquadTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SZAddSquadTableViewController"];
    vc.isEdit = YES;
    vc.user = _user;
    vc.squad = squad;
    vc.successBlock = ^(SZUser *user) {
        weakSelf.user = user;
        [weakSelf loadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"add"]) {
        SZAddSquadTableViewController *vc = segue.destinationViewController;
        vc.user = _user;
        __weak __typeof(&*self)weakSelf = self;
        vc.successBlock = ^(SZUser *user) {
            weakSelf.user = user;
            [weakSelf loadData];
        };
    }
}


@end

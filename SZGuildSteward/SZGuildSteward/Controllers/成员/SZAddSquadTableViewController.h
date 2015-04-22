//
//  SZAddSquadTableViewController.h
//  SZGuildSteward
//
//  Created by Stephen Zhuang on 15/4/20.
//  Copyright (c) 2015年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZUser.h"

@interface SZAddSquadTableViewController : UITableViewController
{
    NSInteger direction;
}
@property (nonatomic , strong) SZUser *user;
@property (nonatomic , strong) NSMutableArray *heroArray;
@property (nonatomic , copy) void (^successBlock)();
@end

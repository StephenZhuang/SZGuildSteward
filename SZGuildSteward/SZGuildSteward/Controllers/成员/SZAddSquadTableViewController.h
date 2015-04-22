//
//  SZAddSquadTableViewController.h
//  SZGuildSteward
//
//  Created by Stephen Zhuang on 15/4/20.
//  Copyright (c) 2015年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZUser.h"

@interface SZAddSquadTableViewController : UITableViewController<UIActionSheetDelegate,UITextFieldDelegate>
{
    NSInteger direction;
    NSInteger combat;
}

@property (nonatomic , strong) SZUser *user;
//edit
@property (nonatomic , assign) BOOL isEdit;
@property (nonatomic , strong) SZSquad *squad;

@property (nonatomic , copy) void (^successBlock)(SZUser *user);
@property (nonatomic , strong) NSMutableArray *heroArray;
@end

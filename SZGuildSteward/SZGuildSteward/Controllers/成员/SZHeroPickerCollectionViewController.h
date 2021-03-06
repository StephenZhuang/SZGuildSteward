//
//  SZHeroPickerCollectionViewController.h
//  SZGuildSteward
//
//  Created by Stephen Zhuang on 15/4/21.
//  Copyright (c) 2015年 Stephen Zhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZHeroPickerCollectionViewController : UICollectionViewController
@property (nonatomic , strong) NSMutableArray *selectedHeroArray;
@property (nonatomic , copy) void (^selectedBlock)(NSMutableArray *array);
@end

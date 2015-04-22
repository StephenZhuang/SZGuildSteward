//
//  SZSquad.h
//  SZGuildSteward
//
//  Created by Stephen Zhuang on 15/4/20.
//  Copyright (c) 2015年 Stephen Zhuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SZUser;

@interface SZSquad : NSManagedObject
/**
 *  战斗力
 */
@property (nonatomic) int32_t combat;
/**
 *  分路 0 未分配, 1 上路, 2 中路 ,3 下路
 */
@property (nonatomic) int16_t direction;
/**
 *  有没有pa
 */
@property (nonatomic) BOOL hasPA;
/**
 *  英雄id，用逗号隔开
 */
@property (nonatomic, retain) NSString * heroes;
/**
 *  成员
 */
@property (nonatomic, retain) SZUser *user;

@end

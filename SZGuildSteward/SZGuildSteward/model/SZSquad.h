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

@property (nonatomic) int32_t combat;
@property (nonatomic) int16_t direction;
@property (nonatomic) BOOL hasPA;
@property (nonatomic, retain) NSString * heroes;
@property (nonatomic, retain) SZUser *user;

@end

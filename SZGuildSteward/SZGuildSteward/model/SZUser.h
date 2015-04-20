//
//  SZUser.h
//  SZGuildSteward
//
//  Created by Stephen Zhuang on 15/4/20.
//  Copyright (c) 2015年 Stephen Zhuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SZUser : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * userid;
@property (nonatomic) int32_t totalCombat;

@end

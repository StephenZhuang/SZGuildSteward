//
//  SZHero.h
//  SZGuildSteward
//
//  Created by Stephen Zhuang on 15/4/20.
//  Copyright (c) 2015年 Stephen Zhuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SZHero : NSManagedObject

@property (nonatomic, retain) NSString * heroid;
@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSString * name;

@end

//
//  SZHeroCollectionViewCell.m
//  SZGuildSteward
//
//  Created by Stephen Zhuang on 15/4/21.
//  Copyright (c) 2015年 Stephen Zhuang. All rights reserved.
//

#import "SZHeroCollectionViewCell.h"

@implementation SZHeroCollectionViewCell
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [self.selectButton setSelected:selected];
}
@end

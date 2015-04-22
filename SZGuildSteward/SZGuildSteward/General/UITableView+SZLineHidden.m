//
//  UITableView+SZLineHidden.m
//  SZGuildSteward
//
//  Created by Stephen Zhuang on 15/4/22.
//  Copyright (c) 2015年 Stephen Zhuang. All rights reserved.
//

#import "UITableView+SZLineHidden.h"

@implementation UITableView (SZLineHidden)
- (void)setExtrueLineHidden
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    [view setBackgroundColor:[UIColor clearColor]];
    [self setTableFooterView:view];
}
@end

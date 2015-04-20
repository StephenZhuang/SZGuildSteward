//
//  SZUser.h
//  SZGuildSteward
//
//  Created by Stephen Zhuang on 15/4/20.
//  Copyright (c) 2015年 Stephen Zhuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SZSquad;

@interface SZUser : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * userid;
@property (nonatomic) int32_t totalCombat;
@property (nonatomic, retain) NSOrderedSet *squads;
@end

@interface SZUser (CoreDataGeneratedAccessors)

- (void)insertObject:(SZSquad *)value inSquadsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromSquadsAtIndex:(NSUInteger)idx;
- (void)insertSquads:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeSquadsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInSquadsAtIndex:(NSUInteger)idx withObject:(SZSquad *)value;
- (void)replaceSquadsAtIndexes:(NSIndexSet *)indexes withSquads:(NSArray *)values;
- (void)addSquadsObject:(SZSquad *)value;
- (void)removeSquadsObject:(SZSquad *)value;
- (void)addSquads:(NSOrderedSet *)values;
- (void)removeSquads:(NSOrderedSet *)values;
@end

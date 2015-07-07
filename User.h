//
//  User.h
//  MyGymApp
//
//  Created by Gamaliel Tellez on 7/7/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject, WorkoutSession;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * birthdate;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * userImage;
@property (nonatomic, retain) NSNumber * lightestWeight;
@property (nonatomic, retain) NSNumber * heaviestWeight;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSOrderedSet *workoutsessions;
@property (nonatomic, retain) NSOrderedSet *weights;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)insertObject:(WorkoutSession *)value inWorkoutsessionsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromWorkoutsessionsAtIndex:(NSUInteger)idx;
- (void)insertWorkoutsessions:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeWorkoutsessionsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInWorkoutsessionsAtIndex:(NSUInteger)idx withObject:(WorkoutSession *)value;
- (void)replaceWorkoutsessionsAtIndexes:(NSIndexSet *)indexes withWorkoutsessions:(NSArray *)values;
- (void)addWorkoutsessionsObject:(WorkoutSession *)value;
- (void)removeWorkoutsessionsObject:(WorkoutSession *)value;
- (void)addWorkoutsessions:(NSOrderedSet *)values;
- (void)removeWorkoutsessions:(NSOrderedSet *)values;
- (void)insertObject:(NSManagedObject *)value inWeightsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromWeightsAtIndex:(NSUInteger)idx;
- (void)insertWeights:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeWeightsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInWeightsAtIndex:(NSUInteger)idx withObject:(NSManagedObject *)value;
- (void)replaceWeightsAtIndexes:(NSIndexSet *)indexes withWeights:(NSArray *)values;
- (void)addWeightsObject:(NSManagedObject *)value;
- (void)removeWeightsObject:(NSManagedObject *)value;
- (void)addWeights:(NSOrderedSet *)values;
- (void)removeWeights:(NSOrderedSet *)values;
@end

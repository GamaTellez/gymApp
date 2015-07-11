//
//  User.h
//  MyGymApp
//
//  Created by Gamaliel Tellez on 7/11/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Weight, WorkoutSession;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * birthdate;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * heaviestWeight;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSNumber * lightestWeight;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * userImage;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSOrderedSet *weights;
@property (nonatomic, retain) NSOrderedSet *workoutsessions;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)insertObject:(Weight *)value inWeightsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromWeightsAtIndex:(NSUInteger)idx;
- (void)insertWeights:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeWeightsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInWeightsAtIndex:(NSUInteger)idx withObject:(Weight *)value;
- (void)replaceWeightsAtIndexes:(NSIndexSet *)indexes withWeights:(NSArray *)values;
- (void)addWeightsObject:(Weight *)value;
- (void)removeWeightsObject:(Weight *)value;
- (void)addWeights:(NSOrderedSet *)values;
- (void)removeWeights:(NSOrderedSet *)values;
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
@end

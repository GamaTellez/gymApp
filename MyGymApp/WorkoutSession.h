//
//  WorkoutSession.h
//  
//
//  Created by Gamaliel Tellez on 7/15/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exercise, User;

@interface WorkoutSession : NSManagedObject

@property (nonatomic, retain) NSDate * sessionDate;
@property (nonatomic, retain) NSDate * sessionEndTime;
@property (nonatomic, retain) NSString * sessionName;
@property (nonatomic, retain) NSDate * sessionStartTime;
@property (nonatomic, retain) NSDate * timeLength;
@property (nonatomic, retain) NSOrderedSet *exercises;
@property (nonatomic, retain) User *user;
@end

@interface WorkoutSession (CoreDataGeneratedAccessors)

- (void)insertObject:(Exercise *)value inExercisesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromExercisesAtIndex:(NSUInteger)idx;
- (void)insertExercises:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeExercisesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInExercisesAtIndex:(NSUInteger)idx withObject:(Exercise *)value;
- (void)replaceExercisesAtIndexes:(NSIndexSet *)indexes withExercises:(NSArray *)values;
- (void)addExercisesObject:(Exercise *)value;
- (void)removeExercisesObject:(Exercise *)value;
- (void)addExercises:(NSOrderedSet *)values;
- (void)removeExercises:(NSOrderedSet *)values;
@end

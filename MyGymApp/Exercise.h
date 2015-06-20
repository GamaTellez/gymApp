//
//  Exercise.h
//  
//
//  Created by Gamaliel Tellez on 6/20/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class BodyPart, Rep, WorkoutSession;

@interface Exercise : NSManagedObject

@property (nonatomic, retain) NSString * exerciseName;
@property (nonatomic, retain) NSString * exerciseDescription;
@property (nonatomic, retain) NSOrderedSet *bodyParts;
@property (nonatomic, retain) WorkoutSession *workoutSession;
@property (nonatomic, retain) NSOrderedSet *reps;
@end

@interface Exercise (CoreDataGeneratedAccessors)

- (void)insertObject:(BodyPart *)value inBodyPartsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromBodyPartsAtIndex:(NSUInteger)idx;
- (void)insertBodyParts:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeBodyPartsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInBodyPartsAtIndex:(NSUInteger)idx withObject:(BodyPart *)value;
- (void)replaceBodyPartsAtIndexes:(NSIndexSet *)indexes withBodyParts:(NSArray *)values;
- (void)addBodyPartsObject:(BodyPart *)value;
- (void)removeBodyPartsObject:(BodyPart *)value;
- (void)addBodyParts:(NSOrderedSet *)values;
- (void)removeBodyParts:(NSOrderedSet *)values;
- (void)insertObject:(Rep *)value inRepsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRepsAtIndex:(NSUInteger)idx;
- (void)insertReps:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeRepsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInRepsAtIndex:(NSUInteger)idx withObject:(Rep *)value;
- (void)replaceRepsAtIndexes:(NSIndexSet *)indexes withReps:(NSArray *)values;
- (void)addRepsObject:(Rep *)value;
- (void)removeRepsObject:(Rep *)value;
- (void)addReps:(NSOrderedSet *)values;
- (void)removeReps:(NSOrderedSet *)values;
@end

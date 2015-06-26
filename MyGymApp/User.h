//
//  User.h
//  
//
//  Created by Gamaliel Tellez on 6/25/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WorkoutSession;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * birthdate;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * userImage;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) NSOrderedSet *workoutsessions;
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
@end

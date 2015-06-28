//
//  UserController.h
//  MyGymApp
//
//  Created by Gamaliel Tellez on 5/21/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Exercise.h"
#import "WorkoutSession.h"
#import "BodyPart.h"





@interface ModelController : NSObject
@property (nonatomic, strong, readonly) NSArray *exercisesArray;
@property (nonatomic, strong) NSArray *workoutSessionsArray;
//@property (nonatomic, strong, readonly) NSArray *user;
@property (nonatomic, strong, readonly) User *user;
@property (nonatomic, strong) NSArray *currentWeekSessions;


+ (ModelController *)sharedInstance;

- (User *)createUserWithName:(NSString *)name birthDate:(NSString *)birthDate height:(NSNumber *)height weight:(NSNumber *)weight andPicture:(NSData *)userPicture gender:(NSString *)gender;

- (void)addExerciseWithName:(NSString *)name withDescription:(NSString *)description withBodyPartstTaget:(NSArray *)bodyParts andWorkoutSession:(WorkoutSession *)session;

- (void)createWorkoutSessionWithName:(NSString *)name withUser:(User *)user;

- (void)deleteSession:(WorkoutSession *)session;

- (void)deleteExercise:(Exercise *)exercise;

-(BodyPart *)createBodyPart:(NSString *)bodyPartName;

- (void)addRepToExerciseWithNumOfSets:(NSNumber *)sets withReps:(NSNumber *)reps andWeight:(NSNumber *)weight inExercise:(Exercise *)exercise;

- (void)deleteRep:(Rep *)rep;

- (NSArray *)numberOfTimesBodyPartWasWorkedOut;

- (NSArray *)bodyPartsArray;


@end



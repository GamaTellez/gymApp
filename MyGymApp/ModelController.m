//
//  UserController.m
//  MyGymApp
//
//  Created by Gamaliel Tellez on 5/21/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import "ModelController.h"
#import "Stack.h"
#import "User.h"
#import "WorkoutSession.h"

@interface ModelController ()


//@property (nonatomic, strong) NSArray *user;
@property (nonatomic, strong) User *user;

@end

@implementation ModelController
+(ModelController *)sharedInstance{
    static ModelController *sharedInstance = nil;
static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{
    sharedInstance = [[ModelController alloc] init];
//    sharedInstance.workOutLogsArray = [[NSArray alloc] init];

});
    return sharedInstance;
}

-(User *)user
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSArray *users = [[Stack sharedInstance].managedObjectContext executeFetchRequest:request error:nil];
    
    return [users lastObject];
    
}

- (NSArray *) exercisesArray {
    
    return [[Stack sharedInstance].managedObjectContext executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"Exercise"] error:nil];
}


- (NSArray *)workoutSessionsArray {
    
    return [[Stack sharedInstance].managedObjectContext executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"WorkoutSession"] error:nil];
}


#pragma mark - Create User Method

- (User *)createUserWithName:(NSString *)name birthDate:(NSString *)birthDate height:(NSNumber *)height weight:(NSNumber *)weight andPicture:(NSData *)userPicture gender:(NSString *)gender {
    
    User *user = [ModelController sharedInstance].user;
    
    if (!user) {
        user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    }

    user.name = name;
    user.birthdate = birthDate;
    user.height = height;
    user.weight = weight;
    user.userImage = userPicture;
    user.gender = gender;
    
    self.user = user;
    [self saveToCoreData];
    return self.user;
    
}

#pragma mark - create workOutsession

- (void)createWorkoutSessionWithName:(NSString *)name withUser:(User *)user {
    
    WorkoutSession *newWorkOutSession = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutSession" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    newWorkOutSession.sessionName = name;
    newWorkOutSession.sessionDate = [NSDate date];
    newWorkOutSession.user = user;
    NSDate *endDate = [[NSDate alloc] init];
    newWorkOutSession.sessionStartTime = [endDate dateByAddingTimeInterval:24.0f * 60.0f * 60.0f - 1.0f];

    [self saveToCoreData];
    
}


#pragma mark - delete session

- (void)deleteSession:(WorkoutSession *)session {
    
    [session.managedObjectContext deleteObject:session];
    [self saveToCoreData];

}

- (void)addExerciseWithName:(NSString *)name withDescription:(NSString *)description andBodyPartstTaget:(NSOrderedSet *)bodyPart {
    
    Exercise *newExercise = [NSEntityDescription insertNewObjectForEntityForName:@"Exercise" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    newExercise.exerciseName = name;
    newExercise.exerciseDescription = description;
    newExercise.bodyParts = bodyPart;

    [self saveToCoreData];

}


//- (WorkOutLogs *)createWorkOutLohWithBodyPartTargeted:(NSString *)bodyPartTargeted exerciseName:(NSString *)exerciseName weightUsed:(NSNumber *)weightUsed numOfReps:(NSNumber *)numOfReps andUser:(User *)user {
//    
//    WorkOutLogs *newWorkOutLog = [NSEntityDescription insertNewObjectForEntityForName:workoutLogsClass inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
//    newWorkOutLog.bodyPartTargeted = bodyPartTargeted;
//    newWorkOutLog.exerciseName = exerciseName;
//    newWorkOutLog.weightUsed = weightUsed;
//    newWorkOutLog.numOfreps = numOfReps;
//
//    [self saveToCoreData];
//    return newWorkOutLog;
//}

- (void)saveToCoreData {
    [[Stack sharedInstance].managedObjectContext save:nil];
}



@end

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
@property (nonatomic, strong) NSArray *exerciseArrayForWorkoutSession;

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


#pragma mark - Create User Method

-(User *)user
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSArray *users = [[Stack sharedInstance].managedObjectContext executeFetchRequest:request error:nil];
    
    return [users lastObject];
    
}


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

#pragma mark - workoutsession methods

- (void)createWorkoutSessionWithName:(NSString *)name withUser:(User *)user {
    
    WorkoutSession *newWorkOutSession = [NSEntityDescription insertNewObjectForEntityForName:@"WorkoutSession" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    newWorkOutSession.sessionName = name;
    newWorkOutSession.sessionDate = [NSDate date];
    newWorkOutSession.user = user;
    NSDate *endDate = [[NSDate alloc] init];
    newWorkOutSession.sessionStartTime = [endDate dateByAddingTimeInterval:24.0f * 60.0f * 60.0f - 1.0f];

    [self saveToCoreData];
    
}

- (NSArray *)workoutSessionsArray {
    
    return [[Stack sharedInstance].managedObjectContext executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"WorkoutSession"] error:nil];
}


- (void)deleteSession:(WorkoutSession *)session {
    
    [session.managedObjectContext deleteObject:session];
    [self saveToCoreData];

}


#pragma mark- exercises methods

- (void)addExerciseWithName:(NSString *)name withDescription:(NSString *)description withBodyPartstTaget:(NSArray *)bodyParts andWorkoutSession:(WorkoutSession *)session {
    
    Exercise *newExercise = [NSEntityDescription insertNewObjectForEntityForName:@"Exercise" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    newExercise.exerciseName = name;
    newExercise.exerciseDescription = description;
    newExercise.workoutSession = session;
    
    newExercise.bodyParts = [[NSOrderedSet alloc] initWithArray:bodyParts];
    
    [self saveToCoreData];
}

- (void)deleteExercise:(Exercise *)exercise{
    
    [exercise.managedObjectContext deleteObject:exercise];
    [self saveToCoreData];
    
}


#pragma mark - bodyparts

-(BodyPart *)createBodyPart:(NSString *)bodyPartName
{
    BodyPart *bodyPart = [NSEntityDescription insertNewObjectForEntityForName:@"BodyPart" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    bodyPart.bodyPartTargeted = bodyPartName;
    
    return bodyPart;
}


- (void)saveToCoreData {
    [[Stack sharedInstance].managedObjectContext save:nil];
}



@end

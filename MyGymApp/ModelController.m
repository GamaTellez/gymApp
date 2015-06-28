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
#import "Rep.h"
#import "Exercise.h"

@interface ModelController ()


//@property (nonatomic, strong) NSArray *user;
@property (nonatomic, strong) User *user;
//@property (nonatomic, strong) NSArray *exerciseArrayForWorkoutSession;

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
    //filtering for most recent one on top of tableview
    NSFetchRequest *recentSessionsRequest = [NSFetchRequest fetchRequestWithEntityName:@"WorkoutSession"];
    //recentSessionsRequest.fetchLimit = 20;
    NSArray *currentSessions = [[Stack sharedInstance].managedObjectContext executeFetchRequest:recentSessionsRequest error:nil];
    
    NSSortDescriptor *sortDescriptorByDate = [[NSSortDescriptor alloc] initWithKey:@"sessionDate" ascending:NO];
    
    NSArray *descriptorsArray = [NSArray arrayWithObjects:sortDescriptorByDate, nil];
    NSArray *sortedSessionsByDate = [currentSessions sortedArrayUsingDescriptors:descriptorsArray];
    
    return sortedSessionsByDate;
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

- (void)addRepToExerciseWithNumOfSets:(NSNumber *)sets withReps:(NSNumber *)reps andWeight:(NSNumber *)weight inExercise:(Exercise *)exercise {
    
    Rep *newRep = [NSEntityDescription insertNewObjectForEntityForName:@"Rep" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    newRep.numOfSets = sets;
    newRep.numOfReps = reps;
    newRep.weights = weight;
    newRep.exercise = exercise;
    
    [self saveToCoreData];
}
#pragma mark - Reps

- (void)deleteRep:(Rep *)rep {
    
    [rep.managedObjectContext deleteObject:rep];
    [self saveToCoreData];
    
}


#pragma mark - bodyparts

-(BodyPart *)createBodyPart:(NSString *)bodyPartName
{
    BodyPart *bodyPart = [NSEntityDescription insertNewObjectForEntityForName:@"BodyPart" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    bodyPart.bodyPartTargeted = bodyPartName;
    
    return bodyPart;
}


- (NSArray *)numberOfTimesBodyPartWasWorkedOut {
    
    NSFetchRequest *exerciseForBodyPartsFetch = [NSFetchRequest fetchRequestWithEntityName:@"Exercise"];
    NSArray *allExercisesArray = [[Stack sharedInstance].managedObjectContext executeFetchRequest:exerciseForBodyPartsFetch error:nil];
    NSMutableArray *bodyPartsData = [[NSMutableArray alloc] init];
    
    int trapsCounter = 0;
    int shouldersp = 0;
    int chest = 0;
    int biceps = 0;
    int forearm = 0;
    int abs = 0;
    int quads = 0;
    int calves = 0;
    int triceps = 0;
    int upperBack = 0;
    int lowerBack = 0;
    int glutes = 0;
    int hamstrings = 0;
    
//    __block NSArray *bodyPartsArray;
//    for (Exercise *exercise in allExercisesArray) {
//        bodyPartsArray = [[NSArray alloc] initWithArray:[exercise.bodyParts array]];
//    }
    for (Exercise *exercise in allExercisesArray) {
    
        for (BodyPart *bodyPart in exercise.bodyParts) {
                if ([bodyPart.bodyPartTargeted isEqual:@"Traps"])
                    trapsCounter ++;
                if ([bodyPart.bodyPartTargeted isEqual:@"Shoulders"])
                    shouldersp ++;
                if ([bodyPart.bodyPartTargeted isEqual:@"Chest"])
                    chest ++;
                if ([bodyPart.bodyPartTargeted isEqual:@"Biceps"])
                    biceps ++;
                if ([bodyPart.bodyPartTargeted isEqual:@"Forearm"])
                    forearm ++;
                if ([bodyPart.bodyPartTargeted isEqual:@"Abs"])
                    abs ++;
                if ([bodyPart.bodyPartTargeted isEqual:@"Quads"])
                    quads ++;
                if ([bodyPart.bodyPartTargeted isEqual:@"Calves"])
                    calves ++;
                if ([bodyPart.bodyPartTargeted isEqual:@"Triceps"])
                    triceps ++;
                if ([bodyPart.bodyPartTargeted isEqual:@"Upper Back"])
                    upperBack ++;
                if ([bodyPart.bodyPartTargeted isEqual:@"Lower Back"])
                    lowerBack ++;
                if ([bodyPart.bodyPartTargeted isEqual:@"Glutes"])
                    glutes ++;
                if ([bodyPart.bodyPartTargeted isEqual:@"Hamstrings"])
                    hamstrings ++;
            }
    }
//    NSLog(@" hamstrings %zd",hamstrings);
//    NSLog(@" glutes %zd",glutes);
//    NSLog(@" lowerBack %zd",lowerBack);
//    NSLog(@"upperBack %zd",upperBack);
//    NSLog(@"calves %zd",calves);
//    NSLog(@"quads %zd",quads);
//    NSLog(@"abs %zd",abs);
//    NSLog(@"forearm %zd",forearm);
//    NSLog(@"chest %zd",chest);
//    NSLog(@"biceps %zd",biceps);
//    NSLog(@"triceps %zd",triceps);
//    NSLog(@"shouldersp %zd",shouldersp);
//    NSLog(@"trapsCounter %zd",trapsCounter);
    [bodyPartsData addObject:[NSNumber numberWithInt:hamstrings]];
    [bodyPartsData addObject:[NSNumber numberWithInt:glutes]];
    [bodyPartsData addObject:[NSNumber numberWithInt:lowerBack]];
    [bodyPartsData addObject:[NSNumber numberWithInt:upperBack]];
    [bodyPartsData addObject:[NSNumber numberWithInt:calves]];
    [bodyPartsData addObject:[NSNumber numberWithInt:quads]];
    [bodyPartsData addObject:[NSNumber numberWithInt:abs]];
    [bodyPartsData addObject:[NSNumber numberWithInt:forearm]];
    [bodyPartsData addObject:[NSNumber numberWithInt:chest]];
    [bodyPartsData addObject:[NSNumber numberWithInt:biceps]];
    [bodyPartsData addObject:[NSNumber numberWithInt:triceps]];
    [bodyPartsData addObject:[NSNumber numberWithInt:shouldersp]];
    [bodyPartsData addObject:[NSNumber numberWithInt:trapsCounter]];
    
    return bodyPartsData;
}

#pragma mark -save to coredaata

- (void)saveToCoreData {
    [[Stack sharedInstance].managedObjectContext save:nil];
}
@end

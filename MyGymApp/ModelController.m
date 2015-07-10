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
    //recentSessionsRequest.fetchLimit = 7;
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
    newExercise.maxWeight = 0;
    
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
    
    
    
    if (newRep.weights > exercise.maxWeight) 
        exercise.maxWeight = newRep.weights;
        exercise.repsWithMaxWeight = newRep.numOfReps;
        exercise.setsWithMaxWeight = newRep.numOfSets;
    
    [self saveToCoreData];
}
#pragma mark - Reps

- (void)deleteRep:(Rep *)rep {
    
    [rep.managedObjectContext deleteObject:rep];
    [self saveToCoreData];
    
}


#pragma mark - bodyparts

-(NSArray *)bodyPartsArray {
    
    return  @[@"Traps",@"Shoulders" ,@"Chest",@"Biceps" ,@"Forearm" ,@"Abs" ,@"Quads" ,@"Calves",@"Triceps",@"Upper Back",@"Lower Back",@"Glutes" ,@"Hamstrings"];
}


- (NSArray *)bodyParts {
    
    return [[Stack sharedInstance].managedObjectContext executeFetchRequest:[NSFetchRequest fetchRequestWithEntityName:@"BodyPart"] error:nil];
}


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
    
    int traps = 0;
    int shoulders = 0;
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
                    traps ++;
                if ([bodyPart.bodyPartTargeted isEqual:@"Shoulders"])
                    shoulders ++;
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

    [bodyPartsData addObject:[NSNumber numberWithInt:traps]];
    [bodyPartsData addObject:[NSNumber numberWithInt:shoulders]];
    [bodyPartsData addObject:[NSNumber numberWithInt:chest]];
    [bodyPartsData addObject:[NSNumber numberWithInt:biceps]];
    [bodyPartsData addObject:[NSNumber numberWithInt:forearm]];
    [bodyPartsData addObject:[NSNumber numberWithInt:abs]];
    [bodyPartsData addObject:[NSNumber numberWithInt:quads]];
    [bodyPartsData addObject:[NSNumber numberWithInt:calves]];
    [bodyPartsData addObject:[NSNumber numberWithInt:triceps]];
    [bodyPartsData addObject:[NSNumber numberWithInt:upperBack]];
    [bodyPartsData addObject:[NSNumber numberWithInt:lowerBack]];
    [bodyPartsData addObject:[NSNumber numberWithInt:glutes]];
    [bodyPartsData addObject:[NSNumber numberWithInt:hamstrings]];
    
    return bodyPartsData;
}

- (NSArray *)allExercisesFetchForKey:(NSString *)bodyPartString {
    
    NSFetchRequest *exerciseForBodyPartsFetch = [NSFetchRequest fetchRequestWithEntityName:@"Exercise"];
    NSArray *allExercisesArray = [[Stack sharedInstance].managedObjectContext executeFetchRequest:exerciseForBodyPartsFetch error:nil];
    
    
    
    
    NSMutableArray *arrayWithFilteredExercises = [[NSMutableArray alloc] init];
    
    for (Exercise *exercise in allExercisesArray) {
        for (BodyPart *bodyPart in exercise.bodyParts) {
            if ([bodyPart.bodyPartTargeted isEqualToString:bodyPartString]) {
                [arrayWithFilteredExercises addObject:exercise];
            }
        }
    }
    
    NSSortDescriptor *sortDescriptorByMaxWeight = [[NSSortDescriptor alloc] initWithKey:@"maxWeight" ascending:NO];
    NSArray *sortedExercisesArray = [arrayWithFilteredExercises sortedArrayUsingDescriptors:@[sortDescriptorByMaxWeight]];

    
    return sortedExercisesArray;
    
}

#pragma mark -save to coredaata

- (void)saveToCoreData {
    [[Stack sharedInstance].managedObjectContext save:nil];
}
@end

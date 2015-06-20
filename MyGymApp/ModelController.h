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

+ (ModelController *)sharedInstance;

- (User *)createUserWithName:(NSString *)name birthDate:(NSString *)birthDate height:(NSNumber *)height weight:(NSNumber *)weight andPicture:(NSData *)userPicture gender:(NSString *)gender;


- (void)createWorkoutSessionWithName:(NSString *)name withUser:(User *)user;

- (void)deleteSession:(WorkoutSession *)session;

@end



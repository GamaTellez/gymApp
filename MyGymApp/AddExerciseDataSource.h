//
//  AddExerciseDataSource.h
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/22/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import  "WorkoutSession.h"

@interface AddExerciseDataSource : NSObject <UITableViewDataSource>

-(void)updateWithSession:(WorkoutSession *)session;

@end

//
//  WorkoutLogsVC.h
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/16/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutSession.h"

@interface AddExercisesVC : UIViewController
@property (strong, nonatomic) WorkoutSession *session;
@property (strong, nonatomic) IBOutlet UITextField *exerciseNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *bodyPartTextField;
@property (strong, nonatomic) IBOutlet UITextField *bodyPart2TextField;
@property (strong, nonatomic) IBOutlet UITextView *exerciseDescriptionTextField;
@property (strong, nonatomic) IBOutlet UILabel *exerciseNotesLabel;


@end
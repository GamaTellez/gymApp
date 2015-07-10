//
//  PopUpViewController.h
//  MyGymApp
//
//  Created by Gamaliel Tellez on 7/9/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"

@interface PopUpViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *popUpView;

@property (strong, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *workoutSessionLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *setsLabel;
@property (strong, nonatomic) IBOutlet UILabel *repsLabel;
@property (strong, nonatomic) IBOutlet UILabel *maxWeightLabel;



- (void)showInView:(UIView *)theView withExerciseName:(NSString *)exerciseName fromSession:(NSString *)session withMaxweight:(NSString *)maxWeight andwithDate:(NSDate *)date animated:(BOOL)animated;


@end

//
//  WorkoutLogsDetailVC.h
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/19/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercise.h"

@interface RepsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *numOfSetsTextField;
@property (strong, nonatomic) IBOutlet UITextField *numOfRepstextField;
@property (strong, nonatomic) IBOutlet UITextField *weightTextField;
@property (strong, nonatomic) Exercise *exercise;

@end

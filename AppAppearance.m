//
//  AppAppearance.m
//  MyGymApp
//
//  Created by Gamaliel Tellez on 7/2/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import "AppAppearance.h"
#import "AddExercisesVC.h"
#import "BarGraphVC.h"
#import "WorkOutSessionsViewController.h"

@implementation AppAppearance
//
+ (void)setAppAppearance {
  
    NSDictionary *textTitleOptions = @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.203 green:0.554 blue:1.000 alpha:1.000],
                                       NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Bold" size:20]
                                       };
    
    //navigation bar appearance
   // [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithWhite:0.271 alpha:1.000]];
    [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];
    
    [[UIToolbar appearance] setBackgroundColor:[UIColor colorWithWhite:0.271 alpha:1.000]];
    
    //bar items apperance
    [[UIBarButtonItem appearance] setTitleTextAttributes:textTitleOptions forState:UIControlStateNormal];

    //views apperance
    [[UIView appearanceWhenContainedIn:[AddExercisesVC class], nil] setBackgroundColor:[UIColor colorWithWhite:0.917 alpha:1.000]];
    [[UIView appearanceWhenContainedIn:[BarGraphVC class], nil] setBackgroundColor:[UIColor colorWithWhite:0.944 alpha:1.000]];
    
    [[UITableView appearance] setBackgroundColor:[UIColor colorWithRed:0.255 green:0.682 blue:0.976 alpha:1.000]];
    
    
    //textview in add exercises
    [[UITextView appearanceWhenContainedIn:[AddExercisesVC class], nil] setBackgroundColor:[UIColor whiteColor]];
    
    //textfields in addexercises vc
      [[UITextField appearance] setBorderStyle:UITextBorderStyleRoundedRect];
    [[UITextField appearance] setBackgroundColor:[UIColor whiteColor]];

}

//
@end

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
#import "ProfilleViewController.h"
#import "WorkOutSessionsViewController.h"
#import "RepsViewController.h"
#import "BarGraphVC.h"


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
    [[UIButton appearanceWhenContainedIn:[ProfilleViewController class], nil] setBackgroundColor:[UIColor clearColor]];

    //views apperance
//    [[UIView appearanceWhenContainedIn:[AddExercisesVC class], nil] setBackgroundColor:[UIColor colorWithWhite:0.944 alpha:1.000]];
//    [[UIView appearanceWhenContainedIn:[BarGraphVC class], nil] setBackgroundColor:[UIColor colorWithWhite:0.944 alpha:1.000]];
//    [[UIView appearanceWhenContainedIn:[ProfilleViewController class], nil] setBackgroundColor:[UIColor colorWithWhite:0.944 alpha:1.000]];
//    [[UIView appearanceWhenContainedIn:[RepsViewController class], nil] setBackgroundColor:[UIColor colorWithWhite:0.944 alpha:1.000]];
//    
    
//    //labels apperance
//    [UILabel appearanceWhenContainedIn:[BarGraphVC class], nil].backgroundColor = [UIColor colorWithWhite:0.398 alpha:1.000];
    
    
    //button in addexercisesr
//    [UIButton appearance].layer.cornerRadius = 10.0;
//    [UIButton appearance].backgroundColor = [UIColor colorWithRed:0.355 green:0.516 blue:1.000 alpha:1.000];
//    [UIButton appearance].tintColor = [UIColor blackColor];
    

    //textfields
    [[UITextField appearanceWhenContainedIn:[ProfilleViewController class], nil] setBackgroundColor:[UIColor clearColor]];


}

//
@end

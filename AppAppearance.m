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

@implementation AppAppearance
//
+ (void)setNavBarAppearance {
  
    NSDictionary *textTitleOptions = @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.046 green:0.255 blue:0.549 alpha:2.000],
                                       NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Bold" size:18]
                                       };
    
    //navigation bar appearance
   // [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:0.106 green:0.226 blue:0.500 alpha:1.000]];
    [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];
    
    [[UIToolbar appearance] setBackgroundColor:[UIColor colorWithRed:0.106 green:0.226 blue:0.500 alpha:1.000]];
    
    //bar items apperance
    [[UIBarButtonItem appearance] setTitleTextAttributes:textTitleOptions forState:UIControlStateNormal];

    //view apperance
    [[UIView appearanceWhenContainedIn:[AddExercisesVC class], nil] setBackgroundColor:[UIColor colorWithRed:0.276 green:0.144 blue:1.000 alpha:1.000]];
  
    [[UIView appearanceWhenContainedIn:[BarGraphVC class], nil] setBackgroundColor:[UIColor colorWithRed:0.276 green:0.144 blue:1.000 alpha:1.000]];
    
    
    

}

//
@end

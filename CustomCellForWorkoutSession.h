//
//  CustomCellForWorkoutSession.h
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/12/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomCellForWorkoutSessionDelegate;

@interface CustomCellForWorkoutSession : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *sessionNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *sessionDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *sessionLengthLabel;

//+ (NSString *)reuseIdentifier;

@property (nonatomic, weak) id<CustomCellForWorkoutSessionDelegate> delegate;


@end

@protocol CustomCellForWorkoutSessionDelegate <NSObject>

//method

@end







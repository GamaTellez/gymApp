//
//  BodypartExerciseCustomCell.h
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/29/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol BodypartExerciseCustomCellDelegate;

@interface BodypartExerciseCustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *exerciseWeightLabel;

@property (weak, nonatomic) id<BodypartExerciseCustomCellDelegate> delegate;


@end

@protocol BodypartExerciseCustomCellDelegate <NSObject>


@end


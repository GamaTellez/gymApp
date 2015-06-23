//
//  CustomerCellForRepsTableViewCell.h
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/23/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RepsCustomCellDelegate;

@interface RepsCustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *setsLabel;
@property (strong, nonatomic) IBOutlet UILabel *repsLabel;
@property (strong, nonatomic) IBOutlet UILabel *weightLabel;


@property (nonatomic, weak) id<RepsCustomCellDelegate> delegate;

@end

@protocol RepsCustomCellDelegate <NSObject>



@end






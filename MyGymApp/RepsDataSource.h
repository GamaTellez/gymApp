//
//  RepsDataSource.h
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/23/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RepsCustomCell.h"
#import "Exercise.h"


@interface RepsDataSource : NSObject <UITableViewDataSource, RepsCustomCellDelegate>

- (void)updateWithExercise:(Exercise *)exercise;


@end



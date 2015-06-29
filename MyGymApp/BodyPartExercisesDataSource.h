//
//  ExerciseOfBodyPartDataSource.h
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/29/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BodypartExerciseCustomCell.h"


@interface BodyPartExercisesDataSource : NSObject <UITableViewDataSource, UITableViewDelegate, BodypartExerciseCustomCellDelegate>


@property (nonatomic, strong) NSString *bodyPart;
@property (nonatomic, strong) NSArray *exercisesOfBP;



@end

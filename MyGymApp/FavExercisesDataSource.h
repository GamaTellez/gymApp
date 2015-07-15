//
//  FavExercisesDataSource.h
//  MyGymApp
//
//  Created by Gamaliel Tellez on 7/15/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FavExercisesDataSource : NSObject <UITableViewDataSource>
@property (nonatomic, strong) NSArray *favoriteExercisesArray;


@end

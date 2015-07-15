//
//  FavExercisesDataSource.m
//  MyGymApp
//
//  Created by Gamaliel Tellez on 7/15/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import "FavExercisesDataSource.h"
#import "ModelController.h"
#import "Exercise.h"

static NSString *favsExerciseCellID = @"favsExerciseCellID";

@implementation FavExercisesDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:favsExerciseCellID];
    
    Exercise *favExercise = self.favoriteExercisesArray[indexPath.row];
    cell.textLabel.text = favExercise.exerciseName; 
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    self.favoriteExercisesArray = [[NSArray alloc] initWithArray:[[ModelController sharedInstance] favoriteExercises]];
    return self.favoriteExercisesArray.count;
}



@end

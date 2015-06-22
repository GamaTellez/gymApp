//
//  AddExerciseDataSource.m
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/22/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import "AddExerciseDataSource.h"
#import "ModelController.h"

@implementation AddExerciseDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [ModelController sharedInstance].exercisesArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    }
    
    Exercise *newExercise = [ModelController sharedInstance].exercisesArray[indexPath.row];
    cell.textLabel.text = newExercise.exerciseName;
    
    if (newExercise.bodyParts.count > 0) {
        BodyPart * bodyPartOne = newExercise.bodyParts[0];
        BodyPart * bodyPartTwo = newExercise.bodyParts[1];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",bodyPartOne.bodyPartTargeted, bodyPartTwo.bodyPartTargeted];
    }
    
    return cell;
    
    
    
    
}

@end

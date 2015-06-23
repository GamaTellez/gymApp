//
//  AddExerciseDataSource.m
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/22/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import "AddExerciseDataSource.h"
#import "ModelController.h"
#import "AddExercisesVC.h"



@interface AddExerciseDataSource ()
@property (nonatomic, strong) WorkoutSession *workoutsession;
@end

@implementation AddExerciseDataSource


-(void)updateWithSession:(WorkoutSession *)session
{
    self.workoutsession = session;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.workoutsession.exercises.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"exerciseCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"exerciseCell"];
    }
    
    
    
    Exercise *newExercise = self.workoutsession.exercises[indexPath.row];
    cell.textLabel.text = newExercise.exerciseName;
    
    if (newExercise.bodyParts.count > 0) {
        BodyPart * bodyPartOne = newExercise.bodyParts[0];
        BodyPart * bodyPartTwo = newExercise.bodyParts[1];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",bodyPartOne.bodyPartTargeted, bodyPartTwo.bodyPartTargeted];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Exercise *newExercise = self.workoutsession.exercises[indexPath.row];
        [[ModelController sharedInstance] deleteExercise:newExercise];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
@end

//
//  ExerciseOfBodyPartDataSource.m
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/29/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import "BodyPartExercisesDataSource.h"
#import "Exercise.h"
#import "ModelController.h"
#import "Rep.h"



@implementation BodyPartExercisesDataSource


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //BodypartExerciseCustomCell *cell = [BodypartExerciseCustomCell new];
    BodypartExerciseCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bodypartExerciseCustomCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[BodypartExerciseCustomCell alloc] init];
    }
    Exercise *newExercise = self.exercisesOfBP[indexPath.row];
    cell.exerciseNameLabel.text = newExercise.exerciseName;
    int newWeight = 0;
    int maxWeight = 0;
    for (Rep *rep in newExercise.reps) {
        newWeight = [rep.weights intValue];
        if   (newWeight > maxWeight) {
            maxWeight = newWeight;
        }
    }
    cell.exerciseWeightLabel.text = [NSString stringWithFormat:@"%i", maxWeight];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.exercisesOfBP = [[NSArray alloc] initWithArray:[[ModelController sharedInstance] allExercisesFetchForKey:self.bodyPart]];
    NSLog(@"%lu", (unsigned long)self.exercisesOfBP.count);
    
    return self.exercisesOfBP.count;
    
    
}



@end

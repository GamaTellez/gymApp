//
//  RepsDataSource.m
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/23/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import "RepsDataSource.h"
#import "Rep.h"
#import "Exercise.h"


@interface RepsDataSource ()
@property (nonatomic, strong) Exercise *exercise;
@end


@implementation RepsDataSource

- (void)updateWithExercise:(Exercise *)exercise {
    
    self.exercise = exercise;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.exercise.reps.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RepsCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"repsCustomCell"];
    
    if (!cell) {
        cell = [[RepsCustomCell alloc] init];
    }
    Rep *newRep = self.exercise.reps[indexPath.row];
    cell.repsLabel.text = [newRep.numOfReps stringValue];
    cell.setsLabel.text = [newRep.numOfSets stringValue];
    cell.weightLabel.text = [newRep.weights stringValue];
    
    return cell;
    
}
//
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete)
//    {
//        Rep *rep = [ModelController sharedInstance].exercisesArray[indexPath.row];
//        [[ModelController sharedInstance] deleteExercise:exercise];
//        
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//}



@end






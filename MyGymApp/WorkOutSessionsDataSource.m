//
//  WorkOutLogsDataSource.m
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/1/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import "WorkOutSessionsDataSource.h"
#import "WorkoutSession.h"
#import "ModelController.h"
#import "AddExercisesVC.h"

static NSString *cellID = @"sessionCell";

@implementation WorkOutSessionsDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [ModelController sharedInstance].workoutSessionsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCellForWorkoutSession *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[CustomCellForWorkoutSession alloc] init];
    }
    
    WorkoutSession *workoutSession = [ModelController sharedInstance].workoutSessionsArray[indexPath.row];
    cell.sessionNameLabel.text = workoutSession.sessionName;
    
    NSString *dateString = [NSDateFormatter localizedStringFromDate:workoutSession.sessionDate
                                                          dateStyle:NSDateFormatterFullStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    cell.sessionDateLabel.text = dateString;
   // cell.sessionLengthLabel.text = @"fdfdfdffd";
    return cell;
}



-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        WorkoutSession *session = [ModelController sharedInstance].workoutSessionsArray[indexPath.row];
        
        [[ModelController sharedInstance] deleteSession:session];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end













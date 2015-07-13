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
    
    if (workoutSession.sessionStartTime == nil || workoutSession.sessionEndTime == nil) {
        cell.sessionLengthLabel.text = @"";
    } else {
       
        NSString *duration = [self calculateDuration:workoutSession.sessionStartTime secondDate:workoutSession.sessionEndTime];
        cell.sessionLengthLabel.text = duration;
    }
    
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

//calculate the time betwen sessionStarttime and sessionEndTime

- (NSString *)calculateDuration:(NSDate *)oldTime secondDate:(NSDate *)currentTime
{
    NSDate *date1 = oldTime;
    NSDate *date2 = currentTime;
    
    NSTimeInterval secondsBetween = [date2 timeIntervalSinceDate:date1];
    
    int hh = secondsBetween / (60*60);
    double rem = fmod(secondsBetween, (60*60));
    int mm = rem / 60;
    rem = fmod(rem, 60);
    int ss = rem;
    
    NSString *str = [NSString stringWithFormat:@"%02d:%02d:%02d",hh,mm,ss];
    
    return str;
}



//-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGPoint currentOffset = scrollView.contentOffset;
//    if (currentOffset.y > self.lastContentOffset.y)
//    {
//        NSLog(@"down");
//    }
//    else
//    {
//        NSLog(@"up");
//    }
//    self.lastContentOffset = currentOffset;
//}
//animating tableViewCells
//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    //seting yo the cat transformr
////    CATransform3D rotation;
////    
////    rotation = CATransform3DMakeRotation(90.0 * M_PI/180, 0.0, 0.7,0.4);
////    rotation.m34 = 1.0 / -600;
////    
////    //define the initial state, before animation
////    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
////    cell.layer.shadowOffset = CGSizeMake(10, 10);
////    cell.alpha = 0;
////    
////    cell.layer.transform = rotation;
////    cell.layer.anchorPoint = CGPointMake(0, 0.5);
////    
////    //define final state after animation and coomit the animation
////    [UIView beginAnimations:@"rotation" context:NULL];
////    [UIView setAnimationDuration:0.8];
////    cell.layer.transform = CATransform3DIdentity;
////    cell.alpha = 1;
////    cell.layer.shadowOffset = CGSizeMake(0,0);
////    [UIView commitAnimations];
//    
//    CGPoint currentOffset = tableView.contentOffset;
//    
//    if (currentOffset.y < self.lastContentOffset.y) {
//        
//        NSLog(@"dow");
//    } else  if ( currentOffset.y > self.lastContentOffset.y){
//        CATransform3D scalate;
//        scalate = CATransform3DMakeScale(10.0, 10.0, 10.0);
//        scalate.m34 = 1.0 / - 600;
//        
//        cell.layer.transform = scalate;
//        [UIView beginAnimations:@"scale" context:NULL];
//        [UIView setAnimationDuration:0.8];
//        cell.layer.transform = CATransform3DIdentity;
//        [UIView commitAnimations];
//        NSLog(@"up");
//    }
//    self.lastContentOffset = currentOffset;
//
////    
////    CATransform3D translation;
////    translation = CATransform3DMakeTranslation(10.0, 10.0, 10.0);
////    translation.m34 = 1.0 / -60;
////    
////    cell.layer.transform = translation;
////    cell.layer.shadowOffset = CGSizeMake(10, 10);
////    
////    [UIView beginAnimations:@"translation" context:NULL];
////    [UIView setAnimationDuration:0.8];
////    cell.layer.transform = CATransform3DIdentity;
////    cell.alpha = 1;
////    cell.layer.shadowOffset = CGSizeMake(0, 0);
////    [UIView commitAnimations];
////    
//
//}



@end













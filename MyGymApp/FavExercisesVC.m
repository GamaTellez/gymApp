//
//  FavExercisesVC.m
//  MyGymApp
//
//  Created by Gamaliel Tellez on 7/15/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import "FavExercisesVC.h"
#import "FavsExerciseGraphVC.h"
#import "ModelController.h"
#import "Exercise.h"

@interface FavExercisesVC () <UITableViewDelegate>
@property (nonatomic, strong) NSArray *favoriteExercises;
@end

@implementation FavExercisesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.favoriteExercises = [[NSArray alloc] initWithArray:[[ModelController sharedInstance] favoriteExercises]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqual:@"toGraphProgress"]) {
        NSIndexPath *indexPath = self.tableView.indexPathForSelectedRow;
        Exercise *newExercise = self.favoriteExercises[indexPath.row];
        FavsExerciseGraphVC *newGraphForExercise = [segue destinationViewController];
        newGraphForExercise.navigationItem.title = newExercise.exerciseName;
        newGraphForExercise.exercise = newExercise;
        NSLog(@"%@", newExercise.exerciseName);
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

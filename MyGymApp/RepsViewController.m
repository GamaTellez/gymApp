//
//  WorkoutLogsDetailVC.m
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/19/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import "RepsViewController.h"
#import "RepsDataSource.h"

@interface RepsViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RepsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RepsDataSource *dataSource = self.tableView.dataSource;
    [dataSource updateWithExercise:self.exercise];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

//
//  ViewController.m
//  MyGymApp
//
//  Created by Gamaliel Tellez on 5/21/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *profileButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    
    self.profileButton.image = [UIImage imageNamed:@"profileIcon"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  PopUpViewController.m
//  MyGymApp
//
//  Created by Gamaliel Tellez on 7/9/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import "PopUpViewController.h"

@interface PopUpViewController ()
@property (strong, nonatomic) IBOutlet UIButton *dissmissButton;
@property (strong, nonatomic) IBOutlet UILabel *staticLabelSets;
@property (strong, nonatomic) IBOutlet UILabel *staticLabelReps;
@property (strong, nonatomic) IBOutlet UIView *staticLabelMax;

@end

@implementation PopUpViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.view.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:.6];
    self.view.frame = [[UIScreen mainScreen] bounds];
    
    self.popUpView.backgroundColor = [UIColor colorWithWhite:0.841 alpha:1.000];
    self.popUpView.layer.cornerRadius = 8;
    self.popUpView.layer.shadowOpacity = 0.8;
    self.popUpView.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    
    self.exerciseNameLabel.layer.cornerRadius = 8;
    self.exerciseNameLabel.layer.borderWidth = 1.0;
    self.exerciseNameLabel.backgroundColor = [UIColor clearColor];
    
    self.workoutSessionLabel.layer.cornerRadius = 8;
    self.workoutSessionLabel.layer.borderWidth = 1.0;
    self.workoutSessionLabel.backgroundColor = [UIColor clearColor];
    
    self.staticLabelMax.backgroundColor = [UIColor clearColor];
    self.staticLabelReps.backgroundColor = [UIColor clearColor];
    self.staticLabelSets.backgroundColor = [UIColor clearColor];
    
    
    self.dateLabel.layer.cornerRadius = 8;
    self.dateLabel.layer.borderWidth = 1.0;
    self.dateLabel.backgroundColor = [UIColor clearColor];
    
    self.repsLabel.layer.cornerRadius = 8;
    self.repsLabel.layer.borderWidth = 1.0;
    self.repsLabel.backgroundColor = [UIColor clearColor];
    
    self.setsLabel.layer.cornerRadius = 8;
    self.setsLabel.layer.borderWidth = 1.0;
    self.setsLabel.backgroundColor = [UIColor clearColor];
    
    self.maxWeightLabel.layer.cornerRadius = 8;
    self.maxWeightLabel.layer.borderWidth = 1.0;
    self.maxWeightLabel.backgroundColor = [UIColor clearColor];
    
    self.dissmissButton.layer.cornerRadius = 10;
    self.dissmissButton.backgroundColor = [UIColor colorWithRed:0.141 green:0.443 blue:1.000 alpha:1.000];
    self.dissmissButton.tintColor = [UIColor blackColor];

    
    [super viewDidLoad];
}

- (void)showAnimate
{
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations:^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}

- (IBAction)closePopup:(id)sender {
    [self removeAnimate];
}

- (void)removeAnimate
{
    [UIView animateWithDuration:.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}


- (void)showInView:(UIView *)theView withExerciseName:(NSString *)exerciseName fromSession:(NSString *)session withMaxweight:(NSString *)maxWeight withReps:(NSString *)reps withSets:(NSString *)sets andwithDate:(NSDate *)date animated:(BOOL)animated {
    
 dispatch_async(dispatch_get_main_queue(), ^{
     [theView addSubview:self.view];
     self.exerciseNameLabel.text = exerciseName;
     self.workoutSessionLabel.text = session;
     NSString *dateString = [NSDateFormatter localizedStringFromDate:date
                                                           dateStyle:NSDateFormatterFullStyle
                                                           timeStyle:NSDateFormatterShortStyle];
     self.dateLabel.text = dateString;
     self.maxWeightLabel.text = maxWeight;
     self.repsLabel.text = reps;
     self.setsLabel.text = sets;
     
     if (animated) {
         [self showAnimate];
     }
 });
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

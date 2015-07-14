//
//  WorkoutLogsDetailVC.m
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/19/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import "RepsViewController.h"
#import "RepsDataSource.h"
#import "ModelController.h"

@interface RepsViewController () <UIPopoverControllerDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIButton *viewExerciseDescription;
@property (strong, nonatomic) UITextView *textViewForNotes;
@property (strong, nonatomic) UIView *viewForNotes;
@property (strong, nonatomic) IBOutlet UILabel *setsLabel;
@property (strong, nonatomic) IBOutlet UILabel *repsLabel;
@property (strong, nonatomic) IBOutlet UILabel *weightLabel;


@end

@implementation RepsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    RepsDataSource *dataSource = (RepsDataSource *)self.tableView.dataSource;
    [dataSource updateWithExercise:self.exercise];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.944 alpha:1.000];

    self.tableView.layer.borderColor = [[UIColor colorWithWhite:0.207 alpha:1.000] CGColor];
    self.tableView.layer.borderWidth = 1.0;
    //setting labels
    self.setsLabel.layer.cornerRadius = 8;
    self.setsLabel.layer.borderWidth = 1.0;
    self.setsLabel.backgroundColor = [UIColor clearColor];
    
    self.repsLabel.layer.cornerRadius = 8;
    self.repsLabel.layer.borderWidth = 1.0;
    self.repsLabel.backgroundColor = [UIColor clearColor];
    self.weightLabel.layer.cornerRadius = 8;
    self.weightLabel.layer.borderWidth = 1.0;
    self.weightLabel.backgroundColor = [UIColor clearColor];
    
    //setting savebuttton appearance
    self.saveButton.layer.cornerRadius = 10;
    self.saveButton.backgroundColor = [UIColor colorWithRed:0.141 green:0.443 blue:1.000 alpha:1.000];
    self.saveButton.tintColor = [UIColor blackColor];
    
    //set gesture recoginizer to dismiss notesTexview.
    UITapGestureRecognizer *dismissTextViewNotes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissLabelNotes:)];
    [self.view addGestureRecognizer:dismissTextViewNotes];

}
#pragma removing textviewnotes
- (void)dismissLabelNotes:(id)sender {
    
   
    [UIView animateWithDuration:0.4 animations:^{
        [self.viewForNotes setAlpha:0];
    } completion:^(BOOL finished) {
         [self.viewForNotes removeFromSuperview];
    }];

}


- (IBAction)viewExerciseDescriptionButtonTapped:(id)sender {
    self.viewForNotes = [[UIView alloc] initWithFrame:CGRectMake(25, 25, self.view.frame.size.width -60, 100)];
    self.textViewForNotes = [UITextView new];
    self.textViewForNotes.editable = NO;
    self.textViewForNotes.frame = CGRectMake(0, 0, self.viewForNotes.frame.size.width, self.viewForNotes.frame.size.height);
    self.textViewForNotes.text = self.exercise.exerciseDescription;
    self.textViewForNotes.backgroundColor = [UIColor colorWithWhite:0.920 alpha:1.000];
   
    self.viewForNotes.alpha = 0.0;
    self.viewForNotes.layer.cornerRadius = 5;
    self.viewForNotes.layer.borderWidth = 1.5f;
    self.viewForNotes.layer.borderColor = [[UIColor blackColor] CGColor];
    self.viewForNotes.layer.masksToBounds = YES;
    

    [self.viewForNotes addSubview:self.textViewForNotes];
    [self.view addSubview:self.viewForNotes];
    
    //Display the customView with animation
    [UIView animateWithDuration:0.4 animations:^{
        [self.viewForNotes setAlpha:1.0];
    } completion:^(BOOL finished) {}];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addSetButtonTapped:(id)sender {
  
    if ([self.numOfRepstextField.text  isEqual: @""] || [self.numOfSetsTextField.text isEqual:@"" ]|| [self.weightTextField.text isEqual:@""]) {
        
        UIAlertController *emptyFieldAlert = [UIAlertController alertControllerWithTitle:@"Missing Fields" message:@"All fields must be completed" preferredStyle:UIAlertControllerStyleActionSheet];
        [emptyFieldAlert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }]];
         [self.navigationController presentViewController:emptyFieldAlert animated:YES completion:nil];
         } else {
    
    [[ModelController sharedInstance] addRepToExerciseWithNumOfSets:[NSNumber numberWithDouble:[self.numOfSetsTextField.text doubleValue]] withReps:[NSNumber numberWithDouble:[self.numOfRepstextField.text doubleValue]] andWeight:[NSNumber numberWithDouble:[self.weightTextField.text doubleValue]] inExercise:self.exercise];
    [self.tableView reloadData];
    self.numOfRepstextField.text = @"";
    self.numOfSetsTextField.text = @"";
    self.weightTextField.text = @"";
         }
    [self.view endEditing:YES];
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

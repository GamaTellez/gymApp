//
//  WorkoutLogsVC.m
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/16/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import "AddExercisesVC.h"
#import "ModelController.h"
#import "BodyPart.h"
#import "RepsViewController.h"
#import "AddExerciseDataSource.h"


@interface AddExercisesVC () <UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) NSMutableArray *bodyParts;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *bodyPartsArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation AddExercisesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bodyPartTextField.inputView = self.pickerView;
    self.bodyPart2TextField.inputView = self.pickerView;
    
    AddExerciseDataSource *dataSource = self.tableView.dataSource;
    [dataSource updateWithSession:self.session];
    
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.bodyPartTextField.inputView = self.pickerView;
    self.bodyPart2TextField.inputView = self.pickerView;
    self.bodyPart2TextField.delegate = self;
    self.bodyPartTextField.delegate = self;
    
    self.bodyPartsArray = [[NSArray alloc] init];
    self.bodyPartsArray = @[@"Traps (trapezius)"
                            ,@"Shoulders (deltoids)"
                            ,@"Chest (pectoralis)"
                            ,@"Biceps (biceps brachii)"
                            ,@"Forearm (brachioradialis)"
                            ,@"Abs (rectus abdominis)"
                            ,@"Quads (quadriceps)"
                            ,@"Calves (gastrocnemius)"
                            ,@"Traps (trapezius)"
                            ,@"Triceps (triceps brachii)"
                            ,@"Upper Back"
                            ,@"Lower Back"
                            ,@"Glutes (gluteus maximus and medius)"
                            ,@"Quads (quadriceps)"
                            ,@"Hamstrings (biceps femoris)"
                            ,@"Calves (gastrocnemius)"
                            ];
    
    
     UITapGestureRecognizer *tapOutsideTextfields = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOutsideTextField:)];
    tapOutsideTextfields.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapOutsideTextfields];
 

}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    
    if (textField ==  self.bodyPartTextField)  {
        self.bodyPartTextField.text = self.bodyPartsArray[0];
    } else if (textField == self.bodyPart2TextField) {
        self.bodyPart2TextField.text = self.bodyPartsArray[1];
    }
}
//
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    return NO;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)saveButtonTapped:(id)sender {
   
    [self.navigationController resignFirstResponder];
    
    if ([self.exerciseNameTextField.text isEqual:@""]) {
        UIAlertController *requiredField = [UIAlertController alertControllerWithTitle:@"Exercise name required" message:@"Please enter exercises name before saving" preferredStyle:UIAlertControllerStyleActionSheet];
        [requiredField addAction:[UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }]];
        [self.navigationController presentViewController:requiredField animated:YES completion:nil];
    } else {
    
    //self.bodyParts = [[NSMutableArray alloc] init];
    
    BodyPart * bodyPartOne = [[ModelController sharedInstance] createBodyPart:self.bodyPartTextField.text];
    BodyPart * bodyPartTwo = [[ModelController sharedInstance] createBodyPart:self.bodyPart2TextField.text];
    
    NSArray *arrayOfBodyParts = @[bodyPartOne, bodyPartTwo];
    
    [[ModelController sharedInstance] addExerciseWithName:self.exerciseNameTextField.text withDescription:self.exerciseDescriptionTextField.text withBodyPartstTaget:arrayOfBodyParts andWorkoutSession:self.session];
    
//    NSOrderedSet *orderedBodyParts = [NSOrderedSet orderedSetWithArray:self.bodyParts];
    self.exerciseNameTextField.text = @"";
    self.exerciseDescriptionTextField.text = @"";
    }
    [self.tableView reloadData];
}

#pragma mark - picker view protocol methods
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.bodyPartsArray.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return self.bodyPartsArray[row];
}

- (void)handleTapOutsideTextField:(UITapGestureRecognizer *)tap {
    
    [self.view endEditing:YES];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (self.bodyPartTextField.isEditing == YES) {
        self.bodyPartTextField.text = [self.bodyPartsArray objectAtIndex:row];
    } if (self.bodyPart2TextField.isEditing == YES) {
        self.bodyPart2TextField.text = [self.bodyPartsArray objectAtIndex:row];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toExerciseDetail"]) {
        RepsViewController *reps = [[RepsViewController alloc] init];
        reps = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Exercise *exercise = self.session.exercises[indexPath.row];
        reps.navigationItem.title = exercise.exerciseName;
        reps.exercise = exercise;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}





@end

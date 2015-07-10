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
@property (strong, nonatomic) IBOutlet UIButton *saveButton;


@end

@implementation AddExercisesVC


- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.bodyPartTextField.inputView = self.pickerView;
    self.bodyPart2TextField.inputView = self.pickerView;
    //
    self.exerciseNotesLabel.layer.cornerRadius = 8;
    self.exerciseNotesLabel.layer.borderWidth = 1.0;
    self.exerciseNotesLabel.layer.borderColor = [[UIColor blackColor] CGColor];
    
    AddExerciseDataSource *dataSource = self.tableView.dataSource;
    [dataSource updateWithSession:self.session];
    
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    //setting border for textview
    self.exerciseDescriptionTextField.layer.borderColor = [[UIColor colorWithWhite:0.815 alpha:1.000]CGColor];
    self.exerciseDescriptionTextField.layer.borderWidth = 1.0;
    self.exerciseDescriptionTextField.layer.cornerRadius = 5;
    //setting button appearance
    self.saveButton.layer.cornerRadius = 10;
    self.saveButton.backgroundColor = [UIColor colorWithRed:0.141 green:0.443 blue:1.000 alpha:1.000];
    self.saveButton.tintColor = [UIColor blackColor];
    
    UIToolbar *toolBarForPicker = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.pickerView.frame.size.width, 44)];
    toolBarForPicker.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *doneButtonInBar = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPickerViewButton)];
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    toolBarForPicker.items = @[flexibleSpaceLeft ,doneButtonInBar];
    //[self.pickerView addSubview:toolBarForPicker];
    
    self.bodyPartTextField.inputView = self.pickerView;
    self.bodyPartTextField.inputAccessoryView = toolBarForPicker;
    //self.bodyPart2TextField.inputView = self.pickerView;
    //self.bodyPart2TextField.delegate = self;
    self.bodyPartTextField.delegate = self;
    
    self.bodyPartsArray = [[NSArray alloc] init];
    self.bodyPartsArray = [[ModelController sharedInstance] bodyPartsArray];
    
 
    
     UITapGestureRecognizer *tapOutsideTextfields = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOutsideTextField:)];
    tapOutsideTextfields.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapOutsideTextfields];
}

- (void) dismissPickerViewButton {
    [self.view endEditing:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    
//    if (textField ==  self.bodyPartTextField)  {
//        self.bodyPartTextField.text = self.bodyPartsArray[0];
//    } else if (textField == self.bodyPart2TextField) {
//        self.bodyPart2TextField.text = self.bodyPartsArray[1];
//    }
}
//
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    return NO;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma saveButton method

- (IBAction)saveButtonTapped:(id)sender {
   
    
    [self.navigationController resignFirstResponder];
    
    if ([self.exerciseNameTextField.text isEqual:@""] || [self.bodyPartTextField.text isEqual:@""]) {
        UIAlertController *requiredField = [UIAlertController alertControllerWithTitle:@"Missing required fields" message:@"Please pick one body part" preferredStyle:UIAlertControllerStyleActionSheet];
        [requiredField addAction:[UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }]];
        [self.navigationController presentViewController:requiredField animated:YES completion:nil];
    } else {
    
    //self.bodyParts = [[NSMutableArray alloc] init];
    
    BodyPart * bodyPartOne = [[ModelController sharedInstance] createBodyPart:self.bodyPartTextField.text];
    //BodyPart * bodyPartTwo = [[ModelController sharedInstance] createBodyPart:self.bodyPart2TextField.text];
    
    NSArray *arrayOfBodyParts = @[bodyPartOne];
    
    [[ModelController sharedInstance] addExerciseWithName:self.exerciseNameTextField.text withDescription:self.exerciseDescriptionTextField.text withBodyPartstTaget:arrayOfBodyParts andWorkoutSession:self.session];
    
    self.exerciseNameTextField.text = @"";
    self.exerciseDescriptionTextField.text = @"";
        self.bodyPartTextField.text = [self.bodyPartsArray objectAtIndex:[self.pickerView selectedRowInComponent:0]];
        
    //self.bodyPart2TextField.text = @"";
    
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

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
@property (nonatomic, strong) UIPickerView *favsExercisesPickerView;
@property (nonatomic, strong) NSArray *bodyPartsArray;
@property (nonatomic, assign) BOOL isFavorite;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UISwitch *favoriteSwitch;
@property (strong, nonatomic) IBOutlet UILabel *isFavoriteLabel;
@property (strong, nonatomic) IBOutlet UIButton *startSession;
@property (strong, nonatomic) IBOutlet UIButton *endSession;
@property (strong, nonatomic) IBOutlet UIButton *selectFromFavoritesButton;
@property (strong, nonatomic) NSArray *favoriteExercisesArray;

@end

@implementation AddExercisesVC

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}


- (IBAction)favoriteSwitchToggled:(id)sender {
    
   // self.favoriteSwitch.selected = !self.favoriteSwitch.selected;
    if ([self.favoriteSwitch isOn]) {
        self.isFavorite = YES;
        NSLog(@"%id", [self.favoriteSwitch isOn]);
    } else {
        self.isFavorite = NO;
        NSLog(@"%id", [self.favoriteSwitch isOn]);
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.favoriteSwitch setOn:NO animated:NO];
    //NSLog(@"%id", [self.favoriteSwitch isOn]);

    self.bodyPartTextField.inputView = self.pickerView;
    //self.bodyPart2TextField.inputView = self.pickerView;
    self.view.backgroundColor = [UIColor colorWithWhite:0.944 alpha:1.000];
    
    self.isFavoriteLabel.layer.cornerRadius = 8;
    self.isFavoriteLabel.layer.borderWidth = 1.0;
    self.isFavoriteLabel.layer.borderColor = [[UIColor blackColor] CGColor];

    self.selectFromFavoritesButton.layer.cornerRadius = 8;
    self.selectFromFavoritesButton.layer.borderWidth = 1.0;
    self.selectFromFavoritesButton.layer.shadowColor = [[UIColor grayColor] CGColor];
    
    
    
    self.exerciseNotesLabel.layer.cornerRadius = 8;
    self.exerciseNotesLabel.layer.borderWidth = 1.0;
    self.exerciseNotesLabel.layer.borderColor = [[UIColor blackColor] CGColor];
    
    self.tableView.layer.borderColor = [[UIColor colorWithWhite:0.207 alpha:1.000] CGColor];
    self.tableView.layer.borderWidth = 1.0;
    self.tableView.backgroundColor = [UIColor whiteColor];

    
    AddExerciseDataSource *dataSource = self.tableView.dataSource;
    [dataSource updateWithSession:self.session];
    
  
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
    //setting border for textview
    self.exerciseDescriptionTextField.layer.borderColor = [[UIColor colorWithWhite:0.815 alpha:1.000]CGColor];
    self.exerciseDescriptionTextField.layer.borderWidth = 1.0;
    self.exerciseDescriptionTextField.layer.cornerRadius = 5;
    self.exerciseDescriptionTextField.backgroundColor = [UIColor whiteColor];
    
    //setting up pickerview and itsdata
    self.favoriteExercisesArray = [[NSArray alloc] initWithArray:[[ModelController sharedInstance] favoriteExercises]];
    self.favsExercisesPickerView = [UIPickerView new
                                    ];
    //self.favsExercisesPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height)];
    self.favsExercisesPickerView.delegate = self;
    self.favsExercisesPickerView.dataSource = self;
    
    
    //setting button appearance
    self.saveButton.layer.cornerRadius = 10;
    self.saveButton.backgroundColor = [UIColor colorWithRed:0.141 green:0.443 blue:1.000 alpha:1.000];
    self.saveButton.tintColor = [UIColor blackColor];
    
    //start and end Session buttons apperance
    self.startSession.layer.cornerRadius = 10;
    self.startSession.backgroundColor = [UIColor colorWithRed:0.523 green:1.000 blue:0.398 alpha:1.000];
    self.startSession.tintColor = [UIColor blackColor];
    
    self.endSession.layer.cornerRadius = 10;
    self.endSession.backgroundColor = [UIColor colorWithRed:1.000 green:0.585 blue:0.549 alpha:1.000];
    self.endSession.tintColor = [UIColor blackColor];
    self.endSession.enabled = NO;
    
    UIToolbar *toolBarForPicker = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.pickerView.frame.size.width, 44)];
    toolBarForPicker.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *doneButtonInBar = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(dismissPickerViewButton)];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelToolBarButton:) ];
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    toolBarForPicker.items = @[cancel,flexibleSpaceLeft ,doneButtonInBar];
    //[self.pickerView addSubview:toolBarForPicker];
    
    self.exerciseNameTextField.inputAccessoryView = toolBarForPicker;
    self.bodyPartTextField.inputView = self.pickerView;
    self.bodyPartTextField.inputAccessoryView = toolBarForPicker;
    self.exerciseDescriptionTextField.inputAccessoryView = toolBarForPicker;
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

- (IBAction)selectFromFavsButton:(id)sender {
    
    self.exerciseNameTextField.inputView = self.favsExercisesPickerView;
    [self.exerciseNameTextField becomeFirstResponder];
}

- (void)cancelToolBarButton:(id)sender {
    if (self.exerciseNameTextField.isFirstResponder) {
        [self.exerciseNameTextField resignFirstResponder];
         self.exerciseNameTextField.inputView = nil;
    } else if (self.bodyPartTextField.isFirstResponder) {
        [self.bodyPartTextField resignFirstResponder];
    }
    
    self.exerciseNameTextField.text = @"";
    //self.bodyPartTextField.enabled = YES;
    self.bodyPartTextField.text = @"";
    //self.exerciseDescriptionTextField.editable = YES;
    self.exerciseDescriptionTextField.text = @"";
    self.favoriteSwitch.enabled = YES;
    [self.favoriteSwitch setOn:NO animated:YES];
   
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {

    if (self.exerciseNameTextField.isEditing == YES) {
        self.exerciseNameTextField.text = @"";
        self.bodyPartTextField.enabled = YES;
        self.bodyPartTextField.text = @"";
        self.exerciseDescriptionTextField.editable = YES;
        self.exerciseDescriptionTextField.text = @"";
        self.favoriteSwitch.enabled = YES;
        [self.favoriteSwitch setOn:NO animated:YES];
    }
}


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
    
    [[ModelController sharedInstance] addExerciseWithName:self.exerciseNameTextField.text withDescription:self.exerciseDescriptionTextField.text withBodyPartstTaget:arrayOfBodyParts isFavorite:self.isFavorite andWorkoutSession:self.session];
    
    self.exerciseNameTextField.text = @"";
    self.exerciseDescriptionTextField.text = @"";
    self.bodyPartTextField.text = @"";
    [self.favoriteSwitch setOn:NO animated:YES];
        self.favoriteSwitch.enabled = YES;
        self.isFavorite = NO;
    }
    [self resignFirstResponder];
    [self.tableView reloadData];
    
    if (self.tableView.contentSize.height > self.tableView.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
        [self.tableView setContentOffset:offset animated:YES];
    }
}

#pragma startSession and endSessions button methods
- (IBAction)startSessionButtonTapped:(id)sender {
    
    if (self.endSession.enabled == NO) {
        UIAlertController *startAlert = [UIAlertController alertControllerWithTitle:@"Starting session timing" message:@"About to start the time for the session" preferredStyle:UIAlertControllerStyleActionSheet];
        [startAlert addAction:[UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            self.session.sessionStartTime = [NSDate date];
            [[ModelController sharedInstance] saveToCoreData];
            
            self.startSession.enabled = NO;
            self.endSession.enabled = YES;
            
            
        }]];
        [startAlert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            
        }]];
        [self presentViewController:startAlert animated:YES completion:nil];
    }
    
}

- (IBAction)endSessionButtonTapped:(id)sender {
    
    if (self.startSession.enabled == NO) {
        UIAlertController *endAlert = [UIAlertController alertControllerWithTitle:@"Stoping session timing" message:@"About to stop the time for this session" preferredStyle:UIAlertControllerStyleActionSheet];
        [endAlert addAction:[UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            self.session.sessionEndTime = [NSDate date];
            [[ModelController sharedInstance] saveToCoreData];
             self.endSession.enabled = NO;
        }]];
        [endAlert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            
        }]];
        [self presentViewController:endAlert animated:YES completion:nil];
    }
   
    
}

#pragma mark - picker view protocol methods
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (self.exerciseNameTextField.isFirstResponder) {
        return self.favoriteExercisesArray.count;
    } else if (self.bodyPartTextField.isEditing == YES) {
    return self.bodyPartsArray.count;
    }
    return 0;

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (self.exerciseNameTextField.isFirstResponder) {
        
        Exercise *newExercise = self.favoriteExercisesArray[row];
        return newExercise.exerciseName;
        
    } else if (self.bodyPartTextField.isEditing == YES) {
        
    return self.bodyPartsArray[row];
    
    } else
        return nil;
}

- (void)handleTapOutsideTextField:(UITapGestureRecognizer *)tap {
    
    self.exerciseNameTextField.inputView = nil;
    [self.view endEditing:YES];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    

    if (self.exerciseNameTextField.isEditing == YES) {
        Exercise *newExercise = [self.favoriteExercisesArray objectAtIndex:[self.favsExercisesPickerView selectedRowInComponent:0]];
        self.exerciseNameTextField.text = newExercise.exerciseName;
        BodyPart *newBodyPart = newExercise.bodyParts[0];
        self.bodyPartTextField.text = newBodyPart.bodyPartTargeted;
        self.bodyPartTextField.enabled = NO;
        self.exerciseDescriptionTextField.text = newExercise.exerciseDescription;
        self.exerciseDescriptionTextField.editable = NO;
        [self.favoriteSwitch setOn:YES animated:YES];
        self.favoriteSwitch.enabled = NO;
        self.isFavorite = YES;

    
        NSLog(@"%@", newExercise.exerciseName);
    } else if (self.bodyPartTextField.isEditing == YES) {
            self.bodyPartTextField.text = [self.bodyPartsArray objectAtIndex:row];
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

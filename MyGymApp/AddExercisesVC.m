//
//  WorkoutLogsVC.m
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/16/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import "AddExercisesVC.h"
#import "ModelController.h"

@interface AddExercisesVC () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) NSMutableArray *bodyParts;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *bodyPartsArray;

@end

@implementation AddExercisesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bodyPartTextField.inputView = self.pickerView;
    self.bodyPart2TextField.inputView = self.pickerView;
    
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.bodyPartTextField.inputView = self.pickerView;
    self.bodyPart2TextField.inputView = self.pickerView;
    
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
                            ,@"Lats (latissimus dorsi)"
                            ,@"Triceps (triceps brachii)"
                            ,@"Middle Back (rhomboids)"
                            ,@"Lower Back"
                            ,@"Glutes (gluteus maximus and medius)"
                            ,@"Quads (quadriceps)"
                            ,@"Hamstrings (biceps femoris)"
                            ,@"Calves (gastrocnemius)"
                            ];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)saveButtonTapped:(id)sender {
    self.bodyParts = [[NSMutableArray alloc] init];
    [self.bodyParts addObject:self.bodyPartTextField.text];
    [self.bodyParts addObject:self.bodyPart2TextField.text];
    NSOrderedSet *orderedBodyParts = [NSOrderedSet orderedSetWithArray:self.bodyParts];

    [[ModelController sharedInstance] addExerciseWithName:self.exerciseNameTextField.text withDescription:self.exerciseDescriptionTextField.text withBodyPartstTaget:orderedBodyParts andWorkoutSession:self.session];

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
@end

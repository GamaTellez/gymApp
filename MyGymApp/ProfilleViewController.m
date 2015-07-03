//
//  ProfilleViewController.m
//  MyGymApp
//
//  Created by Gamaliel Tellez on 5/21/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import "ProfilleViewController.h"
#import "ModelController.h"
#import "Stack.h"
#import "User.h"



@interface ProfilleViewController () <UITextFieldDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIScrollViewDelegate,UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthDateTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UIImageView *userPictureImageView;

@property (strong, nonatomic) IBOutlet UITextField *genderTextField;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIPickerView *pickerView;

@property (strong, nonatomic) IBOutlet UIButton *buttonProfilePic;


@property (nonatomic, retain) NSArray *genderArray;
@property (nonatomic, retain) NSArray *ageArray;
@property (nonatomic, retain) NSArray *feetForHeight;
@property (nonatomic, retain) NSArray *inchesForHeight;
@property (nonatomic, retain) NSArray *poundsForWeight100s;
@property (nonatomic, retain) NSArray *poundsForWieght10s;
@property (nonatomic, retain) NSArray *poundsForWeight1s;
@property (nonatomic, retain) NSArray *poundsForWeighDecimals;

@end

@implementation ProfilleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    self.nameTextField.text = [ModelController sharedInstance].user.name;
    self.birthDateTextField.text = [ModelController sharedInstance].user.birthdate;
    self.weightTextField.text = [[ModelController sharedInstance].user.weight stringValue];
    self.heightTextField.text = [NSString stringWithFormat:@"%2@",[[ModelController sharedInstance].user.height stringValue]];
    self.userPictureImageView.image = [UIImage imageWithData:[ModelController sharedInstance].user.userImage];
    self.genderTextField.text = [ModelController sharedInstance].user.gender;
    
 
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
 
    
    //adding geture recognizer to dismisskeybaord if touch outside extfield
    UITapGestureRecognizer *tapOutsideTextfields = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOutsideTextField:)];
    tapOutsideTextfields.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapOutsideTextfields];
    
    //setting up picker view for profile info
   
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.pickerView.showsSelectionIndicator = YES;
    
    //toolbar for picker view
    UIToolbar *pickerViewToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.pickerView.frame.size.width, 44)];
    pickerViewToolBar.barStyle = UIBarStyleBlackOpaque;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonInPickerTapped:)];
    UIBarButtonItem *leftArrow = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back-32"] style:UIBarButtonItemStylePlain target:self action:@selector(moveToLastTextField:)];
    UIBarButtonItem *rightArrow = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Forward-32"] style:UIBarButtonItemStylePlain target:self action:@selector(moveToNextTextField:)];
    //images for toolbar buttons were gotten from https://icons8.com.
    
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    pickerViewToolBar.items = [[NSArray alloc] initWithObjects:leftArrow, rightArrow, flexibleSpaceLeft, doneButton,nil];
    //[self.pickerView addSubview:pickerViewToolBar];
    
    self.genderTextField.inputView  = self.pickerView;
    self.genderTextField.inputAccessoryView = pickerViewToolBar;
    self.birthDateTextField.inputView = self.pickerView;
    self.birthDateTextField.inputAccessoryView = pickerViewToolBar;
    self.heightTextField.inputView = self.pickerView;
    self.heightTextField.inputAccessoryView = pickerViewToolBar;


    self.genderArray = [[NSArray alloc] initWithObjects:@"Male", @"Female",nil];
    self.ageArray = [[NSArray alloc] initWithObjects:@"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39", @"40", @"41", @"42", @"43", @"44", @"45", @"46", @"47", @"48", @"49", @"50", @"51", @"52", @"53", @"54", @"55", @"56", @"57", @"58", @"59", @"60", @"61", @"63", @"64", @"65", @"66", @"67", @"68", @"69", @"70", @"80", @"81", @"82", @"85", @"86", @"87", @"88", @"89", @"90",nil];
    self.feetForHeight = [[NSArray alloc] initWithObjects:@"4", @"5", @"6", @"7", @"8", @"9", nil];
    self.inchesForHeight = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", nil];
    }

- (void)doneButtonInPickerTapped:(id)sender {
    [self.view endEditing:YES];
}

- (void)moveToNextTextField:(id)sender {
    if (self.genderTextField.editing == YES) {
        [self.birthDateTextField becomeFirstResponder];
    } else if (self.birthDateTextField.editing == YES) {
        [self.heightTextField becomeFirstResponder];
    } else if (self.heightTextField.isEditing == YES) {
        [self.weightTextField becomeFirstResponder];
    } else {
        [self.view endEditing:YES];
    }
}

- (void)moveToLastTextField:(id)sender {
    
    if (self.heightTextField.isEditing == YES) {
        [self.birthDateTextField becomeFirstResponder];
    } else if (self.birthDateTextField.isEditing == YES) {
        [self.genderTextField becomeFirstResponder];
    } else if (self.genderTextField.isEditing == YES) {
        [self.nameTextField becomeFirstResponder];
    }
}

- (IBAction)buttonProfilePicTapped:(id)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Select Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
           
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            [self presentViewController:picker animated:YES completion:nil];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil ]];

        
    } else {
       [alertController addAction:[UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
   
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
           
           
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Select Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [self presentViewController:picker animated:YES completion:nil];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil ]];
  
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        UIImage *image = [[UIImage alloc]init];
        image = info[UIImagePickerControllerEditedImage];
        self.userPictureImageView.image = image;
    }];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > 0 || scrollView.contentOffset.x < 0)
        scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification*)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect rect = self.view.frame;
    rect.size.height -= keyboardSize.height;
    
    if (!CGRectContainsPoint(rect, self.weightTextField.frame.origin))
    {
        CGPoint scrollPoint = CGPointMake(0.0, self.weightTextField.frame.origin.y - (keyboardSize.height + 50));
        [self.scrollView setContentOffset:scrollPoint animated:NO];
    } 
}

- (void)keyboardWillHide:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark - save/createUser

- (IBAction)saveButtonTapped:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
    
    [[ModelController sharedInstance] createUserWithName:self.nameTextField.text birthDate:self.birthDateTextField.text height:[NSNumber numberWithDouble:[self.heightTextField.text doubleValue]] weight:[NSNumber numberWithDouble:[self.weightTextField.text doubleValue]] andPicture:UIImageJPEGRepresentation(self.userPictureImageView.image, 0.0) gender:self.genderTextField.text];
   }


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}
- (void)handleTapOutsideTextField:(UITapGestureRecognizer *)tap {
    
    [self.view endEditing:YES];
    
}


- (IBAction)backButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark  - picker view delegate and data source methods
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (self.genderTextField.editing == YES) {
        return self.genderArray.count;
    } else if (self.birthDateTextField.editing == YES) {
        return self.ageArray.count;
    } else if (self.heightTextField.editing == YES) {
        if (component == 0) {
              return self.feetForHeight.count;
        } else {
            return  self.inchesForHeight.count;
        }
      
    } else if (self.weightTextField.editing == YES) {
        if (component == 0) {
            return self.poundsForWeight100s.count;
        } else if (component == 1){
              return self.poundsForWieght10s.count;
        } else {
            return self.poundsForWeight1s.count;
        }
    }
    return 0;

}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.pickerView reloadAllComponents];
    if (textField == self.genderTextField) {
        self.genderTextField.text = self.genderArray[0];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    if (self.genderTextField.editing == YES) {
        return 1;
    }else if (self.birthDateTextField.editing == YES) {
        return 1;
    }else if (self.heightTextField.editing == YES) {
        return 2;
    }else {
        return 0;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (self.genderTextField.editing == YES) {
        return self.genderArray[row];
    } else if (self.birthDateTextField.editing == YES) {
        return self.ageArray[row];
        
    } else if (self.heightTextField.editing == YES) {
        if (component == 0) {
            return self.feetForHeight[row];
        } else {
            return  self.inchesForHeight[row];
        }
    } else if (self.weightTextField.editing == YES) { 
        if (component == 0) {
            return self.poundsForWeight100s[row];
        } else if (component == 1) {
            return self.poundsForWieght10s[row];
        } else {
            return self.poundsForWeight1s[row];
        }
    }
    return nil;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
   
    if (self.genderTextField.editing == YES) {
           self.genderTextField.text = [self.genderArray objectAtIndex:[pickerView selectedRowInComponent:0]];
    } else if (self.birthDateTextField.editing == YES) {
         self.birthDateTextField.text = [self.ageArray objectAtIndex:[pickerView selectedRowInComponent:0]];
    } else if (self.heightTextField.editing == YES) {
        NSString *heightFeet = [[NSString alloc] init];
        heightFeet = [self.feetForHeight objectAtIndex:[pickerView selectedRowInComponent:0]];
        NSString *heighInches = [[NSString alloc] init];
        heighInches = [self.inchesForHeight objectAtIndex:[pickerView selectedRowInComponent:1]];
        self.heightTextField.text = [NSString stringWithFormat:@"%@.%@",heightFeet,heighInches];
    }
}


@end


















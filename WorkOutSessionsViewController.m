//
//  WorkOutLogsViewController.m
//  
//
//  Created by Gamaliel Tellez on 6/1/15.
//
//

#import "WorkOutSessionsViewController.h"
#import "ModelController.h"
#import "AddExercisesVC.h"
#import "User.h"



@interface WorkOutSessionsViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIAlertAction *saveAction;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *weightLabel;
@property (strong, nonatomic) IBOutlet UILabel *numOfSessionsToDateLabel;



@end

@implementation WorkOutSessionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Lift Buddy";
    self.view.backgroundColor = [UIColor colorWithWhite:0.835 alpha:1.000];
    self.profileImage.layer.borderColor = [[UIColor blackColor] CGColor];
    self.profileImage.layer.borderWidth = 1.0;
    self.tableView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.tableView.layer.borderWidth = 1.0;
    self.nameLabel.tintColor = [UIColor blackColor];
//    
////    
//    self.profileImage.image = [UIImage imageWithData:[ModelController sharedInstance].user.userImage];
//    self.nameLabel.text = [NSString stringWithFormat:@"Name: %@.",[ModelController sharedInstance].user.name];
//    self.weightLabel.text = [NSString stringWithFormat:@"Current Weight: %@ lbs.",[[ModelController sharedInstance].user.weight stringValue]];
//    
//    int sessionsCount = (int)[ModelController sharedInstance].workoutSessionsArray.count;
//    self.numOfSessionsToDateLabel.text = [NSString stringWithFormat:@"Sessions: %d", sessionsCount];
    
}

-(void)viewWillAppear:(BOOL)animated {
   
    if (![ModelController sharedInstance].user.userImage ||[ModelController sharedInstance].user.userImage == nil ) {
        self.profileImage.image = [UIImage imageNamed:@"profileIcon"];
    } else {
    self.profileImage.image = [UIImage imageWithData:[ModelController sharedInstance].user.userImage];
    }
    
    if (![ModelController sharedInstance].user.name || [ModelController sharedInstance].user.name == nil) {
        self.nameLabel.text = @"";
    } else {
    self.nameLabel.text = [NSString stringWithFormat:@"Name: %@.",[ModelController sharedInstance].user.name];
    }
    
    if (![ModelController sharedInstance].user || [ModelController sharedInstance].user == nil) {
        self.weightLabel.text = @"";
    } else {
            self.weightLabel.text = [NSString stringWithFormat:@"Current Weight: %@ lbs.",[[ModelController sharedInstance].user.weight stringValue]];
    }
    
    if ([ModelController sharedInstance].workoutSessionsArray.count == 0 || [ModelController sharedInstance].workoutSessionsArray == nil) {
        self.numOfSessionsToDateLabel.text = @"";
    } else {
    //int sessionsCount = (int)[ModelController sharedInstance].workoutSessionsArray.count;
    self.numOfSessionsToDateLabel.text =  [NSString stringWithFormat:@"Sessions: %lu", (unsigned long)[ModelController sharedInstance].workoutSessionsArray.count];
    }
    
    [self.tableView reloadData];
    [super viewWillAppear:YES];    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addWorkOutSessionButtonTapped:(id)sender {
    
    UIAlertController *addSession = [UIAlertController alertControllerWithTitle:@"Add Session Name" message:@"Please Enter Info" preferredStyle:UIAlertControllerStyleAlert];
    
    [addSession addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"enter session Name";
        
        //listening to changes in text view
        [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        textField.delegate = self;
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        
        }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        }];
    
   self.saveAction = [UIAlertAction actionWithTitle:@"Save session" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [[ModelController sharedInstance] createWorkoutSessionWithName:((UITextField *)addSession.textFields[0]).text withUser:[ModelController sharedInstance].user];
        [self.tableView reloadData];
       self.numOfSessionsToDateLabel.text = [NSString stringWithFormat:@"Sesions to date: %lu.",(unsigned long)[ModelController sharedInstance].workoutSessionsArray.count];
       
    }];
    self.saveAction.enabled = NO;
    [addSession addAction:cancelAction];
    [addSession addAction:self.saveAction];
     [self presentViewController:addSession animated:YES completion:nil];
   
}
#pragma mark - method to disable save action if no exercise name
//method to enable or disable save button to
-(void)textFieldDidChange :(UITextField *)theTextField{
    if ([theTextField.text  isEqual: @""]) {
        self.saveAction.enabled = NO;
    } else if ( theTextField.text.length > 0){
    //NSLog( @"text changed: %@", theTextField.text);
    self.saveAction.enabled = YES;
    }
}
#pragma mark - setting up next view with workoutsession
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"toSessionDetail"]) {
        //UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
       // AddExercisesVC *newVc = (AddExercisesVC *)navController.viewControllers[0];
        AddExercisesVC *newVc = [[AddExercisesVC alloc] init];
        newVc = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        WorkoutSession *session = [ModelController sharedInstance].workoutSessionsArray[indexPath.row];
        newVc.navigationItem.title = session.sessionName;
        newVc.session = session;
    }
}



@end

















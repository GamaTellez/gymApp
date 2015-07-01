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



@end

@implementation WorkOutSessionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    self.title = @"This Week Gym Sessions";
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addWorkOutSessionButtonTapped:(id)sender {
    
    UIAlertController *addSession = [UIAlertController alertControllerWithTitle:@"Add session Name" message:@"Please enter info" preferredStyle:UIAlertControllerStyleAlert];
    
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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.tableView reloadData];
    
}



@end

















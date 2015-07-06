//
//  BarGraphVC.m
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/28/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import "BarGraphVC.h"
#import "EColumnDataModel.h"
#import "EColumnChartLabel.h"
#import "EFloatBox.h"
#import "EColor.h"
#include <stdlib.h>
#import "ModelController.h"


#import "BodyPartExercisesDataSource.h"

static NSString *unit = @"";

@interface BarGraphVC ()

@property (strong, nonatomic) EColumnChart *eColumnChart;
//@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (strong, nonatomic) IBOutlet UILabel *bodyPartExercises;

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) EFloatBox *eFloatBox;

@property (nonatomic, strong) EColumn *eColumnSelected;
@property (nonatomic, strong) UIColor *tempColor;

@property (nonatomic, strong) NSArray *valueForBodyPartInGraph;

@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipeGraph;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipeGraph;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *stringBodyPart;
@property (strong, nonatomic) IBOutlet UILabel *exerciseNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *exerciseWeightLabel;


@end

@implementation BarGraphVC

#pragma -mark- ViewController Life Circle
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
    [super viewDidLoad];
    self.title = @"Bodyparts Info";
    
    
    
    
    self.bodyPartExercises.layer.cornerRadius = 8;
    self.bodyPartExercises.layer.borderColor = [[UIColor blackColor] CGColor];
    self.bodyPartExercises.layer.borderWidth = 1.0;

    self.exerciseNameLabel.layer.cornerRadius = 8;
    self.exerciseNameLabel.layer.borderWidth = 1.0;
    self.exerciseNameLabel.backgroundColor = [UIColor clearColor];
    
    self.exerciseWeightLabel.layer.cornerRadius = 8;
    self.exerciseWeightLabel.layer.borderWidth = 1.0;
    self.exerciseWeightLabel.backgroundColor = [UIColor clearColor];
//    NSMutableArray *temp = [NSMutableArray array];
//    for (int i = 0; i < 50; i++)
//    {
//        int value = arc4random() % 100;
//        EColumnDataModel *eColumnDataModel = [[EColumnDataModel alloc] initWithLabel:[NSString stringWithFormat:@"%d", i] value:value index:i unit:@"kWh"];
//        [temp addObject:eColumnDataModel];
//    }
//    _data = [NSArray arrayWithArray:temp];
    
   
    
    
    self.valueForBodyPartInGraph = [[NSArray alloc] init];
    self.valueForBodyPartInGraph = [[ModelController sharedInstance] numberOfTimesBodyPartWasWorkedOut];
    NSInteger index = 0;
    self.data = [[NSMutableArray alloc] init];
    
    for (NSString *bodyPartString in [[ModelController sharedInstance] bodyPartsArray]) {
        
        int value = [self.valueForBodyPartInGraph[index] intValue];
       // NSLog(@"%@", self.valueForBodyPartInGraph[index]);
        //NSLog(@"%d",value);
        EColumnDataModel *newEcolumnDataModel = [[EColumnDataModel alloc] initWithLabel:bodyPartString value:value index:index unit:@""];
        if ([newEcolumnDataModel.label isEqualToString:@"Hamstrings"] && newEcolumnDataModel.value == 0.0) {
            newEcolumnDataModel.value++;
        }
        index++;
       // NSLog(@"%@", newEcolumnDataModel.label);
       // NSLog(@"%f", newEcolumnDataModel.value);
        [self.data addObject:newEcolumnDataModel];
    }
    self.eColumnChart = [[EColumnChart alloc] initWithFrame:CGRectMake(50, 60, 300, 200)];
    //[_eColumnChart setNormalColumnColor:[UIColor purpleColor]];
    [self.eColumnChart setColumnsIndexStartFromLeft:YES];
    [self.eColumnChart setDelegate:self];
    [self.eColumnChart setDataSource:self];
    
    [self.eColumnChart setShowHighAndLowColumnWithColor:YES];
    
    
    [self.view addSubview:self.eColumnChart];
    
    
    self.rightSwipeGraph = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleRightSwipeGraph:)];
    self.rightSwipeGraph.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.rightSwipeGraph];
    
    self.leftSwipeGraph = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleLeftSwipeOnGraph:)];
    self.leftSwipeGraph.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:self.leftSwipeGraph];
}

- (void)handleRightSwipeGraph:(UISwipeGestureRecognizer *)rightSwipe {
    //NSLog(@"right");
    if (self.eColumnChart == nil) return;
    [self.eColumnChart moveLeft];
    

}

- (void)handleLeftSwipeOnGraph:(UISwipeGestureRecognizer*)leftSwipe {
    //NSLog(@"left");
    if (self.eColumnChart == nil) return;
    [self.eColumnChart moveRight];
    
}

- (void)viewWillAppear:(BOOL)animated {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark- EColumnChartDataSource

- (NSInteger)numberOfColumnsInEColumnChart:(EColumnChart *)eColumnChart
{
    return [self.data count];
}

- (NSInteger)numberOfColumnsPresentedEveryTime:(EColumnChart *)eColumnChart
{
    return 3;
}

- (EColumnDataModel *)highestValueEColumnChart:(EColumnChart *)eColumnChart
{
    EColumnDataModel *maxDataModel = nil;
    float maxValue = -FLT_MIN;
    for (EColumnDataModel *dataModel in self.data)
        
    {
        if (dataModel.value > maxValue)
        {
            maxValue = dataModel.value;
            maxDataModel = dataModel;
        }
    }
    return maxDataModel;
}

- (EColumnDataModel *)eColumnChart:(EColumnChart *)eColumnChart valueForIndex:(NSInteger)index
{
    if (index >= [self.data count] || index < 0) return nil;
    return [self.data objectAtIndex:index];
}

//- (UIColor *)colorForEColumn:(EColumn *)eColumn
//{
//    if (eColumn.eColumnDataModel.index < 5)
//    {
//        return [UIColor purpleColor];
//    }
//    else
//    {
//        return [UIColor redColor];
//    }
//
//}

#pragma -mark- EColumnChartDelegate
- (void)eColumnChart:(EColumnChart *)eColumnChart
     didSelectColumn:(EColumn *)eColumn
{
    //NSLog(@"Index: %ld  Value: %f", (long)eColumn.eColumnDataModel.index, eColumn.eColumnDataModel.value);
    
    if (self.eColumnSelected)
    {
        self.eColumnSelected.barColor = self.tempColor;
    }
    self.eColumnSelected = eColumn;
    self.tempColor = eColumn.barColor;
    eColumn.barColor = [UIColor blackColor];
    
   // self.valueLabel.text = (@"%@", eColumn.eColumnDataModel.label);
    //self.valueLabel.text = [NSString stringWithFormat:@"Number of times bodypart was worked: %@" ,[NSNumber numberWithFloat:eColumn.eColumnDataModel.value]];
    self.bodyPartExercises.text = [NSString stringWithFormat:@"%@ top exercises",eColumn.eColumnDataModel.label];
    
     BodyPartExercisesDataSource *dataSource =(BodyPartExercisesDataSource *)self.tableView.dataSource;
    dataSource.bodyPart = eColumn.eColumnDataModel.label;
    [self.tableView reloadData];
    NSLog(@"%@", dataSource.bodyPart);
}

- (void)eColumnChart:(EColumnChart *)eColumnChart
fingerDidEnterColumn:(EColumn *)eColumn
{
    /**The EFloatBox here, is just to show an example of
     taking adventage of the event handling system of the Echart.
     You can do even better effects here, according to your needs.*/
   // NSLog(@"Finger did enter %ld", (long)eColumn.eColumnDataModel.index);
    CGFloat eFloatBoxX = eColumn.frame.origin.x + eColumn.frame.size.width * 1.25;
    CGFloat eFloatBoxY = eColumn.frame.origin.y + eColumn.frame.size.height * (1-eColumn.grade);
    if (self.eFloatBox)
    {
        [self.eFloatBox removeFromSuperview];
        self.eFloatBox.frame = CGRectMake(eFloatBoxX, eFloatBoxY, self.eFloatBox.frame.size.width, self.eFloatBox.frame.size.height);
        [self.eFloatBox setValue:eColumn.eColumnDataModel.value];
        [eColumnChart addSubview:self.eFloatBox];
    }
    else
    {
        self.eFloatBox = [[EFloatBox alloc] initWithPosition:CGPointMake(eFloatBoxX, eFloatBoxY) value:eColumn.eColumnDataModel.value unit:@"kWh" title:@"Title"];
        self.eFloatBox.alpha = 0.0;
        [eColumnChart addSubview:self.eFloatBox];
        
    }
    eFloatBoxY -= (_eFloatBox.frame.size.height + eColumn.frame.size.width * 0.25);
    _eFloatBox.frame = CGRectMake(eFloatBoxX, eFloatBoxY, self.eFloatBox.frame.size.width, self.eFloatBox.frame.size.height);
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.eFloatBox.alpha = 1.0;
        
    } completion:^(BOOL finished) {
    }];
    
}

- (void)eColumnChart:(EColumnChart *)eColumnChart
fingerDidLeaveColumn:(EColumn *)eColumn
{
    //NSLog(@"Finger did leave %ld", (long)eColumn.eColumnDataModel.index);
    
}

- (void)fingerDidLeaveEColumnChart:(EColumnChart *)eColumnChart
{
    if (self.eFloatBox)
    {
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
            self.eFloatBox.alpha = 0.0;
            self.eFloatBox.frame = CGRectMake(self.eFloatBox.frame.origin.x, self.eFloatBox.frame.origin.y + self.eFloatBox.frame.size.height, self.eFloatBox.frame.size.width, self.eFloatBox.frame.size.height);
        } completion:^(BOOL finished) {
            [self.eFloatBox removeFromSuperview];
            self.eFloatBox = nil;
        }];
        
    }
}
@end

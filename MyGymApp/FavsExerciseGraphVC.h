//
//  FavsExerciseGraphVC.h
//  
//
//  Created by Gamaliel Tellez on 7/15/15.
//
//

#import <UIKit/UIKit.h>
#import "ELineChart.h"
#import "Exercise.h"

@interface FavsExerciseGraphVC : UIViewController <ELineChartDataSource, ELineChartDelegate>

@property (strong, nonatomic) ELineChart *eLineChart;
@property (weak, nonatomic) IBOutlet UILabel *numberTaped;
@property (weak, nonatomic) Exercise *exercise;




@end

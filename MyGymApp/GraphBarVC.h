//
//  GraphBarVC.h
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/27/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "EColumnChart.h"


@interface GraphBarVC : UIViewController <EColumnChartDataSource, EColumnChartDelegate>
@property (nonatomic, strong) EColumnChart *eColumnChart;

@end

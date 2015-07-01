//
//  WorkOutLogsDataSource.h
//  MyGymApp
//
//  Created by Gamaliel Tellez on 6/1/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CustomCellForWorkoutSession.h"

@interface WorkOutSessionsDataSource : NSObject <UITableViewDataSource, UITableViewDelegate,CustomCellForWorkoutSessionDelegate, UIScrollViewDelegate>
@property (assign, nonatomic) CGPoint lastContentOffset;

@end

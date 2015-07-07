//
//  Rep.h
//  MyGymApp
//
//  Created by Gamaliel Tellez on 7/7/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exercise;

@interface Rep : NSManagedObject

@property (nonatomic, retain) NSNumber * numOfReps;
@property (nonatomic, retain) NSNumber * numOfSets;
@property (nonatomic, retain) NSDate * restTime;
@property (nonatomic, retain) NSNumber * weights;
@property (nonatomic, retain) Exercise *exercise;

@end

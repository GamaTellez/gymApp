//
//  Rep.h
//  
//
//  Created by Gamaliel Tellez on 6/20/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exercise;

@interface Rep : NSManagedObject

@property (nonatomic, retain) NSNumber * numOfReps;
@property (nonatomic, retain) NSNumber * numOfSets;
@property (nonatomic, retain) NSNumber * weights;
@property (nonatomic, retain) NSDate * restTime;
@property (nonatomic, retain) Exercise *exercise;

@end

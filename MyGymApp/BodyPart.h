//
//  BodyPart.h
//  
//
//  Created by Gamaliel Tellez on 6/25/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Exercise;

@interface BodyPart : NSManagedObject

@property (nonatomic, retain) NSString * bodyPartTargeted;
@property (nonatomic, retain) Exercise *exercise;

@end

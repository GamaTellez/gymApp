//
//  Weight.h
//  MyGymApp
//
//  Created by Gamaliel Tellez on 7/9/15.
//  Copyright (c) 2015 Gamaliel Tellez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Weight : NSManagedObject

@property (nonatomic, retain) NSData * imageForWeight;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) User *user;

@end

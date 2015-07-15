//
//  Weight.h
//  
//
//  Created by Gamaliel Tellez on 7/15/15.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Weight : NSManagedObject

@property (nonatomic, retain) NSData * imageForWeight;
@property (nonatomic, retain) NSNumber * weight;
@property (nonatomic, retain) User *user;

@end

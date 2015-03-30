//
//  TaskModel.h
//  ToDo List
//
//  Created by Ricardo Z Charf on 3/27/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Loader.h"

@interface Task : NSManagedObject

@property (nonatomic, retain) NSDate * conclusionDate;
@property (nonatomic, retain) NSNumber * continuous;
@property (nonatomic, retain) NSNumber * difficulty;
@property (nonatomic, retain) NSNumber * finished;
@property (nonatomic, retain) NSNumber * fun;
@property (nonatomic, retain) NSDate * initialDate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * repeatTime;
@property (nonatomic, retain) NSNumber * urgent;
@property (nonatomic) NSNumber* priority;

- (NSString *) description;

- (NSComparisonResult)compareByPriority:(Task *)otherObject;

- (NSComparisonResult)compareByDate:(Task *)otherObject;

-(int) compareTaskByID:(Task *) anotherTask;

-(void) updatePriority;

@end

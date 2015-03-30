//
//  Loader.h
//  ToDo List
//
//  Created by Ricardo Z Charf on 3/25/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Task.h"

@class Task;

@interface Loader : NSObject
#pragma mark Properties
@property (nonatomic) NSDate * lastSavedDate;
@property (readonly, nonatomic) NSManagedObjectContext *managedObjectContext;
#pragma mark Methods

/**
 This method saves the current context holded by the loader.
 **/
-(void)saveTasksStates;

/**
 @return An array with all tasks saved.
 **/
-(NSMutableArray*)loadTasksFromDataBase;

/**
 Creates new task. Autommaticaly saves to memory.
 @return Return a new  nonfinished task, with the desired parameters.
 **/
-(Task*)createTaskWithName:(NSString*)name  withInitialDate:(NSDate*)initialDate withConclusionDate:(NSDate*) conlusionDate withDifficulty:(NSNumber*)difficulty withFun:(NSNumber*) fun isContinuous:(NSNumber*) continuous withRepeatTime:(NSDate*) repeatTime isUrgent:(NSNumber*)urgent;

/**
 Destroy task passed as argument and saves it to memory.
 */
-(void)destroyTask:(Task*)task;

/**
 Delete for ever given task as parameter frmo Data Base and memory
 @param task task pointer of task to be erased
 */
-(void)deleteTask:(Task*) task;
@end

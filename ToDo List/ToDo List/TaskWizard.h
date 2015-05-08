//
//  TaskWizard.h
//  ToDo List
//
//  Created by Caio Vinícius Piologo Véras Fernandes on 3/30/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface TaskWizard : NSObject

@property(nonatomic) Task *newtask;

-(id)init:(Loader *) loader;
/**
 Begins wizard with a task (edit mode)
 */
-(void) beginWithTask:(Task*)task;

/**
 Begins wizard by initializing the new task
 */
-(void) begin;
/**
 Cancels task creation
 */
-(void) cancel;
/**
 Finish creating task
 */
-(Task *) finish;
/**
 Adds name to task
 */
-(void) giveName:(NSString*)name;

/**
 Adds initial date to task
 */
-(void) giveInitialDate:(NSDate *)time;
/**
 Adds coclusion date to task
 */
-(void) giveConclusionDate:(NSDate *)time;

-(void) giveDifficulty:(NSNumber*)difficulty;

-(void) giveFun:(NSNumber*)fun;
/**
 Determines wether a task is being created or not
 */
-(BOOL) hasAlreadyBegun;

-(void) setNotification;

-(void) createUrgentNotification;

@end

//
//  Organizer.h
//  ToDo List
//
//  Created by Caio Vinícius Piologo Véras Fernandes on 3/25/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface Organizer : NSObject
@property (nonatomic) TaskWizard * taskWizard;
@property NSDate *lastDateOrganized;
@property NSMutableArray *taskList;

+ (id)getInstace;

-(id) init;

-(void) updateTasks:(int)priority;

-(NSMutableArray *) getListByPriority;

-(NSMutableArray *) getListByDate;

-(void) addTaskToList:(Task *) task;

-(void) removeTask:(NSManagedObjectID *) identification;

-(void) saveEnviroment;

-(void) finishTask:(Task *)task;

-(Task *)getTask:(NSManagedObjectID *)identification;

@end

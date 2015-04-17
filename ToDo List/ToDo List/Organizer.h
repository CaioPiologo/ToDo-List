//
//  Organizer.h
//  ToDo List
//
//  Created by Caio Vinícius Piologo Véras Fernandes on 3/25/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"
#import "TaskWizard.h"

@interface Organizer : NSObject
@property (nonatomic) TaskWizard * taskWizard;
@property (nonatomic)NSDate *lastDateOrganized;
@property (nonatomic)NSMutableArray *taskList;

+ (id)getInstace;

-(id) init;

-(NSArray *) updateTasksByPriority;

-(NSArray *) updateTasksByDate;

-(NSMutableArray *) getListByPriority;

-(NSMutableArray *) getListByDate;

-(void) addTaskToList:(Task *) task;

-(void) removeTask:(NSManagedObjectID *) identification;

-(void) saveEnviroment;

-(void) finishTask:(Task *)task;

-(Task *)getTask:(NSManagedObjectID *)identification;

-(NSArray*)getTodayTasks;

-(NSArray*)getTomorrowTasks;

-(NSArray*)getAfterTomorrowTasks;

-(NSArray*)getLaterTasks;

-(NSArray*)getPendingTasks;

-(NSMutableArray*) getArrayForWatch;

@end

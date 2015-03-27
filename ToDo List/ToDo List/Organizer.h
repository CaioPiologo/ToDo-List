//
//  Organizer.h
//  ToDo List
//
//  Created by Caio Vinícius Piologo Véras Fernandes on 3/25/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface Hermes : NSObject

@property NSDate *lastDateOrganized;
@property NSMutableArray *taskList;

-(id) init;

-(void) updateTasks:(int)priority;

-(NSMutableArray *) getListByPriority;

-(NSMutableArray *) getListByDate;

-(void) addTaskToList:(Task *) task;

-(void) removeTask:(NSNumber *) identification;

-(void) saveEnviroment;

-(void) finishTask:(Task *)task;

@end

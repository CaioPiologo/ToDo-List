//
//  Organizer.m
//  ToDo List
//
//  Created by Caio Vinícius Piologo Véras Fernandes on 3/25/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import "Organizer.h"

@implementation Organizer

/**
 Initializes class properties
 */
-(id) init{
    self = [super init];
    
    if(self){
        self.lastDateOrganized = [[NSDate alloc] init];
        self.taskList = [[NSMutableArray alloc] init];
    }
    return self;
}
/**
 Keeps list updated constantly
 */
-(void) updateTasks:(int)priority{
    //updates each task priority
    for (Task *task in _taskList)
        [task updatePriority];
    //returns the list organized by priorities or dates
    if(priority == 1)
        _taskList = self.getListByPriority;
    else
        _taskList = self.getListByDate;
    [self performSelector:@selector(updateTasks:) withObject:self afterDelay:3600];
}

/**
 Sorts list by priority
 */
-(NSArray *) getListByPriority{
    NSArray *array = [[NSArray alloc] init];
    array = [_taskList sortedArrayUsingSelector:@selector(compareByPriority:)];
    return array;
}
/**
 Sorts list by date
 */
-(NSArray *) getListByDate{
    NSArray *array = [[NSArray alloc] init];
    array = [_taskList sortedArrayUsingSelector:@selector(compareByDate:)];
    return array;
}

/**
 Adds new task to the list
 */
-(void) addTaskToList:(Task *) task{
    [_taskList addObject:task];
}

/**
 Marks a task as completed by the user
 */
-(void) finishTask:(Task *) task{
    task.finished = [NSNumber numberWithInt:1];
}

/**
 Finds and returns task by ID
 */
-(Task *)getTask:(NSManagedObjectID *)identification{
    for(Task *task in _taskList)
        if([task isID:identification] == 1){
            return task;
        }
    return nil;
}

/**
 Removes a task from the list
 */
-(void) removeTask:(NSManagedObjectID *) identification{
    [_taskList removeObject:[self getTask:identification]];
}

-(Task *)editTask:(NSManagedObjectID *) identification{
    Task *task = [self getTask:identification];
    
}


//-(void) saveEnviroment;

@end

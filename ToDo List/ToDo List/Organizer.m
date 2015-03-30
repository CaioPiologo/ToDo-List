//
//  Organizer.m
//  ToDo List
//
//  Created by Caio Vinícius Piologo Véras Fernandes on 3/25/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import "Organizer.h"
#import "Loader.h"
#import "Task.h"

@interface Organizer()
@property (nonatomic) Loader* loader;
@end
@implementation Organizer

#pragma mark Singleton Method(Static)
+ (id)getInstace {
    static Organizer *_organizerInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _organizerInstance = [[self alloc] init];
    });
    return _organizerInstance;
}

#pragma mark Other Methods(instance)

/**
 Initializes class properties
 */
-(id) init{
    self = [super init];
    
    if(self){
        self.lastDateOrganized = [[NSDate alloc] init];
        self.taskList = [[NSMutableArray alloc] init];
        self.loader = [[Loader alloc] init];
        self.taskWizard = [[TaskWizard alloc] init:self.loader];
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
-(void) finishTask:(NSManagedObjectID *) ID{
    Task *task = [self getTask:ID];
    task.finished = @1;
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

/**
 Saves list configuration
 */
-(void) saveEnviroment
{
    [self.loader saveTasksStates];
}



@end

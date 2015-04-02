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
        self.loader = [[Loader alloc] init];
        self.taskList = [self.loader loadTasksFromDataBase];
        self.taskWizard = [[TaskWizard alloc] init:self.loader];
    }
    return self;
}
/**
 Keeps list updated constantly by its priority
 */
-(NSArray *) updateTasksByPriority{
    //updates each task priority and urgency if it has passed its conclusion date
    for (Task *task in _taskList){
        [task updatePriority];
        if([task.conclusionDate compare:[NSDate date]] == NSOrderedDescending)
            task.urgent = @1;
        if([task.finished  isEqual: @1])
            [self.taskList removeObject:task];
    }
    //returns the list organized by priorities or dates
    [self.loader saveTasksStates];
    return self.getListByPriority;
}
/**
 Keeps list updated constantly by the date of its conclusion
 */
-(NSArray *) updateTasksByDate{
    //updates each task priority and urgency if it has passed its conclusion date
    for (Task *task in _taskList){
        [task updatePriority];
        if([task.conclusionDate compare:[NSDate date]] == NSOrderedAscending)
            task.urgent = @1;
        if([task.finished  isEqual: @1])
            [self.taskList removeObject:task];
    }
    //returns the list organized by priorities or dates
    [self.loader saveTasksStates];
    return self.getListByDate;
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
    Task *taskToBeRemoved = [self getTask:identification];
    if([taskToBeRemoved.urgent isEqual:@0])
    [[UIApplication sharedApplication] cancelLocalNotification:[taskToBeRemoved getNotification]];
    [_taskList removeObject:taskToBeRemoved];
    [self.loader deleteTask:taskToBeRemoved];
    [self saveEnviroment];
}

/**
 Saves list configuration
 */
-(void) saveEnviroment
{
    [self.loader saveTasksStates];
}

-(NSArray*)getTodayTasks
{
    NSMutableArray * auxiliaryArray = [[NSMutableArray alloc]init];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1;
    NSDateComponents* comp2;
    
    for (Task *t in self.taskList) {
        comp1 = [calendar components:unitFlags fromDate:t.conclusionDate];
        comp2 = [calendar components:unitFlags fromDate:[NSDate date]];

        if ([comp1 day]   == [comp2 day] && [comp1 month] == [comp2 month] && [comp1 year]  == [comp2 year])
        {
//            NSString *nome = t.name;
            [auxiliaryArray addObject:t];
        }
    }
    auxiliaryArray = [auxiliaryArray sortedArrayUsingSelector:@selector(compareByPriority:)];
    return auxiliaryArray;
}

-(NSArray*)getTomorrowTasks
{
    NSMutableArray * auxiliaryArray = [[NSMutableArray alloc]init];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1;
    NSDateComponents* comp2;
    
    for (Task *t in self.taskList) {
        comp1 = [calendar components:unitFlags fromDate:t.conclusionDate];
        comp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        
        if ([comp1 day]   == ([comp2 day]+1) && [comp1 month] == [comp2 month] && [comp1 year]  == [comp2 year])
        {
 //           NSString * nome = t.name;
            [auxiliaryArray addObject:t];
        }
    }
    auxiliaryArray = [auxiliaryArray sortedArrayUsingSelector:@selector(compareByPriority:)];
    return auxiliaryArray;
}

-(NSArray*)getAfterTomorrowTasks
{
    NSMutableArray * auxiliaryArray = [[NSMutableArray alloc]init];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1;
    NSDateComponents* comp2;
    
    for (Task *t in self.taskList) {
        comp1 = [calendar components:unitFlags fromDate:t.conclusionDate];
        comp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        
        if ([comp1 day]   == ([comp2 day]+2) && [comp1 month] == [comp2 month] && [comp1 year]  == [comp2 year])
        {
            [auxiliaryArray addObject:t];
        }
    }
    return auxiliaryArray;
}

-(NSArray*)getLaterTasks
{
    NSMutableArray * auxiliaryArray = [[NSMutableArray alloc]init];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    NSDateComponents* comp1;
    NSDateComponents* comp2;
    
    for (Task *t in self.taskList) {
        if([t.finished isEqualToNumber:@1])
        {
            continue;
        }
        comp1 = [calendar components:unitFlags fromDate:t.conclusionDate];
        comp2 = [calendar components:unitFlags fromDate:[NSDate date]];
        
        if ([comp1 day]   > ([comp2 day]+2) && [comp1 month] >= [comp2 month] && [comp1 year]  >= [comp2 year])
        {
            NSString * t2 = [t name];
            [auxiliaryArray addObject:t];
        }
    }
    return auxiliaryArray;
}



@end

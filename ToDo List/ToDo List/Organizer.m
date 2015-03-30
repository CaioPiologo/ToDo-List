//
//  Organizer.m
//  ToDo List
//
//  Created by Caio Vinícius Piologo Véras Fernandes on 3/25/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import "Organizer.h"

@implementation Hermes

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
    for (Task *task in _taskList)
        [task updatePriority];
    if(priority == 1)
        _taskList = self.getListByPriority;
    else
        _taskList = self.getListByDate;
    [self performSelector:@selector(updateTasks:) withObject:self afterDelay:3600];
}

/**
 Sorts array by priority or date
 */
-(NSArray *)mergeSort:(NSArray *)unsortedArray withPriority: (int)priority
{
    if ([unsortedArray count] < 2)
    {
        return unsortedArray;
    }
    long middle = ([unsortedArray count]/2);
    NSRange left = NSMakeRange(0, middle);
    NSRange right = NSMakeRange(middle, ([unsortedArray count] - middle));
    NSArray *rightArr = [unsortedArray subarrayWithRange:right];
    NSArray *leftArr = [unsortedArray subarrayWithRange:left];
    //Or iterate through the unsortedArray and create your left and right array
    //for left array iteration starts at index =0 and stops at middle, for right array iteration starts at midde and end at the end of the unsorted array
    NSArray *resultArray =[self merge:[self mergeSort:leftArr withPriority:priority] andRight:[self mergeSort:rightArr withPriority:priority] withPriority:priority];
    return resultArray;
}
-(NSArray *)merge:(NSArray *)leftArr andRight:(NSArray *)rightArr withPriority: (int) priority
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    int right = 0;
    int left = 0;
    while (left < [leftArr count] && right < [rightArr count])
    {
        //chooses type of ordering
        if(priority == 1){
            if ([[leftArr objectAtIndex:left] compareTasksByPriority:[rightArr objectAtIndex:right]] == -1)
                [result addObject:[leftArr objectAtIndex:left++]];
            else
                [result addObject:[rightArr objectAtIndex:right++]];
        } else {
            if ([[leftArr objectAtIndex:left] compareTasksByDate:[rightArr objectAtIndex:right]] == -1)
                [result addObject:[leftArr objectAtIndex:left++]];
            else
                [result addObject:[rightArr objectAtIndex:right++]];
        }
        
    }
    NSRange leftRange = NSMakeRange(left, ([leftArr count] - left));
    NSRange rightRange = NSMakeRange(right, ([rightArr count] - right));
    NSArray *newRight = [rightArr subarrayWithRange:rightRange];
    NSArray *newLeft = [leftArr subarrayWithRange:leftRange];
    newLeft = [result arrayByAddingObjectsFromArray:newLeft];
    return [newLeft arrayByAddingObjectsFromArray:newRight];
}
/**
 Sorts list by priority
 */
-(NSArray *) getListByPriority{
    NSMutableArray *priorities = [[NSMutableArray alloc] init];
    NSArray *array;
    for(Task *task in _taskList)
        [priorities addObject:task];
    array = [self mergeSort:priorities withPriority:1];
    return array;
}
/**
 Sorts list by date
 */
-(NSArray *) getListByDate{
    NSMutableArray *priorities = [[NSMutableArray alloc] init];
    NSArray *array;
    for(Task *task in _taskList)
        [priorities addObject:task];
    array = [self mergeSort:priorities withPriority:0];
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

//-(void) removeTask:(NSNumber *) identification;

//-(void) saveEnviroment;

@end

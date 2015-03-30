//
//  TaskModel.m
//  ToDo List
//
//  Created by Ricardo Z Charf on 3/27/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import "Task.h"
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Loader.h"

@implementation Task

@dynamic conclusionDate;
@dynamic continuous;
@dynamic difficulty;
@dynamic finished;
@dynamic fun;
@dynamic initialDate;
@dynamic name;
@dynamic repeatTime;
@dynamic urgent;

/**
 Updates priority through an algorithm
 */
-(void) updatePriority{
    NSDate *today = [NSDate date];
    NSTimeInterval dueTime = [self.conclusionDate timeIntervalSinceDate:self.initialDate];
    NSTimeInterval topPriority = (dueTime/3)*([self.difficulty intValue])/10;
    NSTimeInterval highPriority = (dueTime/2)*([self.difficulty intValue])/10;
    NSTimeInterval midPriority = (dueTime)*([self.difficulty intValue])/10;
    /*Algorithm calculates priority by days missing to conclusion date, with a difficulty percentage*/
    if([self.conclusionDate compare:[today dateByAddingTimeInterval:topPriority]]== NSOrderedAscending)
        self.priority = [[NSNumber alloc] initWithInt:3];
    else if([self.conclusionDate compare:[today dateByAddingTimeInterval:highPriority]] == NSOrderedAscending)
        self.priority = [[NSNumber alloc] initWithInt:2];
    else if([self.conclusionDate compare:[today dateByAddingTimeInterval:midPriority]] == NSOrderedAscending)
        self.priority = [[NSNumber alloc] initWithInt:1];
    else
        self.priority = [[NSNumber alloc] initWithInt:0];
    
}
/**
 Representation of class in string format
 */
- (NSString*) description{
    NSMutableString *string = [[NSMutableString alloc] init];
    
    [string appendFormat:@"\n%@", [self objectID]];
    [string appendFormat:@"\n%@", self.name];
    [string appendFormat:@"\n%@", self.difficulty];
    [string appendFormat:@"\n%@", self.fun];
    [string appendFormat:@"\n%@", [self.initialDate description]];
    [string appendFormat:@"\n%@", [self.conclusionDate description]];
    [string appendFormat:@"\n%@", self.priority];
    return string;
}
/**
 Compares tasks priorities
 */
-(int) compareTasksByPriority:(Task *) anotherTask{
    if(self.priority.intValue < anotherTask.priority.intValue)
        return -1;
    else if(self.priority.intValue > anotherTask.priority.intValue)
        return 1;
    return 0;
}
/**
 Compares tasks dates
 */
-(int) compareTasksByDate:(Task *) anotherTask{
    if([self.conclusionDate earlierDate:anotherTask.conclusionDate])
        return -1;
    else if([self.conclusionDate laterDate:anotherTask.conclusionDate])
        return 1;
    return 0;
}

@end

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
@dynamic priority;


#pragma mark notifiction Get and Set

-(UILocalNotification*) getNotification
{
    if (self.notification != nil) {
        UILocalNotification *notification=[NSKeyedUnarchiver unarchiveObjectWithData:self.notification];
        return notification;
    }
    return nil;
}

-(void) setNewNotification:(UILocalNotification*)notification
{
   self.notification=[NSKeyedArchiver archivedDataWithRootObject:notification];
}


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
- (NSComparisonResult)compareByPriority:(Task *)otherObject {
    if([self.priority compare:otherObject.priority]== NSOrderedAscending)
        return NSOrderedDescending;
    else if([self.priority compare:otherObject.priority] == NSOrderedDescending)
        return NSOrderedAscending;
    else if([self.fun compare:otherObject.fun] == NSOrderedAscending)
        return NSOrderedDescending;
    return NSOrderedAscending;
}
/**
 Compares tasks dates
 */
- (NSComparisonResult)compareByDate:(Task *)otherObject {
    return [self.conclusionDate compare:otherObject.conclusionDate];
}

/**
 Compare tasks IDs
 */
-(int) isID:( NSManagedObjectID*) identification{
    if([self objectID] == identification)
        return 1;
    return 0;
}

@end

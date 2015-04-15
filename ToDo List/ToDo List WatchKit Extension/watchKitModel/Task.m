//
//  TaskModel.m
//  ToDo List
//
//  Created by Ricardo Z Charf on 3/27/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import "Task.h"
#import <CoreData/CoreData.h>

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



#pragma mark notification Get and Set

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

/**
 @return Return the conclusion date of a Task
 */
-(NSDate*)getConclusionDate
{
    return nil;
}
@end

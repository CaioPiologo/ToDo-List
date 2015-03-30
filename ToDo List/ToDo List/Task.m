//
//  Task.m
//  ToDo List
//
//  Created by Caio Vinícius Piologo Véras Fernandes on 3/25/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import "Task.h"

@implementation Task
/**
 initializes class properties
 */
-(id) init: (NSNumber *)identification
  withName: (NSString *)name
withDifficulty: (NSNumber *)difficulty
   withFun: (NSNumber *)fun
withInitialDate: (NSDate *)initialDate
withConclusionDate: (NSDate *)conclusionDate
withContinuous: (NSNumber*) continuous
withRepeat: (NSDate *)repeatTime
withUrgency: (NSNumber*) urgency{
    
    self = [super init];
    if (self) {
        self.name = name;
        self.identification = identification;
        self.difficulty = difficulty;
        self.fun = fun;
        self.initialDate = initialDate;
        self.conclusionDate = conclusionDate;
        self.continuous = continuous;
        self.repeatTime = repeatTime;
        self.urgent = urgency;
        self.finished = [NSNumber numberWithInt:0];
        [self updatePriority];
    }
    return self;
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
- (NSString*) toString;{
    NSMutableString *string = [[NSMutableString alloc] init];
    
    [string appendFormat:@"\n%@", _identification];
    [string appendFormat:@"\n%@", _name];
    [string appendFormat:@"\n%@", _difficulty];
    [string appendFormat:@"\n%@", _fun];
    [string appendFormat:@"\n%@", [_initialDate description]];
    [string appendFormat:@"\n%@", [_conclusionDate description]];
    [string appendFormat:@"\n%@", _priority];
    return string;
}
/**
 Compares tasks priorities
 */
- (NSComparisonResult)compareByPriority:(Task *)otherObject {
    if([self.priority compare:otherObject.priority]== NSOrderedAscending)
        return NSOrderedDescending;
    return NSOrderedAscending; }
/**
 Compares tasks dates
 */
- (NSComparisonResult)compareByDate:(Task *)otherObject {
    return [self.conclusionDate compare:otherObject.conclusionDate];
}
/**
 Compare tasks IDs
 */
-(int) compareTaskByID:(Task *) anotherTask{
    if(self.identification.intValue < anotherTask.identification.intValue)
        return -1;
    else if(self.identification.intValue > anotherTask.identification.intValue)
        return 1;
    return 0;
}

@end

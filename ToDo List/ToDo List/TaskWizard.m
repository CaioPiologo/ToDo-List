//
//  TaskWizard.m
//  ToDo List
//
//  Created by Caio Vinícius Piologo Véras Fernandes on 3/30/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import "TaskWizard.h"
#import "Loader.h"
@interface TaskWizard()
@property (nonatomic) Loader *loader;
@end
@implementation TaskWizard

-(id)init:(Loader *) loader
{
    self = [super init];
    if (self) {
        self.newtask = nil;
        self.loader = loader;
    }
    return self;
}

/**
 Begins wizard by initializing the new task*/
-(void) begin{
    self.newtask = [self.loader createTaskWithName:nil withInitialDate:nil withConclusionDate:nil withDifficulty:nil withFun:nil isContinuous:nil withRepeatTime:nil isUrgent:@0];
}
/**
 Begins wizard with a task (edit mode)
 */
-(void) beginWithTask:(Task *)task{
    _newtask = task;
}
/**
 Cancels task creation
 */
-(void) cancel{
    [self.loader deleteTask:self.newtask];
    self.newtask = nil;
}
/**
 Finish creating task
 */
-(Task *) finish{
    //[self setNotification];
    return _newtask;
}
/**
 Adds name to task
 */
-(void) giveName:(NSString *)name{
    [_newtask setName:name];
}
/**
 Adds initial date to task
 */
-(void) giveInitialDate:(NSDate *)time{
    if(time == nil)
        [_newtask setInitialDate:[NSDate date]];
    else
        [_newtask setInitialDate:time];
}
/**
 Adds conclusion date to task
 */
-(void) giveConclusionDate:(NSDate *)time{
    if(time == nil)
        [_newtask setConclusionDate:[NSDate date]];
    else
        [_newtask setConclusionDate:time];
}
/**
 Adds difficulty to task
 */
-(void) giveDifficulty:(NSNumber *)difficulty{
    [_newtask setDifficulty:difficulty];
}
/**
 Adds fun to task
 */
-(void) giveFun:(NSNumber *)fun{
    [_newtask setFun:fun];
}
/**
 Determines wether a task is being created or not
 */
-(BOOL) hasAlreadyBegun
{
    if(self.newtask ==nil)
    {
        return NO;
    }
    return YES;
}
/**
 Sets task notification
 */
-(void) setNotification{
    self.newtask.notification = [[UILocalNotification alloc] init];
    self.newtask.notification.fireDate = self.newtask.conclusionDate;
    self.newtask.notification.alertBody = @"Forgot about me?";
    self.newtask.notification.alertAction = @"Hell no";
    self.newtask.notification.timeZone = [NSTimeZone defaultTimeZone];
    self.newtask.notification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:self.newtask.notification];
    
}

@end

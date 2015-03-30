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
@property(nonatomic) Task *newtask;
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

-(void) cancel{
    [self.loader deleteTask:self.newtask];
    self.newtask = nil;
}

-(Task *) finish{
    return _newtask;
}

-(void) giveName:(NSString *)name{
    [_newtask setName:name];
}

-(void) giveInitialDate:(NSDate *)time{
    if(time == nil)
        [_newtask setInitialDate:[NSDate date]];
    else
        [_newtask setInitialDate:time];
}

-(void) giveConclusionDate:(NSDate *)time{
    if(time == nil)
        [_newtask setConclusionDate:[NSDate date]];
    else
        [_newtask setConclusionDate:time];
}

-(void) giveDifficulty:(NSNumber *)difficulty{
    [_newtask setDifficulty:difficulty];
}

-(void) giveFun:(NSNumber *)fun{
    [_newtask setFun:fun];
}

-(BOOL) hasAlreadyBegun
{
    if(self.newtask ==nil)
    {
        return NO;
    }
    return YES;
}

@end

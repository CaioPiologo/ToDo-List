//
//  Task.m
//  ToDo List
//
//  Created by Caio Vinícius Piologo Véras Fernandes on 3/25/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import "Task.h"

/*@interface Task(){
    NSNumber *_identification;
    NSString *_name;
    NSNumber *_difficulty;
    NSNumber *_fun;
    NSDate *_initialDate;
    NSDate *_conclusionDate;
    BOOL _continuous;
    NSDate *_repeatTime;
    BOOL _urgent;
    BOOL _finished;
}
@end
*/
@implementation Task

-(id) init: (NSNumber *)identification
    withName: (NSString *)name
    withDifficulty: (NSNumber *)difficulty
    withFun: (NSNumber *)fun
    withInitialDate: (NSDate *)initialDate
    withConclusionDate: (NSDate *)conclusionDate
    withContinuous: (BOOL) continuous
    withRepeat: (NSDate *)repeatTime
    withUrgency: (BOOL) urgent
    finish: (BOOL) finished{
    
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
        self.urgent = urgent;
        self.finished = finished;
    }
    return self;
}
@end

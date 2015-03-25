//
//  Task.h
//  ToDo List
//
//  Created by Caio Vinícius Piologo Véras Fernandes on 3/25/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property NSNumber *identification;
@property NSString *name;
@property NSNumber *difficulty;
@property NSNumber *fun;
@property NSDate *initialDate;
@property NSDate *conclusionDate;
@property BOOL continuous;
@property NSDate *repeatTime;
@property BOOL urgent;
@property BOOL finished;

-(id) init: (NSNumber *)identification
    withName: (NSString *)name
    withDifficulty: (NSNumber *)difficulty
    withFun: (NSNumber *)fun
    withInitialDate: (NSDate *)initialDate
    withConclusionDate: (NSDate *)conclusionDate
    withContinuous: (BOOL) continuous
    withRepeat: (NSDate *)repeatTime
    withUrgency: (BOOL) urgent
    finish: (BOOL) finished;
            
@end

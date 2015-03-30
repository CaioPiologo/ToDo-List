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
@property NSNumber *continuous;
@property NSDate *repeatTime;
@property NSNumber *urgent;
@property NSNumber *finished;
@property NSNumber *priority;

-(id) init: (NSNumber *)identification
  withName: (NSString *)name
withDifficulty: (NSNumber *)difficulty
   withFun: (NSNumber *)fun
withInitialDate: (NSDate *)initialDate
withConclusionDate: (NSDate *)conclusionDate
withContinuous: (NSNumber *) continuous
withRepeat: (NSDate *)repeatTime;

- (NSString *) toString;

- (NSComparisonResult)compareByPriority:(Task *)otherObject;

- (NSComparisonResult)compareByDate:(Task *)otherObject;

-(int) compareTaskByID:(Task *) anotherTask;

-(void) updatePriority;

@end

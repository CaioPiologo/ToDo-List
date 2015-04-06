//
//  TaskWizard.h
//  ToDo List
//
//  Created by Caio Vinícius Piologo Véras Fernandes on 3/30/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@interface TaskWizard : NSObject

@property(nonatomic) Task *newtask;

-(id)init:(Loader *) loader;

-(void) beginWithTask:(Task*)task;

-(void) begin;

-(void) cancel;

-(Task *) finish;

-(void) giveName:(NSString*)name;

-(void) giveInitialDate:(NSDate *)time;

-(void) giveConclusionDate:(NSDate *)time;

-(void) giveDifficulty:(NSNumber*)difficulty;

-(void) giveFun:(NSNumber*)fun;

-(BOOL) hasAlreadyBegun;

-(void) setNotification;

-(void) createUrgentNotification;

@end

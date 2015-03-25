//
//  Loader.h
//  ToDo List
//
//  Created by Ricardo Z Charf on 3/25/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Loader : NSObject
/**
 This method saves the current context holded by the loader.
 **/
-(void)saveAll;

/**
 Saves ongoing task's list
 **/
-(void)saveTasksOnGoing: (NSArray*)onGoingTaskList;

/**
 Saves finished task's list
 **/
-(void)saveTasksFinished: (NSArray*)FinishedTaskList;

/**
 Adds the correspondant list to the context for further saving
 **/
-(void)addToContextOnGoingTaskList;

/**
 Adds the correspondant list to the context for further saving
 **/
-(void)addToContextFinishedTaskList;

/**
 Loads the ongoing task list from memory.
 @return return a NSArray containig the list loaded from memory
 **/
-(NSArray*)loadTasksOnGoing;

/**
 Loads the finished task list from memory.
 @return return a NSArray containig the list loaded from memory
 **/
-(NSArray*)loadTasksFinished;
@end

//
//  Loader.h
//  ToDo List
//
//  Created by Ricardo Z Charf on 3/25/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface WatchLoader : NSObject
#pragma mark Properties
@property (nonatomic) NSDate * lastSavedDate;
@property (readonly, nonatomic) NSManagedObjectContext *managedObjectContext;
#pragma mark Methods

/**
 @return An array with all tasks saved.
 **/
-(NSMutableArray*)loadTasksFromDataBase;

/**
 @return MutableArray with today tasks
 */
-(NSMutableArray*)todayTasks;

@end

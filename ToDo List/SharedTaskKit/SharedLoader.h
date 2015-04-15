//
//  SharedLoader.h
//  ToDo List
//
//  Created by Ricardo Z Charf on 4/15/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface SharedLoader : NSObject
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
#pragma mark Singleton Method(Static)
+ (id)getInstace;
/**
 @return An array with all tasks saved.
 **/
-(NSMutableArray*)loadTasksFromDataBase;
@end

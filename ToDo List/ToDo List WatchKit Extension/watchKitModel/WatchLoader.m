//
//  Loader.m
//  ToDo List
//
//  Created by Ricardo Z Charf on 3/25/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//


#import <CoreData/CoreData.h>
#import "WatchLoader.h"
#import "Task.h"
#import "SharedLoader.h"

@interface WatchLoader()
#pragma mark properties
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic) SharedLoader * sharedLoader;
@property (nonatomic) NSMutableArray* tasksArray;

@end
@implementation WatchLoader

#pragma mark Methods
-(id) init
{
    self = [super init];
    if(self)
    {
        self.sharedLoader = [SharedLoader getInstace];
        self.managedObjectContext = self.sharedLoader.managedObjectContext;
        self.managedObjectModel = self.sharedLoader.managedObjectModel;
        self.persistentStoreCoordinator = self.sharedLoader.persistentStoreCoordinator;
        self.tasksArray = [self loadTasksFromDataBase];
    }
    return self;
}

-(NSMutableArray*)loadTasksFromDataBase
{
    NSMutableArray * result = [self.sharedLoader loadTasksFromDataBase ];
    return result;
}

-(NSMutableArray*)todayTasks
{
    
    NSMutableArray * auxiliaryArray = [[NSMutableArray alloc]init];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1;
    NSDateComponents* comp2;
    self.tasksArray = [self loadTasksFromDataBase];
    for (Task *t in self.tasksArray) {
        comp1 = [calendar components:unitFlags fromDate:t.conclusionDate];
        comp2 = [calendar components:unitFlags fromDate:[NSDate date]];
       // NSLog(@"nome: %@",t.name);
        if ([comp1 day]   == [comp2 day] && [comp1 month] == [comp2 month] && [comp1 year]  == [comp2 year])
        {
            //            NSString *nome = t.name;
            [auxiliaryArray addObject:t];
        }else if([t.conclusionDate earlierDate:[NSDate date]] == t.conclusionDate)
        {
            [auxiliaryArray addObject:t];
        }
    }
    auxiliaryArray = [[auxiliaryArray sortedArrayUsingSelector:@selector(compareByPriority:)] mutableCopy];
    return auxiliaryArray;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "org.bepid.ToDoList" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Task" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Task.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


@end

/**
 Transforms object Task ina TaskModel object
 @param task Object to transform
 @return Return a TaskMOdel Object
 **/
/*-(TaskModel *) taskToTaskModel: (Task*)task
 {
 NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:self.managedObjectContext];
 TaskModel * newTaskModel = [[TaskModel alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
 [newTaskModel setConclusionDate:task.conclusionDate];
 [newTaskModel setContinuous:[NSNumber numberWithBool:task.continuous]];
 [newTaskModel setDifficulty:task.difficulty];
 [newTaskModel setFinished:[NSNumber numberWithBool:task.finished]];
 [newTaskModel setIdentification:task.identification];
 [newTaskModel setInitialDate:task.initialDate];
 [newTaskModel setName:task.name];
 [newTaskModel setRepeatTime:task.repeatTime];
 [newTaskModel setFun:task.fun];
 [newTaskModel setUrgent:[NSNumber numberWithBool:task.urgent]];
 return newTaskModel;
 
 }
 
 -(Task *) taskModelToTask: (TaskModel*)taskModel
 {
 Task* t =  [[Task alloc] init:[taskModel identification] withName:[taskModel name] withDifficulty:[taskModel difficulty] withFun:[taskModel fun] withInitialDate:[taskModel initialDate] withConclusionDate:[taskModel conclusionDate] withContinuous:[[taskModel continuous] boolValue] withRepeat:[taskModel repeatTime] withUrgency:[[taskModel urgent] boolValue] finish:[[taskModel finished] boolValue]];
 return t;
 
 }*/


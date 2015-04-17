//
//  InterfaceController.m
//  ToDo List WatchKit Extension
//
//  Created by Ricardo Z Charf on 4/15/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import "InterfaceController.h"
#import "MyRow.h"
#import <Foundation/Foundation.h>
#import "WatchLoader.h"
#import "watchKitModel/Task.h"

@interface InterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceTable *Table;
@property (nonatomic) NSMutableArray * arrayOfTasks;
@property (nonatomic) WatchLoader * loader;
@end


@implementation InterfaceController
int i=0;
- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [WKInterfaceController openParentApplication:@{} reply:^(NSDictionary *replyInfo, NSError *error) {
        
        self.arrayOfTasks = replyInfo[@"tasksArray"];
        NSLog(@"%@", replyInfo[@"tasksArray"][0]);
        [self loadTodoItems];//load info into table.
        
    }];
    [self loadTodoItems];//load info into table.
    [self autoUpdate];
}

-(void) autoUpdate{
    [WKInterfaceController openParentApplication:@{} reply:^(NSDictionary *replyInfo, NSError *error) {

            self.arrayOfTasks = replyInfo[@"tasksArray"];
        NSLog(@"%@", replyInfo[@"tasksArray"][0]);
        [self loadTodoItems];//load info into table.
        
    }];
    [self performSelector:@selector(autoUpdate) withObject:self afterDelay:1];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (void)loadTodoItems {
    // Fetch the to-do items
    NSArray* items = self.arrayOfTasks;

    // Configure the table object (self.todoItems) and get the row controllers.
    if (items.count > 0 ) {
        [self.Table setNumberOfRows:items.count withRowType:@"default"];
    }
    else
    {
        [self.Table setNumberOfRows:1 withRowType:@"default"];
        MyRow* row = [self.Table rowControllerAtIndex:0];
        [row.label setText:@"No tasks today."];
        return;
    }
   // NSLog(@"%@",[items[0] name]);
    NSInteger rowCount = [items count];
    
    // Iterate over the rows and set the label for each one.
    for (NSInteger i = 0; i < rowCount; i++) {
        // Get the to-do item data.
        NSArray* task = items[i];
        
        // Assign the text to the row's label.
        MyRow* row = [self.Table rowControllerAtIndex:i];
        [row.label setText:task[0]];
        switch ([task[1] integerValue]) {
            case 0:
                [row.group setBackgroundColor:[UIColor colorWithRed:121/255.0 green:189/255.0 blue:143/255.0 alpha:1]];
                break;
            case 1:
                [row.group setBackgroundColor:[UIColor colorWithRed:190/255.0 green:235/255.0 blue:159/255.0 alpha:1]];
                break;
            case 2:
                [row.group setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:157/255.0 alpha:1]];
                break;
            case 3:
                [row.group setBackgroundColor:[UIColor colorWithRed:1 green:97/255.0 blue:56/255.0 alpha:1]];
                break;
        }
        [row.group setCornerRadius:0];
    }
    
}

@end




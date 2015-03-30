//
//  ViewController.m
//  ToDo List
//
//  Created by Ricardo Z Charf on 3/25/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import "ViewController.h"
#import "Loader.h"
#import "Task.h"
#import "Foundation/Foundation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Loader * loader = [[Loader alloc] init];
    Task * t = [loader createTaskWithName:@"Uma task" withInitialDate:[NSDate date] withConclusionDate:[NSDate date] withDifficulty:@5 withFun:@2 isContinuous:@0 withRepeatTime:[NSDate date] isUrgent:@0];
    NSArray * vec = [loader loadTasksFromDataBase];
    NSLog(@"%@", [vec[0] objectID]);
                  NSLog(@"%@", [vec[1] objectID]);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  AddParamViewController.m
//  ToDo List
//
//  Created by Andre Sakiyama on 3/30/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddParamViewController.h"
#import "Organizer.h"
#import "Task.h"
#import "TaskWizard.h"

@interface AddParamViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (nonatomic) Organizer *organizer;

@end

@implementation AddParamViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _organizer = [Organizer getInstace];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doneButton:(id)sender
{
    Task *task;
    
    //[_organizer.taskWizard giveDifficulty:NSInteger  _difficult.value];
    [self.organizer.taskWizard giveDifficulty:[NSNumber numberWithFloat:self.difficult.value]];
    task = [_organizer.taskWizard finish];

    [_organizer addTaskToList: task];
    [_organizer updateTasks:1];
    [_organizer saveEnviroment];

    [self performSegueWithIdentifier:@"createTask" sender:self];
}

@end

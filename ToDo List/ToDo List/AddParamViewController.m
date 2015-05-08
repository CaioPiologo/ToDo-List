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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property BOOL flag;
@end

@implementation AddParamViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _organizer = [Organizer getInstace];
    self.flag=NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.nextButton.enabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doneButton:(id)sender
{
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    button.enabled = NO;
    self.flag=YES;
    Task *task;
        
    [_organizer.taskWizard giveDifficulty:[NSNumber numberWithFloat:self.difficult.value]];
        
    [_organizer.taskWizard giveFun:[NSNumber numberWithFloat:self.funny.value]];
        
    task = [_organizer.taskWizard finish];
        
    [_organizer addTaskToList: task];
        
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

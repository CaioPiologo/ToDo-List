//
//  EditParamViewController.m
//  ToDo List
//
//  Created by Andre Sakiyama on 4/2/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditParamViewController.h"
#import "Organizer.h"
#import "Task.h"
#import "TaskWizard.h"

@interface EditParamViewController ()

@property (nonatomic) Organizer *organizer;
@property (weak, nonatomic) IBOutlet UISlider *difficult;
@property (weak, nonatomic) IBOutlet UISlider *funny;

@end

@implementation EditParamViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _organizer = [Organizer getInstace];
    
    self.difficult.value = [self.organizer.taskWizard.newtask.difficulty floatValue];
    self.funny.value = [self.organizer.taskWizard.newtask.fun floatValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)saveButton:(id)sender
{
    Task *task;
    
    [self.organizer.taskWizard giveDifficulty:[NSNumber numberWithFloat:self.difficult.value]];
    
    [self.organizer.taskWizard giveFun:[NSNumber numberWithFloat:self.funny.value]];
    
    task = [self.organizer.taskWizard finish];
    
    [self.organizer saveEnviroment];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
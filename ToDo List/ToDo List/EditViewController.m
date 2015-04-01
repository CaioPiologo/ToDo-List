//
//  EditViewController.m
//  ToDo List
//
//  Created by Andre Sakiyama on 3/30/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditViewController.h"
#import "Organizer.h"
#import "Task.h"
#import "TaskWizard.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UISlider *difficult;
@property (weak, nonatomic) IBOutlet UISlider *funny;

@property (nonatomic) Organizer *organizer;

@end

@implementation EditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.organizer = [Organizer getInstace];
    self.textField.text = self.organizer.taskWizard.newtask.name;
    self.difficult.value = [self.organizer.taskWizard.newtask.difficulty floatValue];
    self.funny.value = [self.organizer.taskWizard.newtask.fun floatValue];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)saveButton:(id)sender{
    
    Task *task;
    
    [self.organizer.taskWizard giveName: self.textField.text];
    [self.organizer.taskWizard giveDifficulty: [NSNumber numberWithFloat: self.difficult.value]];
    [self.organizer.taskWizard giveFun: [NSNumber numberWithFloat: self.funny.value ]];
    
    task = [_organizer.taskWizard finish];

    [_organizer saveEnviroment];
    
    [self performSegueWithIdentifier: @"toTableView" sender: self];
}

-(IBAction)cancelButton:(id)sender{
    [self performSegueWithIdentifier:@"toTableView" sender:self];
}
@end
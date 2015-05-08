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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

@property (nonatomic) Organizer *organizer;
@property (weak, nonatomic) IBOutlet UILabel *warningMessage;

@end

@implementation EditViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.organizer = [Organizer getInstace];
    self.textField.text = self.organizer.taskWizard.newtask.name;
    
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

-(IBAction)toEditDate:(id)sender{
    
    self.nextButton.enabled = NO;
    if([self.textField.text isEqualToString:@""]) {
        [self.warningMessage setHidden:NO];
        self.nextButton.enabled = YES;
    }else{
        [self.organizer.taskWizard giveName: self.textField.text];
        [self performSegueWithIdentifier:@"toEditDate" sender:self];
    }
}

-(IBAction)cancelButton:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
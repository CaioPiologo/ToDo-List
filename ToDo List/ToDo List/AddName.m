//
//  AddName.m
//  ToDo List
//
//  Created by Andre Sakiyama on 3/30/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddName.h"
#import "Organizer.h"
#import "Task.h"
#import "TaskWizard.h"

@interface AddName ()

@property (weak, nonatomic) IBOutlet UILabel *warningMessage;
@property (nonatomic) Organizer *organizer;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

@end

@implementation AddName

- (void)viewDidLoad
{
    [super viewDidLoad];
    _organizer = [Organizer getInstace];
    [self.organizer.taskWizard begin];
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

- (IBAction)nextButton: (id)sender
{
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    button.enabled = NO;
    if([_textField.text isEqualToString:@""]) {
        [_warningMessage setHidden:NO];
        self.nextButton.enabled = YES;
    }else{
        [_organizer.taskWizard giveName: _textField.text];
        [self performSegueWithIdentifier:@"toGetDate" sender:self];
    }
}

-(IBAction)cancelButton:(id)sender
{
    [_organizer.taskWizard cancel];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
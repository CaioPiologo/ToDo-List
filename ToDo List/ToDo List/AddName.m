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

@interface AddName ()

@property (weak, nonatomic) IBOutlet UILabel *warningMessage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;
@property (nonatomic) Organizer *organizer;

@end

@implementation AddName

- (void)viewDidLoad
{
    [super viewDidLoad];
    _organizer = [Organizer getInstace];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextButton: (id)sender
{
    
    if([_textField.text isEqualToString:@""]) {
        [_warningMessage setHidden:NO];
    }else{
        [_organizer.taskWizard begin];
        [_organizer.taskWizard giveName: _textField.text];
        [self performSegueWithIdentifier:@"toGetDate" sender:self];
    }
}

-(IBAction)cancelButton:(id)sender
{
    [_organizer.taskWizard cancel];
    [self performSegueWithIdentifier:@"cancelButton" sender:self];
}

@end
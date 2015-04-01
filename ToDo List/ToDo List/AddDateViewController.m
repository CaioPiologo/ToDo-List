//
//  AddDateViewController.m
//  ToDo List
//
//  Created by Andre Sakiyama on 3/30/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddDateViewController.h"
#import "Organizer.h"
#import "Task.h"

@interface AddDateViewController ()

@property (nonatomic) Organizer *organizer;


@end

@implementation AddDateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.organizer = [Organizer getInstace];
   
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    }

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}


    //[self.organizer.taskWizard giveInitialDate:[NSDate date]];
    //[self.organizer.taskWizard giveInitialDate:date];


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)nextButton: (id)sender
{
    
    [self performSegueWithIdentifier:@"toGetParam" sender:self];
}
@end
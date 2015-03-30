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
    _organizer = [Organizer getInstace];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)nextButton: (UIStoryboardSegue*)sender
{
    
    [self performSegueWithIdentifier:@"toGetParam" sender:self];
}
@end
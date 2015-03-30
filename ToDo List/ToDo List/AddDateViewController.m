//
//  AddDateViewController.m
//  ToDo List
//
//  Created by Andre Sakiyama on 3/30/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddDateViewController.h"

@interface AddDateViewController ()

@end

@implementation AddDateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)nextButton: (UIStoryboardSegue*)sender
{
    AddName * addName = (AddName *)sender.sourceViewController;
    if([_textField.text isEqualToString:@""]) {
        [_warningMessage setHidden:NO];
    }else{
        [self performSegueWithIdentifier:@"nextButton" sender:self];
    }
}
@end
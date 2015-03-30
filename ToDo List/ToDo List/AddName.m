//
//  AddName.m
//  ToDo List
//
//  Created by Andre Sakiyama on 3/30/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddName.h"

@interface AddName ()

@property (weak, nonatomic) IBOutlet UILabel *warningMessage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

@end

@implementation AddName

- (void)viewDidLoad
{
    [super viewDidLoad];
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
        [self performSegueWithIdentifier:@"nextButton" sender:self];
    }
}

@end
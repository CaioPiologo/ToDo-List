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
    _organizer = [Organizer getInstace];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
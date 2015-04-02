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

@property (weak, nonatomic) IBOutlet UIDatePicker *initialDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *conclusionDate;
@property (weak, nonatomic) IBOutlet UILabel *warningDateMessage;

@end

@implementation AddDateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.organizer = [Organizer getInstace];
    //self.initialDate.minimumDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    //self.conclusionDate.minimumDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)nextButton: (id)sender
{
    if([self.initialDate.date compare: self.conclusionDate.date] == NSOrderedDescending){
        self.conclusionDate.minimumDate = [[NSDate alloc] initWithTimeInterval:0 sinceDate:self.initialDate.date];
        [self.warningDateMessage setHidden:NO];
    }else{
    
        [self.organizer.taskWizard giveInitialDate: [self.initialDate.date copy]];
        [self.organizer.taskWizard giveConclusionDate:[self.conclusionDate.date copy]];
        
        [self performSegueWithIdentifier:@"toGetParam" sender:self];
        
    }
}

- (IBAction)backToName:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
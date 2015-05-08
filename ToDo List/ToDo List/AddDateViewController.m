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
@property (weak, nonatomic) IBOutlet UISwitch *switchInitial;
@property (weak, nonatomic) IBOutlet UISwitch *switchConclusion;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

@end

@implementation AddDateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.organizer = [Organizer getInstace];
    //self.initialDate.minimumDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    //self.conclusionDate.minimumDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0];

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.nextButton.enabled = YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.initialDate.backgroundColor = [UIColor clearColor];
    self.conclusionDate.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)switchInitialClicked:(id)sender{
    if(self.switchInitial.isOn){
        [self.initialDate setHidden:YES];
    }else{
        [self.initialDate setHidden:NO];
    }
}

-(IBAction)switchConclusionClicked:(id)sender{
    if(self.switchConclusion.isOn){
        [self.conclusionDate setHidden:YES];
    }else{
        [self.conclusionDate setHidden:NO];
    }
}

- (IBAction)nextButton: (id)sender
{
    UIBarButtonItem *button = (UIBarButtonItem *)sender;
    button.enabled = NO;
    
    if((![self.initialDate isHidden])&&(![self.conclusionDate isHidden])&&([self.initialDate.date compare: self.conclusionDate.date] == NSOrderedDescending)){
        
        self.conclusionDate.minimumDate = [[NSDate alloc] initWithTimeInterval:0 sinceDate:self.initialDate.date];
        [self.warningDateMessage setHidden:NO];
    
    }else{
        if(self.switchInitial.isOn && self.switchConclusion.isOn){
            [self.organizer.taskWizard giveInitialDate:[NSDate date]];
            [self.organizer.taskWizard giveConclusionDate:[NSDate date]];
            
        }else{
            if(self.switchInitial.isOn){
                [self.organizer.taskWizard giveInitialDate:nil];
        
            }else{
                [self.organizer.taskWizard giveInitialDate: [self.initialDate.date copy]];
            }
            if(self.switchConclusion.isOn){
                [self.organizer.taskWizard giveConclusionDate:nil];
            }else{
                [self.organizer.taskWizard giveConclusionDate:[self.conclusionDate.date copy]];
            }
        }
        [self.warningDateMessage setHidden:YES];
        [self performSegueWithIdentifier:@"toGetParam" sender:self];
        
    }
}

@end
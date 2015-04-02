//
//  EditDateViewController.m
//  ToDo List
//
//  Created by Andre Sakiyama on 4/2/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditDateViewController.h"
#import "Organizer.h"
#import "Task.h"
#import "TaskWizard.h"

@interface EditDateViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *initialDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *conclusionDate;
@property (weak, nonatomic) IBOutlet UILabel *warningDateMessage;

@property (nonatomic) Organizer *organizer;

@end

@implementation EditDateViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.organizer = [Organizer getInstace];
    
    if(self.organizer.taskWizard.newtask.initialDate != nil){
            self.initialDate.date = [self.organizer.taskWizard.newtask.initialDate copy];
    }
    
    if(self.organizer.taskWizard.newtask.conclusionDate != nil){
        self.conclusionDate.date = [self.organizer.taskWizard.newtask.conclusionDate copy];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)toEditParam:(id)sender{
    if([self.initialDate.date compare: self.conclusionDate.date] == NSOrderedDescending){
        self.conclusionDate.minimumDate = [[NSDate alloc] initWithTimeInterval:0 sinceDate:self.initialDate.date];
        [self.warningDateMessage setHidden:NO];
    }else{
        
        [self.organizer.taskWizard giveInitialDate: [self.initialDate.date copy]];
        [self.organizer.taskWizard giveConclusionDate:[self.conclusionDate.date copy]];
        
        [self performSegueWithIdentifier:@"toEditParam" sender:self];
        
    }
}

@end
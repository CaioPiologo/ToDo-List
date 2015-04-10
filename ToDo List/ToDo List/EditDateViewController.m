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
@property (weak, nonatomic) IBOutlet UISwitch *switchInitial;
@property (weak, nonatomic) IBOutlet UISwitch *switchConclusion;

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

-(IBAction)toEditParam:(id)sender{
    if((![self.initialDate isHidden])&&(![self.conclusionDate isHidden])&&([self.initialDate.date compare: self.conclusionDate.date] == NSOrderedDescending)){
        self.conclusionDate.minimumDate = [[NSDate alloc] initWithTimeInterval:0 sinceDate:self.initialDate.date];
        [self.warningDateMessage setHidden:NO];
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
        
        [self performSegueWithIdentifier:@"toEditParam" sender:self];
        
    }
}

@end
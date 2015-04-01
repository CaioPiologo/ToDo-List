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
#import "JTCalendar.h"

@interface AddDateViewController ()

@property (nonatomic) Organizer *organizer;
@property (nonatomic) IBOutlet JTCalendarMenuView *calendarMenuView;
@property (nonatomic) IBOutlet JTCalendarContentView *calendarContentView;
@property (nonatomic) JTCalendar *calendar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarContentViewHeight;
@end

@implementation AddDateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.organizer = [Organizer getInstace];
    self.calendar = [JTCalendar new];
    
    
    
    {
        self.calendar.calendarAppearance.calendar.firstWeekday = 1; // Sunday == 1, Saturday == 7
        self.calendar.calendarAppearance.dayCircleRatio = 9. / 10.;
        self.calendar.calendarAppearance.ratioContentMenu = 1.;
    }
    
    
    [self.calendar setMenuMonthsView:self.calendarMenuView];
    
    [self.calendar setContentView:self.calendarContentView];
    
    [self.calendar setDataSource:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    //[super viewDidAppear:animated];
    [self.calendar reloadData]; // Must be call in viewDidAppear
}

- (BOOL)calendarHaveEvent:(JTCalendar *)calendar date:(NSDate *)date
{
    return NO;
}

- (void)calendarDidDateSelected:(JTCalendar *)calendar date:(NSDate *)date
{
    NSLog(@"%@", date);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)nextButton: (id)sender
{
    
    [self performSegueWithIdentifier:@"toGetParam" sender:self];
}
@end
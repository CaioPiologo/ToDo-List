//
//  ListByDateViewController.m
//  ToDo List
//
//  Created by Andre Sakiyama on 3/30/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListByDateViewController.h"
#import "Organizer.h"
#import "TaskWizard.h"

@interface ListByDateViewController ()

@property (nonatomic) Organizer *organizer;

@end

@implementation ListByDateViewController

@synthesize data;

- (void)viewDidLoad
{
    [super viewDidLoad];
    _organizer = [Organizer getInstace];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    data = [[NSArray alloc] initWithArray: [self.organizer updateTasksByDate]];
}

-(void) viewWillAppear:(BOOL)animated{
    self.organizer = [Organizer getInstace];
    self.data = [self.organizer updateTasksByDate];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Task *task = [data objectAtIndex:indexPath.row];
    
    [self.organizer.taskWizard beginWithTask:task];
    
    [self performSegueWithIdentifier:@"dateToEdit" sender:self];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4 ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [[self.organizer getTodayTasks] count];
            break;
        case 1:
            return [[self.organizer getTomorrowTasks] count];
            break;
        case 2:
            return [[self.organizer getAfterTomorrowTasks] count];
            break;
        case 3:
            return [[self.organizer getLaterTasks] count];
            break;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0)
        return @"Today";
    if(section == 1)
        return @"Tomorrow";
    if(section == 2)
        return @"After Tomorrow";
    if(section == 3)
        return @"Later";
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section==0) {
        Task *theCellData = [[self.organizer getTodayTasks] objectAtIndex:indexPath.row];
        NSString *cellValue =theCellData.name ;
        cell.textLabel.text = cellValue;
    }
    else if (indexPath.section==1) {
        Task *theCellData = [[self.organizer getTomorrowTasks] objectAtIndex:indexPath.row];
        NSString *cellValue =theCellData.name;
        cell.textLabel.text = cellValue;
    }
    else if (indexPath.section==2) {
        Task *theCellData = [[self.organizer getAfterTomorrowTasks] objectAtIndex:indexPath.row];
        NSString *cellValue =theCellData.name;
        cell.textLabel.text = cellValue;
    }
    else if(indexPath.section==3){
        Task *theCellData = [[self.organizer getLaterTasks] objectAtIndex:indexPath.row];
        NSString *cellValue =theCellData.name;
        cell.textLabel.text = cellValue;
    }
    return cell;
}
@end
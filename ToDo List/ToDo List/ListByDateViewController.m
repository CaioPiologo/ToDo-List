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
    self.tableView.backgroundColor = [UIColor colorWithRed:44/250.0 green:62/255.0 blue:80/250.0 alpha:1];
    data = [[NSArray alloc] initWithArray: [self.organizer updateTasksByDate]];
}

-(void) viewWillAppear:(BOOL)animated{
    self.organizer = [Organizer getInstace];
    data = [[NSArray alloc] initWithArray: [self.organizer updateTasksByDate]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int index = 0;
    
    for(int i = 0; i < indexPath.section; i++){
        index = index + (int)[self.tableView numberOfRowsInSection:i];
    }
    
    index = index + (int)indexPath.row;
    
    Task *task = [data objectAtIndex:index];
    
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

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor whiteColor];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor blackColor]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section==0&& [self.organizer getTodayTasks]!= nil) {
        Task *theCellData = [[self.organizer getTodayTasks] objectAtIndex:indexPath.row];
        NSString *cellValue =theCellData.name ;
        cell.textLabel.text = cellValue;
    }
    else if (indexPath.section==1&& [self.organizer getTomorrowTasks]!= nil) {
        Task *theCellData = [[self.organizer getTomorrowTasks] objectAtIndex:indexPath.row];
        NSString *cellValue =theCellData.name;
        cell.textLabel.text = cellValue;
    }
    else if (indexPath.section==2 && [self.organizer getAfterTomorrowTasks]!= nil) {
        Task *theCellData = [[self.organizer getAfterTomorrowTasks] objectAtIndex:indexPath.row];
        NSString *cellValue =theCellData.name;
        cell.textLabel.text = cellValue;
    }
    else if(indexPath.section==3){
        NSArray * array =[self.organizer getLaterTasks];
        if(!array)
            return cell;
        Task *theCellData = [array objectAtIndex:indexPath.row];
        NSString *cellValue =theCellData.name;
        cell.textLabel.text = cellValue;
    }
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int index = 0;
    
    for(int i = 0; i < indexPath.section; i++){
        index = index + (int)[self.tableView numberOfRowsInSection:i];
    }
    
    index = index + (int)indexPath.row;
    
    [_organizer removeTask:[[data objectAtIndex:index] objectID]];
    self.data = [self.organizer updateTasksByPriority];
    [self.tableView reloadData];
    return UITableViewCellEditingStyleDelete;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0f;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int index = 0;
    
    for(int i = 0; i < indexPath.section; i++){
        index = index + (int)[self.tableView numberOfRowsInSection:i];
    }
    
    index = index + (int)indexPath.row;
    
    Task *task = [data objectAtIndex: index];
    
    if([task.priority isEqualToNumber:@0])
        
        cell.backgroundColor = [UIColor colorWithRed:121/255.0 green:189/255.0 blue:143/255.0 alpha:1];
    
    else if([task.priority isEqualToNumber:@1])
        
        cell.backgroundColor = [UIColor colorWithRed:190/255.0 green:235/255.0 blue:159/255.0 alpha:1];
    
    else if([task.priority isEqualToNumber:@2])
        
        cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:157/255.0 alpha:1];
    
    else
        
        cell.backgroundColor = [UIColor colorWithRed:1 green:97/255.0 blue:56/255.0 alpha:1];
    
}

@end
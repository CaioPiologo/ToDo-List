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
    data = [[NSMutableArray alloc] init];
    [data addObjectsFromArray:[self.organizer getTodayTasks]];
    [data addObjectsFromArray:[self.organizer getTomorrowTasks]];
    [data addObjectsFromArray:[self.organizer getAfterTomorrowTasks]];
    [data addObjectsFromArray:[self.organizer getLaterTasks]];
    [self.organizer updateTasksByPriority];
    [self.tableView reloadData];

}

-(void) viewWillAppear:(BOOL)animated{
    self.organizer = [Organizer getInstace];
    [self.organizer updateTasksByPriority];
    data = [[NSMutableArray alloc] init];
    [data addObjectsFromArray:[self.organizer getTodayTasks]];
    [data addObjectsFromArray:[self.organizer getTomorrowTasks]];
    [data addObjectsFromArray:[self.organizer getAfterTomorrowTasks]];
    [data addObjectsFromArray:[self.organizer getLaterTasks]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[tableView cellForRowAtIndexPath:indexPath] tag] == -1)
    {
        return;
    }
    
    int index=0;
    
    NSArray * allIndexPaths=[tableView indexPathsForVisibleRows];
    
    for (int i=0; allIndexPaths[i]!=indexPath; i++) {
        if ([[tableView cellForRowAtIndexPath:allIndexPaths[i]] tag] != -1)
        {
            index++;
        }
        
    }
    
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
            if([[_organizer getTodayTasks]count]==0)
            {
                return 1;
            }
            return [[self.organizer getTodayTasks] count];
            break;
        case 1:
            if([[_organizer getTomorrowTasks]count]==0)
            {
                return 1;
            }
            return [[self.organizer getTomorrowTasks] count];
            break;
        case 2:
            if([[_organizer getAfterTomorrowTasks]count]==0)
            {
                return 1;
            }
            return [[self.organizer getAfterTomorrowTasks] count];
            break;
        case 3:
            if([[_organizer getLaterTasks]count]==0)
            {
                return 1;
            }
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
    
    unsigned unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *comp;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.section) {
        case 0:
            if([[_organizer getTodayTasks]count]==0)
            {
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.textLabel.text = @"There are no tasks today.";
                cell.backgroundColor = [UIColor colorWithRed:44/255.0 green:62/255.0 blue:80/255.0 alpha:1];
                cell.tag = -1;
                return cell;
            }
            break;
        case 1:
            if([[_organizer getTomorrowTasks]count]==0)
            {
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.textLabel.text = @"There are no tasks tomorrow.";
                cell.backgroundColor = [UIColor colorWithRed:44/255.0 green:62/255.0 blue:80/255.0 alpha:1];
                cell.tag = -1;
                return cell;
            }
            break;
        case 2:
            if([[_organizer getAfterTomorrowTasks]count]==0)
            {
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.textLabel.text = @"There are no tasks after tomorrow.";
                cell.backgroundColor = [UIColor colorWithRed:44/255.0 green:62/255.0 blue:80/255.0 alpha:1];
                cell.tag = -1;
                return cell;
            }
            break;
        case 3:
            if([[_organizer getLaterTasks]count]==0)
            {
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.textLabel.text = @"There are no tasks for later.";
                cell.backgroundColor = [UIColor colorWithRed:44/255.0 green:62/255.0 blue:80/255.0 alpha:1];
                cell.tag = -1;
                return cell;
            }
            break;
    }
     cell.textLabel.textColor = [UIColor blackColor];
    if (indexPath.section==0) {
        Task *theCellData = [[self.organizer getTodayTasks] objectAtIndex:indexPath.row];
        comp = [calendar components:unitFlags fromDate:theCellData.conclusionDate];
        NSString *cellValue = [[NSString alloc] initWithFormat:@"%@", theCellData.name];
        NSString *cellDetailValue = [[NSString alloc] initWithFormat:@"Conclusion until %ld:%ld", comp.hour, comp.minute ];
        cell.textLabel.text = cellValue;
        cell.detailTextLabel.text = cellDetailValue;
        if([theCellData.priority isEqualToNumber:@0])
        {
            cell.backgroundColor = [UIColor colorWithRed:121/255.0 green:189/255.0 blue:143/255.0 alpha:1];
        }
        else if([theCellData.priority isEqualToNumber:@1])
        {
            cell.backgroundColor = [UIColor colorWithRed:190/255.0 green:235/255.0 blue:159/255.0 alpha:1];
        }
        else if([theCellData.priority isEqualToNumber:@2])
        {
            cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:157/255.0 alpha:1];
        }
        else
        {
            cell.backgroundColor = [UIColor colorWithRed:1 green:97/255.0 blue:56/255.0 alpha:1];
        }
    }
    else if (indexPath.section==1) {
        Task *theCellData = [[self.organizer getTomorrowTasks] objectAtIndex:indexPath.row];
        comp = [calendar components:unitFlags fromDate:theCellData.conclusionDate];
        NSString *cellValue = [[NSString alloc] initWithFormat:@"%@", theCellData.name];
        NSString *cellDetailValue = [[NSString alloc] initWithFormat:@"Conclusion until %ld:%ld", comp.hour, comp.minute ];
        cell.textLabel.text = cellValue;
        cell.detailTextLabel.text = cellDetailValue;
        if([theCellData.priority isEqualToNumber:@0])
        {
            cell.backgroundColor = [UIColor colorWithRed:121/255.0 green:189/255.0 blue:143/255.0 alpha:1];
        }
        else if([theCellData.priority isEqualToNumber:@1])
        {
            cell.backgroundColor = [UIColor colorWithRed:190/255.0 green:235/255.0 blue:159/255.0 alpha:1];
        }
        else if([theCellData.priority isEqualToNumber:@2])
        {
            cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:157/255.0 alpha:1];
        }
        else
        {
            cell.backgroundColor = [UIColor colorWithRed:1 green:97/255.0 blue:56/255.0 alpha:1];
        }
    }
    else if (indexPath.section==2 ) {
        Task *theCellData = [[self.organizer getAfterTomorrowTasks] objectAtIndex:indexPath.row];
        comp = [calendar components:unitFlags fromDate:theCellData.conclusionDate];
        NSString *cellValue = [[NSString alloc] initWithFormat:@"%@", theCellData.name];
        NSString *cellDetailValue = [[NSString alloc] initWithFormat:@"Conclusion until %ld:%ld", comp.hour, comp.minute ];
        cell.textLabel.text = cellValue;
        cell.detailTextLabel.text = cellDetailValue;
        if([theCellData.priority isEqualToNumber:@0])
        {
            cell.backgroundColor = [UIColor colorWithRed:121/255.0 green:189/255.0 blue:143/255.0 alpha:1];
        }
        else if([theCellData.priority isEqualToNumber:@1])
        {
            cell.backgroundColor = [UIColor colorWithRed:190/255.0 green:235/255.0 blue:159/255.0 alpha:1];
        }
        else if([theCellData.priority isEqualToNumber:@2])
        {
            cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:157/255.0 alpha:1];
        }
        else
        {
            cell.backgroundColor = [UIColor colorWithRed:1 green:97/255.0 blue:56/255.0 alpha:1];
        }
    }
    else if(indexPath.section==3){
        NSArray * array =[self.organizer getLaterTasks];
        if(!array)
            return cell;
        Task *theCellData = [array objectAtIndex:indexPath.row];
        comp = [calendar components:unitFlags fromDate:theCellData.conclusionDate];
        NSString *cellValue = [[NSString alloc] initWithFormat:@"%@", theCellData.name];
        NSString *cellDetailValue = [[NSString alloc] initWithFormat:@"Conclusion until %ld:%ld", comp.hour, comp.minute ];
        cell.textLabel.text = cellValue;
        cell.detailTextLabel.text = cellDetailValue;
        if([theCellData.priority isEqualToNumber:@0])
        {
            cell.backgroundColor = [UIColor colorWithRed:121/255.0 green:189/255.0 blue:143/255.0 alpha:1];
            
        }
        else if([theCellData.priority isEqualToNumber:@1])
        {
            cell.backgroundColor = [UIColor colorWithRed:190/255.0 green:235/255.0 blue:159/255.0 alpha:1];
        }
        else if([theCellData.priority isEqualToNumber:@2])
        {
            cell.backgroundColor = [UIColor colorWithRed:1 green:1 blue:157/255.0 alpha:1];
        }
        else
        {
            cell.backgroundColor = [UIColor colorWithRed:1 green:97/255.0 blue:56/255.0 alpha:1];
        }
    }
    return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    int index=0;
    
    NSArray * allIndexPaths=[tableView indexPathsForVisibleRows];
    
    for (int i=0; allIndexPaths[i]!=indexPath; i++) {
        if ([[tableView cellForRowAtIndexPath:allIndexPaths[i]] tag] != -1)
        {
            index++;
        }
        
    }
    
    Task *task = [data objectAtIndex: index];
    [_organizer removeTask:[task objectID]];
    [self.tableView reloadData];
    data = [[NSMutableArray alloc] init];
    [data addObjectsFromArray:[self.organizer getTodayTasks]];
    [data addObjectsFromArray:[self.organizer getTomorrowTasks]];
    [data addObjectsFromArray:[self.organizer getAfterTomorrowTasks]];
    [data addObjectsFromArray:[self.organizer getLaterTasks]];
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[tableView cellForRowAtIndexPath:indexPath] tag] == -1)
    {
        return NO;
    }
    return YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0f;
    
}


@end
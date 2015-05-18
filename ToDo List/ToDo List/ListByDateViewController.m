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
    
    //see if it is the first time
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int first = (int)[userDefaults integerForKey:@"firstTime"];
    //Case it's the first time of use of the app
    if(first == 0)
    {
        Task * task;
        //We have to create 5 tasks: one for each priority level and one for teaching how to remove tasks
        //first one: TopPriority
        [self.organizer.taskWizard begin];
        [self.organizer.taskWizard giveName:NSLocalizedString(@"This Task has top priority",nil)];
        [self.organizer.taskWizard giveDifficulty:@10];
        [self.organizer.taskWizard giveFun:@1];
        [self.organizer.taskWizard giveInitialDate:[NSDate date] ];
        [self.organizer.taskWizard giveConclusionDate:[NSDate dateWithTimeInterval:0 sinceDate:[NSDate date]]];
        task = [_organizer.taskWizard finish];
        [self.organizer addTaskToList: task];
        
        //first one: HighPriority
        [self.organizer.taskWizard begin];
        [self.organizer.taskWizard giveName:NSLocalizedString(@"This Task has a high priority",nil)];
        [self.organizer.taskWizard giveDifficulty:@10];
        [self.organizer.taskWizard giveFun:@1];
        [self.organizer.taskWizard giveInitialDate:[NSDate dateWithTimeIntervalSinceNow:-(60*60*24)] ];
        [self.organizer.taskWizard giveConclusionDate:[NSDate dateWithTimeInterval:(60*60*24) sinceDate:[NSDate date]]];
        task = [_organizer.taskWizard finish];
        [self.organizer addTaskToList: task];
        
        //first one: SomePriority
        [self.organizer.taskWizard begin];
        [self.organizer.taskWizard giveName:NSLocalizedString(@"This Task has some priority",nil)];
        [self.organizer.taskWizard giveDifficulty:@10];
        [self.organizer.taskWizard giveFun:@1];
        [self.organizer.taskWizard giveInitialDate:[NSDate dateWithTimeIntervalSinceNow:-(60*60*24)] ];
        [self.organizer.taskWizard giveConclusionDate:[NSDate dateWithTimeInterval:(2*60*60*24) sinceDate:[NSDate date]]];
        task = [_organizer.taskWizard finish];
        [self.organizer addTaskToList: task];
        
        //first one: NoPriority
        [self.organizer.taskWizard begin];
        [self.organizer.taskWizard giveName:NSLocalizedString(@"This Task has no priority",nil)];
        [self.organizer.taskWizard giveDifficulty:@00];
        [self.organizer.taskWizard giveFun:@1];
        [self.organizer.taskWizard giveInitialDate:[NSDate dateWithTimeIntervalSinceNow:-(60*60*24)] ];
        [self.organizer.taskWizard giveConclusionDate:[NSDate dateWithTimeInterval:(10*60*60*24) sinceDate:[NSDate date]]];
        task = [_organizer.taskWizard finish];
        [self.organizer addTaskToList: task];
        
        //first one: Swipe to delete
        [self.organizer.taskWizard begin];
        [self.organizer.taskWizard giveName:NSLocalizedString(@"Swipe the task left to remove. Try it in me!",nil)];
        [self.organizer.taskWizard giveDifficulty:@00];
        [self.organizer.taskWizard giveFun:@1];
        [self.organizer.taskWizard giveInitialDate:[NSDate dateWithTimeIntervalSinceNow:-(60*60*24)] ];
        [self.organizer.taskWizard giveConclusionDate:[NSDate dateWithTimeInterval:(50*60*60*24) sinceDate:[NSDate date]]];
        task = [_organizer.taskWizard finish];
        [self.organizer addTaskToList: task];
        
        [self.organizer.taskWizard begin];
        [self.organizer.taskWizard giveName:NSLocalizedString(@"Tap me to edit me",nil)];
        [self.organizer.taskWizard giveDifficulty:@00];
        [self.organizer.taskWizard giveFun:@1];
        [self.organizer.taskWizard giveInitialDate:[NSDate dateWithTimeIntervalSinceNow:-(60*60*24)] ];
        [self.organizer.taskWizard giveConclusionDate:[NSDate dateWithTimeInterval:(50*60*60*24) sinceDate:[NSDate date]]];
        task = [_organizer.taskWizard finish];
        [self.organizer addTaskToList: task];
        
        
        [self.organizer saveEnviroment];
        [userDefaults setInteger:1 forKey:@"firstTime"];
    }
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:44/250.0 green:62/255.0 blue:80/250.0 alpha:1];
    data = [[NSMutableArray alloc] init];
    [data addObjectsFromArray:[self.organizer getTodayTasks]];
    [data addObjectsFromArray:[self.organizer getTomorrowTasks]];
    [data addObjectsFromArray:[self.organizer getAfterTomorrowTasks]];
    [data addObjectsFromArray:[self.organizer getLaterTasks]];
    [self.organizer updateTasksByPriority];
    [self autoUpdate];

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

-(void) autoUpdate{
    [self.tableView reloadData];
    [self.organizer updateTasksByPriority];
    [self performSelector:@selector(autoUpdate) withObject:self afterDelay:10];
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
        return NSLocalizedString(@"Today", nil);
    if(section == 1)
        return NSLocalizedString(@"Tomorrow", nil);
    if(section == 2)
        return NSLocalizedString(@"After Tomorrow", nil);
    if(section == 3)
        return NSLocalizedString(@"Later", nil);
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
    
    unsigned unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear| NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *comp;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.detailTextLabel.text = @"";
    cell.tag = 0;
    switch (indexPath.section) {
        case 0:
            if([[_organizer getTodayTasks]count]==0)
            {
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.textLabel.text = NSLocalizedString(@"There are no tasks today.", nil);
                cell.backgroundColor = [UIColor colorWithRed:44/255.0 green:62/255.0 blue:80/255.0 alpha:1];
                cell.tag = -1;
                return cell;
            }
            break;
        case 1:
            if([[_organizer getTomorrowTasks]count]==0)
            {
                
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.textLabel.text = NSLocalizedString(@"There are no tasks tomorrow.", nil);
                cell.backgroundColor = [UIColor colorWithRed:44/255.0 green:62/255.0 blue:80/255.0 alpha:1];
                cell.tag = -1;
                return cell;
            }
            break;
        case 2:
            if([[_organizer getAfterTomorrowTasks]count]==0)
            {
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.textLabel.text = NSLocalizedString(@"There are no tasks after tomorrow.", nil);
                cell.backgroundColor = [UIColor colorWithRed:44/255.0 green:62/255.0 blue:80/255.0 alpha:1];
                cell.tag = -1;
                return cell;
            }
            break;
        case 3:
            if([[_organizer getLaterTasks]count]==0)
            {
                cell.textLabel.textColor = [UIColor whiteColor];
                cell.textLabel.text = NSLocalizedString(@"There are no tasks for later.", nil);
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
        NSString *cellDetailValue = @"";
        if ([theCellData.conclusionDate earlierDate:[NSDate date]]==theCellData.conclusionDate) {
            cellDetailValue = [[NSString alloc] initWithFormat:NSLocalizedString(@"Task not completed on %02ld/%@/%ld",nil),comp.day,monthNameFromDate(comp.month),comp.year ];
        }else
        {
            cellDetailValue = [[NSString alloc] initWithFormat:NSLocalizedString(@"Conclusion until %02ld:%02ld", nil), comp.hour, comp.minute ];
        }
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
        NSString *cellDetailValue = @"";
        if ([theCellData.conclusionDate earlierDate:[NSDate date]]==theCellData.conclusionDate) {
            cellDetailValue = [[NSString alloc] initWithFormat:NSLocalizedString(@"Task not completed on %02ld/%@/%ld", nil),comp.day,monthNameFromDate(comp.month),comp.year ];
        }else
        {
            cellDetailValue = [[NSString alloc] initWithFormat:NSLocalizedString(@"Conclusion until %02ld:%02ld", nil), comp.hour, comp.minute ];
        }
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
        NSString *cellDetailValue = @"";
        if ([theCellData.conclusionDate earlierDate:[NSDate date]]==theCellData.conclusionDate) {
            cellDetailValue = [[NSString alloc] initWithFormat:NSLocalizedString(@"Task not completed on %02ld/%@/%ld", nil),comp.day,monthNameFromDate(comp.month),comp.year ];
        }else
        {
            cellDetailValue = [[NSString alloc] initWithFormat:NSLocalizedString(@"Conclusion until %02ld:%02ld", nil), comp.hour, comp.minute ];
        }
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
        NSString *cellDetailValue = @"";
        if ([theCellData.conclusionDate earlierDate:[NSDate date]]==theCellData.conclusionDate) {
            cellDetailValue = [[NSString alloc] initWithFormat:NSLocalizedString(@"Task not completed on %02ld/%@/%ld",nil),comp.day,monthNameFromDate(comp.month),comp.year ];
        }else
        {
            cellDetailValue = [[NSString alloc] initWithFormat:NSLocalizedString(@"Conclusion until %02ld:%02ld, %02ld/%@/%ld", nil), comp.hour, comp.minute,comp.day,monthNameFromDate(comp.month),comp.year ];
        }
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
    data = [[NSMutableArray alloc] init];
    [data addObjectsFromArray:[self.organizer getTodayTasks]];
    [data addObjectsFromArray:[self.organizer getTomorrowTasks]];
    [data addObjectsFromArray:[self.organizer getAfterTomorrowTasks]];
    [data addObjectsFromArray:[self.organizer getLaterTasks]];
    [self.tableView reloadData];
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

NSString * monthNameFromDate(long monthNumber) {
    NSDateFormatter *formate = [NSDateFormatter new];
    
    NSArray *monthNames = [formate standaloneMonthSymbols];
    
    NSString *monthName = [monthNames objectAtIndex:(monthNumber - 1)];
    
    return monthName;
}


@end
//
//  ViewController.m
//  ToDo List
//
//  Created by Ricardo Z Charf on 3/25/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import "ViewController.h"
#import "Loader.h"
#import "Task.h"
#import "Foundation/Foundation.h"
#import "Organizer.h"
#import "TaskWizard.h"

@interface ViewController ()

@property (nonatomic) Organizer *organizer;

@end

@implementation ViewController

@synthesize data;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.organizer = [Organizer getInstace];
    
    
    self.data = [self.organizer updateTasksByDate];
}

/*-(NSInteger) numberOfSectionsInTableView:(UITableView *) tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSIndexPath *)indexPath
{
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath*) indexPath
{
    static NSString *CellIdentifier = @"PriorityCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    }
    
    Task * t = [data objectAtIndex: indexPath.row];
    NSNumber * pry = t.priority;
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@ Priority - %@", t.name, pry];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //check if your cell is pressed
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    Task *task = [data objectAtIndex:indexPath.row];
    
    [self.organizer.taskWizard beginWithTask:task];
    
    [self performSegueWithIdentifier:@"priorityToEdit" sender:self];

}*/

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
        return @"Section 1";
    if(section == 1)
        return @"Section 2";
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
        Task *theCellData = [[self.organizer getListByDate] objectAtIndex:indexPath.row];
        NSString *cellValue =theCellData.name;
        cell.textLabel.text = cellValue;
    }
    else {
        Task *theCellData = [[self.organizer getListByDate] objectAtIndex:indexPath.row];
        NSString *cellValue =theCellData.name;
        cell.textLabel.text = cellValue;
    }
    return cell;
}

@end

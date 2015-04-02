//
//  ViewController.m
//  ToDo List
//
//  Created by Ricardo Z Charf on 3/25/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import "ListByPriorityViewController.h"
#import "Loader.h"
#import "Task.h"
#import "Foundation/Foundation.h"
#import "Organizer.h"
#import "TaskWizard.h"

@interface ListByPriorityViewController ()

@property (nonatomic) Organizer *organizer;

@end

@implementation ListByPriorityViewController

@synthesize data;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor blackColor];
    self.organizer = [Organizer getInstace];
    self.data = [self.organizer updateTasksByPriority];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    self.organizer = [Organizer getInstace];
    self.data = [self.organizer updateTasksByPriority];
    [self.tableView reloadData];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *) tableView
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
    
    cell.textLabel.text = [[data objectAtIndex: indexPath.row] name];
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

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_organizer removeTask:[[data objectAtIndex:indexPath.row] objectID]];
    NSLog(@"%@", [[data objectAtIndex:indexPath.row] name]);
    [self.tableView reloadData];
    return UITableViewCellEditingStyleDelete;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0f;
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    Task *task = [data objectAtIndex: indexPath.row];
    
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

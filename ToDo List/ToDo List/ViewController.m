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

-(void)viewWillAppear:(BOOL)animated{
    self.organizer = [Organizer getInstace];
    self.data = [self.organizer updateTasksByDate];
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

}

@end

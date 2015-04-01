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
    
    data = [[NSArray alloc] initWithArray: [self.organizer updateTasksByDate]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    static NSString *CellIdentifier = @"DateCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    }
    
    cell.textLabel.text = [[data objectAtIndex: indexPath.row] name];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Task *task = [data objectAtIndex:indexPath.row];
    
    [self.organizer.taskWizard beginWithTask:task];
    
    [self performSegueWithIdentifier:@"dateToEdit" sender:self];
    
}
@end
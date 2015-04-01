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
#import "EditViewController.h"


@interface ViewController ()

@property (nonatomic) Organizer *organizer;

@end

@implementation ViewController

@synthesize data;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   // _organizer = [Organizer getInstace];
   // data = [[NSMutableArray alloc] initWithObjects: [_organizer getListByPriority], nil];
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
    static NSString *CellIdentifier = @"Cell";
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
    
    [self performSegueWithIdentifier:@"toEdit" sender:task];

}

- (IBAction)edit:(id)sender{
    [self performSegueWithIdentifier:@"priorityToEdit" sender:sender];
}


@end

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


@interface ViewController ()

@property (strong, nonatomic) NSString *name;

@end

@implementation ViewController

@synthesize data;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    data = [[NSMutableArray alloc] initWithObjects: @"Dog", nil];
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
    
    cell.textLabel.text = [data objectAtIndex: indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)doneButton:(id)sender{
    
    ViewController *viewController = [[ViewController alloc]init];
    
    AddName *addName = [[AddName alloc] init];
    NSString *text = addName.textField.text;
    
    [viewController.data insertObject: text atIndex: 0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow: 0 inSection:0];
    
    [viewController.tableView beginUpdates];
    [viewController.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [viewController.tableView endUpdates];
    
    [self performSegueWithIdentifier:@"createTask" sender:self];
    
}

@end

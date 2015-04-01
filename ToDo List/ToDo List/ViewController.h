//
//  ViewController.h
//  ToDo List
//
//  Created by Ricardo Z Charf on 3/25/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "AddParamViewController.h"
#import "AddName.h"

@interface ViewController : UIViewController

@property(strong, nonatomic) NSArray *data;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end


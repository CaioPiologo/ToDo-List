//
//  ListByDateViewController.h
//  ToDo List
//
//  Created by Andre Sakiyama on 3/30/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#ifndef ToDo_List_ListByDateViewController_h
#define ToDo_List_ListByDateViewController_h


#endif

#import <UIKit/UIKit.h>
#import "ListByDateViewController.h"

@interface ListByDateViewController : UIViewController

@property(strong, nonatomic) NSArray *data;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
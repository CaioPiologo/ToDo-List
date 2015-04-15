//
//  MyRow.h
//  ToDo List
//
//  Created by Ricardo Z Charf on 4/15/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface MyRow : NSObject
@property (weak, nonatomic) IBOutlet WKInterfaceGroup *group;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *label;
@end
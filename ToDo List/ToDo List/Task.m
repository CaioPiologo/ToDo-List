//
//  TaskModel.m
//  ToDo List
//
//  Created by Ricardo Z Charf on 3/27/15.
//  Copyright (c) 2015 Ricardo Z Charf. All rights reserved.
//

#import "Task.h"
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Loader.h"

@implementation Task

@dynamic conclusionDate;
@dynamic continuous;
@dynamic difficulty;
@dynamic finished;
@dynamic fun;
@dynamic initialDate;
@dynamic name;
@dynamic repeatTime;
@dynamic urgent;

-(NSString*)description
{
    return self.name;
}


@end

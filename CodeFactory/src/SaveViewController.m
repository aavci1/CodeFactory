//
//  SaveViewController.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/3/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "SaveViewController.h"

#import "Model.h"
#import "TraceLog.h"

@interface SaveViewController ()

@property (strong, nonatomic) Model *model;

@end

@implementation SaveViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model:(Model *)aModel
{
    TraceLog();
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        _model = aModel;
    }
    
    return self;
}

- (BOOL)isValid
{
    TraceLog();
    
    return YES;
}

- (NSString *)title
{
    return @"Save";
}

- (NSString *)description
{
    return @"Drag the icon below and drop into anywhere to save generated files. Alternatively you can use the Save button to choose where to save files.";
}

@end

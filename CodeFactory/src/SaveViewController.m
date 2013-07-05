//
//  SaveViewController.m
//  Code Factory
//
//  Created by Abdurrahman AVCI on 7/3/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "SaveViewController.h"

#import "ClassModel.h"
#import "TraceLog.h"

@interface SaveViewController ()

@end

@implementation SaveViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil delegate:(id)aDelegate
{
    TraceLog();
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        _delegate = aDelegate;
    }
    
    return self;
}

- (void)validate
{
    TraceLog();
    
    [self.delegate canDoPrev:YES];
    [self.delegate canDoNext:YES];
}

- (NSString *)name
{
    return @"Save";
}

- (NSString *)description
{
    return @"Save";
}

@end

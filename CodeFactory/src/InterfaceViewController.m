//
//  InterfaceViewController.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/3/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "InterfaceViewController.h"

#import "ClassModel.h"
#import "TraceLog.h"

@interface InterfaceViewController ()

@end

@implementation InterfaceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil delegate:(id)aDelegate
{
    TraceLog();
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        _delegate = aDelegate;
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self.textView setFont:[NSFont fontWithName:@"Menlo Regular" size:[NSFont smallSystemFontSize]]];
}

- (void)validate
{
    TraceLog();
    
    self.textView.string = [self.delegate.model interface];
    
    [self.delegate canDoPrev:YES];
    [self.delegate canDoNext:YES];
}

- (NSString *)title
{
    return @"Interface";
}

- (NSString *)description
{
    return @"Review and edit generated interface as you wish.";
}

- (NSString *)string
{
    return self.textView.string;
}

@end

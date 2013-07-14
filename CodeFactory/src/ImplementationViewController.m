//
//  ImplementationViewController.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/3/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "ImplementationViewController.h"

#import "ClassModel.h"
#import "TraceLog.h"

@interface ImplementationViewController ()

@end

@implementation ImplementationViewController

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
    
    self.textView.string = [self.delegate.model implementation];
    
    [self.delegate canDoPrev:YES];
    [self.delegate canDoNext:YES];
}

- (NSString *)title
{
    return @"Implementation";
}

- (NSString *)description
{
    return @"Review and edit generated implementation as you wish.";
}

- (NSString *)string
{
    return self.textView.string;
}

@end

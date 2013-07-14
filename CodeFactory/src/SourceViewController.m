//
//  InterfaceViewController.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/3/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "SourceViewController.h"

#import "ClassModel.h"
#import "TraceLog.h"

@interface SourceViewController ()

@end

@implementation SourceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil delegate:(id)aDelegate extension:(NSString *)anExtension
{
    TraceLog();
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        _delegate = aDelegate;
        _extension = anExtension;
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
    
    if ([self.extension isEqualToString:@"h"])
        self.textView.string = [self.delegate.model interface];
    else
        self.textView.string = [self.delegate.model implementation];
    
    [self.delegate canDoPrev:YES];
    [self.delegate canDoNext:YES];
}

- (NSString *)title
{
    if ([self.extension isEqualToString:@"h"])
        return @"Header";
    
    return @"Implementation";
}

- (NSString *)description
{
    return @"Review generated source code. Any changes you make here will be preserved when you save.";
}

- (NSString *)string
{
    return self.textView.string;
}

@end

//
//  InterfaceViewController.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/3/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "SourceViewController.h"

#import "Model.h"
#import "TraceLog.h"

@interface SourceViewController ()

@property (strong, nonatomic) Model *model;

@end

@implementation SourceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model:(Model *)aModel extension:(NSString *)anExtension
{
    TraceLog();
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        _model = aModel;
        _extension = anExtension;
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self.textView setFont:[NSFont fontWithName:@"Menlo Regular" size:[NSFont smallSystemFontSize]]];
}

- (BOOL)isValid
{
    TraceLog();
    
    return YES;
}

- (NSString *)title
{
    if ([self.extension isEqualToString:@"h"])
        return @"Review Interface";
    
    return @"Review Implementation";
}

- (NSString *)description
{
    return @"You may edit the source code. Any changes you made will be preserved when saved to disk.";
}

@end

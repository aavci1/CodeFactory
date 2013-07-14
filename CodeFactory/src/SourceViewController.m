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
    
    if ([self.extension isEqualToString:@"h"])
        self.textView.string = [self.model interface];
    else
        self.textView.string = [self.model implementation];
    
    return YES;
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

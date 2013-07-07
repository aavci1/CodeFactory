//
//  BoxView.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/3/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "BoxView.h"

#import "TraceLog.h"

@implementation BoxView

- (id)initWithFrame:(NSRect)frame
{
    TraceLog();
    
    self = [super initWithFrame:frame];
    if (self) {
        self.wantsLayer = YES;
    }
    
    return self;
}
- (void)addSubview:(NSView *)newView
{
    TraceLog();
    
    [super addSubview:newView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(newView);
    [newView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[newView]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[newView]|" options:0 metrics:nil views:views]];
}

- (void)replaceSubview:(NSView *)oldView with:(NSView *)newView
{
    TraceLog();
    
    [super replaceSubview:oldView with:newView];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(newView);
    [newView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[newView]|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[newView]|" options:0 metrics:nil views:views]];
}

- (void)drawRect:(NSRect)dirtyRect
{
    TraceLog();
    
    // select white color with translucency
    [[NSColor colorWithCalibratedRed:1.0 green:1.0 blue:1.0 alpha:0.8] set];
    
    // fill rect
    NSRectFill([self bounds]);
    
    // select black color
    [[NSColor colorWithCalibratedRed:0.6 green:0.6 blue:0.6 alpha:1.0] set];
    
    // draw border
    NSFrameRect([self bounds]);
}

@end

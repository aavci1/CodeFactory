//
//  StepView.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/4/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "StepView.h"

#import "TraceLog.h"

@interface StepView ()

@property (strong, nonatomic) NSMutableArray *steps;

@end


@implementation StepView

- (id)initWithFrame:(NSRect)frame
{
    TraceLog();
    
    self = [super initWithFrame:frame];
    if (self)
    {
        _steps = [NSMutableArray new];
        _currentStep = 0;
    }
    
    return self;
}

- (void)addStep:(NSString *)name
{
    [self.steps addObject:name];
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
    
    // property arrays
    NSArray *fonts = @[ [NSFont systemFontOfSize:0], [NSFont boldSystemFontOfSize:0], [NSFont systemFontOfSize:0] ];
    NSArray *colors = @[ [NSColor blackColor], [NSColor blackColor], [NSColor grayColor] ];
    NSArray *images = @[ [NSImage imageNamed:@"dot-green"], [NSImage imageNamed:@"dot-red"], [NSImage imageNamed:@"dot-orange"] ];
    
    float spacing = 10, margin = 20, dotSize = 11;
    
    // calculate total height
    float totalHeight = self.currentStep * [@"" sizeWithAttributes:@{NSFontAttributeName:fonts[0]}].height +
    [@"" sizeWithAttributes:@{NSFontAttributeName:fonts[0]}].height +
    (self.steps.count - self.currentStep - 1) *[@"" sizeWithAttributes:@{NSFontAttributeName:fonts[2]}].height + (self.steps.count - 1) * spacing;
    
    float x = margin, y = self.bounds.size.height - (self.bounds.size.height - totalHeight) / 2;
    
    for (int i = 0; i < self.steps.count; ++i) {
        int index;
        
        if (i < self.currentStep)
            index = 0;
        else if (i == self.currentStep)
            index = 1;
        else
            index = 2;
        
        NSDictionary *attributes = @{ NSFontAttributeName:fonts[index], NSForegroundColorAttributeName:colors[index] };
        
        float height = [self.steps[i] sizeWithAttributes:attributes].height;
        
        [images[index] drawInRect:NSMakeRect(x, y - height - 1 + (height - dotSize) / 2, dotSize, dotSize) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
        
        [self.steps[i] drawAtPoint:NSMakePoint(x + dotSize + 4, y - height) withAttributes:attributes];
        
        y -= height + spacing;
    }
}

@end

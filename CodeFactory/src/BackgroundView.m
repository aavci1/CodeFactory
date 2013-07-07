//
//  BackgroundView.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 6/30/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "BackgroundView.h"

#import "TraceLog.h"

@interface BackgroundView ()

@property (strong, nonatomic) NSImage *image;

@end

@implementation BackgroundView

- (id)initWithFrame:(NSRect)frame
{
    TraceLog();
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _image = [NSImage imageNamed:@"icons.icns"];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    TraceLog();
    
    float scale = MIN(self.frame.size.width / self.image.size.width, self.frame.size.height / self.image.size.height);
    
    NSRect rect;
    rect.origin.x = -100;
    rect.origin.y = (self.frame.size.height - self.image.size.height * scale) / 2;
    rect.size.width = self.image.size.width * scale;
    rect.size.height = self.image.size.height *scale;
    
    [self.image drawInRect:rect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:0.8];
}

@end

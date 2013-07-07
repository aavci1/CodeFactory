//
//  DragView.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/3/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "DragView.h"

#import "TraceLog.h"

@interface DragView ()

@property (strong, nonatomic) NSImage *dragImage;

@end

@implementation DragView

- (id)initWithFrame:(NSRect)frame
{
    TraceLog();
    
    self = [super initWithFrame:frame];
    if (self) {
        NSImage *hImage = [[NSWorkspace sharedWorkspace] iconForFileType:@"h"];
        NSImage *mImage = [[NSWorkspace sharedWorkspace] iconForFileType:@"m"];
        
        _dragImage = [NSImage imageWithSize:NSMakeSize(128, 128) flipped:NO drawingHandler:^BOOL(NSRect rect) {
            [mImage setSize:NSMakeSize(112, 112)];
            [mImage drawAtPoint:NSMakePoint(16, 8)
                       fromRect:NSMakeRect(0, 0, 128, 128)
                      operation:NSCompositeSourceOver
                       fraction:1.0];

            [hImage setSize:NSMakeSize(112, 112)];
            [hImage drawAtPoint:NSMakePoint(0, 0)
                       fromRect:NSMakeRect(0, 0, 128, 128)
                      operation:NSCompositeSourceOver
                       fraction:1.0];
            
            return YES;
        }];
    }
    
    return self;
}

- (NSDragOperation)draggingSourceOperationMaskForLocal:(BOOL)flag
{
    TraceLog();
    
    return NSDragOperationCopy;
}

- (NSDragOperation)draggingSession:(NSDraggingSession *)session sourceOperationMaskForDraggingContext:(NSDraggingContext)context
{
    TraceLog();
    
    return NSDragOperationCopy;
}

- (void)mouseDown:(NSEvent *)theEvent
{
    TraceLog();
    
    // TODO: create a temporary dir
    // get a unique identifier
    NSString *guid = [[NSProcessInfo processInfo] globallyUniqueString];
    
    // build temp dir path
    NSString *tempDir = [NSTemporaryDirectory() stringByAppendingPathComponent:guid];
    
    // create the directory
    [[NSFileManager new] createDirectoryAtPath:tempDir withIntermediateDirectories:NO attributes:nil error:NULL];
    
    // construct urls
    NSString *interfacePath = [NSString stringWithFormat:@"%@/%@.h", tempDir, self.className];
    NSString *implementationPath = [NSString stringWithFormat:@"%@/%@.m", tempDir, self.className];
    
    // write interface
    [self.interface writeToFile:interfacePath atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    [self.implementation writeToFile:implementationPath atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    
    NSPoint dragPosition = [self convertPoint:[theEvent locationInWindow] fromView:nil];
    dragPosition.x -= self.dragImage.size.width / 2;
    dragPosition.y -= self.dragImage.size.height / 2;
    
    NSPasteboard *pboard = [NSPasteboard pasteboardWithName:NSDragPboard];
    
    [pboard declareTypes:@[NSFilenamesPboardType] owner:nil];
    [pboard setPropertyList:@[interfacePath, implementationPath] forType:NSFilenamesPboardType];
    
    [self dragImage:self.dragImage
                 at:dragPosition
             offset:NSZeroSize
              event:theEvent
         pasteboard:pboard
             source:self
          slideBack:YES];
}

- (void)drawRect:(NSRect)dirtyRect
{
    TraceLog();
    
    NSPoint point= NSMakePoint((self.frame.size.width - self.dragImage.size.width) / 2,
                               (self.frame.size.height - self.dragImage.size.height) / 2);
    
    [self.dragImage drawAtPoint:point
                       fromRect:NSMakeRect(0, 0, self.dragImage.size.width, self.dragImage.size.height)
                      operation:NSCompositeSourceOver
                       fraction:1.0];
}


@end

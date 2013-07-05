//
//  DragView.h
//  Code Factory
//
//  Created by Abdurrahman AVCI on 7/3/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DragView : NSView <NSDraggingSource>

@property (strong, nonatomic) NSString *className;
@property (strong, nonatomic) NSString *interface;
@property (strong, nonatomic) NSString *implementation;

@end

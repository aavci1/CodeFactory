//
//  StepView.h
//  Code Factory
//
//  Created by Abdurrahman AVCI on 7/4/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StepView : NSView

// properties
@property (assign, nonatomic) NSInteger currentStep;

// initializers
- (id)initWithFrame:(NSRect)frameRect;

- (void)addStep:(NSString *)name;

@end

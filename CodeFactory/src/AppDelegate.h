//
//  AppDelegate.h
//  Code Factory
//
//  Created by Abdurrahman AVCI on 6/30/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "BoxView.h"
#import "NavigationDelegate.h"
#import "StepView.h"

@interface AppDelegate : NSObject <NavigationDelegate, NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

// outlets
@property (weak) IBOutlet StepView *stepView;
@property (weak) IBOutlet BoxView *rightBox;

@property (weak) IBOutlet NSButton *btnPrev;
@property (weak) IBOutlet NSButton *btnNext;
@property (weak) IBOutlet NSTextField *lblHeader;

// actions
- (IBAction)prevClicked:(id)sender;
- (IBAction)nextClicked:(id)sender;

@end

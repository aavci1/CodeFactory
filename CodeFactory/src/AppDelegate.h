//
//  AppDelegate.h
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 6/30/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "BoxView.h"
#import "StepView.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

// outlets
@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet BoxView *mainView;
@property (weak) IBOutlet StepView *stepView;

@property (weak) IBOutlet NSButton *btnPrev;
@property (weak) IBOutlet NSButton *btnNext;
@property (weak) IBOutlet NSTextField *lblHeader;

// actions
- (IBAction)prevClicked:(id)sender;
- (IBAction)nextClicked:(id)sender;

@end

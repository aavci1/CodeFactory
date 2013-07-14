//
//  AppDelegate.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 6/30/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "AppDelegate.h"

#import "ClassViewController.h"
#import "ProtocolsViewController.h"
#import "PropertiesViewController.h"
#import "SourceViewController.h"
#import "SaveViewController.h"

#import "ClassModel.h"
#import "DragView.h"
#import "TraceLog.h"

@interface AppDelegate ()

@property (strong, nonatomic) ClassModel *classModel;

@property (strong, nonatomic) NSArray *viewControllers;
@property (nonatomic) NSUInteger oldIndex;
@property (nonatomic) NSUInteger newIndex;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    TraceLog();
    
    // create class model
    self.classModel = [[ClassModel alloc] init];
    
    // create view controllers
    self.viewControllers = @[
                             [[ClassViewController alloc] initWithNibName:@"ClassView" bundle:[NSBundle mainBundle] delegate:self],
                             [[ProtocolsViewController alloc] initWithNibName:@"ProtocolsView" bundle:[NSBundle mainBundle] delegate:self],
                             [[PropertiesViewController alloc] initWithNibName:@"PropertiesView" bundle:[NSBundle mainBundle] delegate:self],
                             [[SourceViewController alloc] initWithNibName:@"SourceView" bundle:[NSBundle mainBundle] delegate:self extension:@"h"],
                             [[SourceViewController alloc] initWithNibName:@"SourceView" bundle:[NSBundle mainBundle] delegate:self extension:@"m"],
                             [[SaveViewController alloc] initWithNibName:@"SaveView" bundle:[NSBundle mainBundle] delegate:self]
                             ];
    
    // create steps
    for (int i = 0; i < self.viewControllers.count; ++i)
        [self.stepView addStep:[self.viewControllers[i] title]];

    // init view indices
    self.oldIndex = 0;
    self.newIndex = 0;

    // show first view
    [self.rightBox addSubview:[self.viewControllers[0] view]];
    
    [self viewChanged];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

// actions
- (IBAction)prevClicked:(id)sender
{
    TraceLog();
    
    if (self.newIndex > 0)
    {
        self.oldIndex = self.newIndex;
        self.newIndex--;
        
        [[self.rightBox animator] replaceSubview:[self.viewControllers[self.oldIndex] view]
                                            with:[self.viewControllers[self.newIndex] view]];
        
        [self viewChanged];
    }
}

- (IBAction)nextClicked:(id)sender
{
    TraceLog();
    
    if (self.newIndex == self.viewControllers.count - 1) {
        // create open panel
        NSOpenPanel *panel = [NSOpenPanel openPanel];
        
        // set panel properties
        [panel setAllowsMultipleSelection:NO];
        [panel setCanChooseDirectories:YES];
        [panel setCanChooseFiles:NO];
        
        // show panel as sheet modal
        [panel beginSheetModalForWindow:self.window completionHandler:^(NSInteger result) {
            if (result == NSFileHandlingPanelCancelButton)
                return;
            
            for (NSViewController *controller in self.viewControllers) {
                if ([controller isKindOfClass:[SourceViewController class]]) {
                    SourceViewController *sourceViewController = (SourceViewController *)controller;
                    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@.%@", self.classModel.className, sourceViewController.extension] relativeToURL:panel.URLs.lastObject];
                    [sourceViewController.string writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:NULL];
                }
            }
        }];
    }
    
    if (self.newIndex < self.viewControllers.count - 1)
    {
        self.oldIndex = self.newIndex;
        self.newIndex++;
        
        [[self.rightBox animator] replaceSubview:[self.viewControllers[self.oldIndex] view]
                                            with:[self.viewControllers[self.newIndex] view]];
        
        [self viewChanged];
    }
}

- (void)viewChanged
{
    TraceLog();
    
    self.stepView.currentStep = self.newIndex;
    
    [self.stepView setNeedsDisplay:YES];
    
    self.lblHeader.stringValue = [self.viewControllers[self.newIndex] title];
    
    [self.viewControllers[self.newIndex] validate];
    
    if (self.newIndex == self.viewControllers.count - 1) {
        [self.btnNext setTitle:@"Save"];
        
        NSString *interface, *implementation;
        
        for (NSViewController *controller in self.viewControllers) {
            if ([controller isKindOfClass:[SourceViewController class]]) {
                SourceViewController *sourceViewController = (SourceViewController *)controller;
                if ([sourceViewController.extension isEqualToString:@"h"])
                    interface = [sourceViewController string];
                else
                    implementation = [sourceViewController string];
            }
        }
        
        SaveViewController *saveViewController = self.viewControllers.lastObject;
        saveViewController.dragView.className = self.model.className;
        saveViewController.dragView.interface = interface;
        saveViewController.dragView.implementation = implementation;
    } else {
        [self.btnNext setTitle:@"Next"];
    }
}

// NavigationDelegate methods
- (ClassModel *)model
{
    return self.classModel;
}

- (void)canDoPrev:(BOOL)prev
{
    TraceLog();
    
    [self.btnPrev setEnabled:prev];
}

- (void)canDoNext:(BOOL)next
{
    TraceLog();
    
    [self.btnNext setEnabled:next];
}

@end

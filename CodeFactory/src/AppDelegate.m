//
//  AppDelegate.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 6/30/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "AppDelegate.h"

#import "DragView.h"
#import "Model.h"
#import "ClassViewController.h"
#import "ProtocolsViewController.h"
#import "PropertiesViewController.h"
#import "SourceViewController.h"
#import "SaveViewController.h"
#import "TraceLog.h"

@interface AppDelegate ()

// class model
@property (strong, nonatomic) Model *model;

// view controllers
@property (strong, nonatomic) ClassViewController *classView;
@property (strong, nonatomic) ProtocolsViewController *protocolsView;
@property (strong, nonatomic) PropertiesViewController *propertiesView;
@property (strong, nonatomic) SourceViewController *interfaceView;
@property (strong, nonatomic) SourceViewController *implementationView;
@property (strong, nonatomic) SaveViewController *saveView;

@property (strong, nonatomic) NSArray *viewControllers;

@property (nonatomic) NSUInteger oldIndex;
@property (nonatomic) NSUInteger newIndex;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    TraceLog();
    
    // create class model
    self.model = [Model new];
    
    // create view controllers
    self.classView = [[ClassViewController alloc] initWithNibName:@"ClassView" bundle:[NSBundle mainBundle] model:self.model];
    self.protocolsView = [[ProtocolsViewController alloc] initWithNibName:@"ProtocolsView" bundle:[NSBundle mainBundle] model:self.model];
    self.propertiesView = [[PropertiesViewController alloc] initWithNibName:@"PropertiesView" bundle:[NSBundle mainBundle] model:self.model];
    self.interfaceView = [[SourceViewController alloc] initWithNibName:@"SourceView" bundle:[NSBundle mainBundle] model:self.model extension:@"h"];
    self.implementationView = [[SourceViewController alloc] initWithNibName:@"SourceView" bundle:[NSBundle mainBundle] model:self.model extension:@"m"];
    self.saveView = [[SaveViewController alloc] initWithNibName:@"SaveView" bundle:[NSBundle mainBundle] model:self.model];
    
    // create array
    self.viewControllers = @[
                             self.classView,
                             self.protocolsView,
                             self.propertiesView,
                             self.interfaceView,
                             self.implementationView,
                             self.saveView
                             ];
    
    // create steps
    for (int i = 0; i < self.viewControllers.count; ++i)
        [self.stepView addStep:[self.viewControllers[i] title]];

    // init view indices
    self.oldIndex = 0;
    self.newIndex = 0;

    // show first view
    [self.mainView addSubview:[self.viewControllers[0] view]];
    
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
        
        [[self.mainView animator] replaceSubview:[self.viewControllers[self.oldIndex] view]
                                            with:[self.viewControllers[self.newIndex] view]];
        
        [self viewChanged];
    }
}

- (IBAction)nextClicked:(id)sender
{
    TraceLog();
    
    if(![self.viewControllers[self.newIndex] isValid])
        return;
    
    if (self.newIndex < self.viewControllers.count - 1)
    {
        self.oldIndex = self.newIndex;
        self.newIndex++;
        
        [[self.mainView animator] replaceSubview:[self.viewControllers[self.oldIndex] view]
                                            with:[self.viewControllers[self.newIndex] view]];
        
        [self viewChanged];
    } else {
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
            
            // construct urls
            NSURL *hURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@.h", self.model.className] relativeToURL:panel.URLs.lastObject];
            NSURL *mURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@.m", self.model.className] relativeToURL:panel.URLs.lastObject];
            
            // save
            [self.interfaceView.textView.string writeToURL:hURL atomically:YES encoding:NSUTF8StringEncoding error:NULL];
            [self.implementationView.textView.string writeToURL:mURL atomically:YES encoding:NSUTF8StringEncoding error:NULL];
        }];
    }
}

- (void)viewChanged
{
    TraceLog();
    
    NSViewController *currentView = self.viewControllers[self.newIndex];
    
    // update step view
    [self.stepView setCurrentStep:self.newIndex];
    [self.stepView setNeedsDisplay:YES];
    
    // update title and description
    self.lblTitle.stringValue = [currentView title];
    self.lblDescription.stringValue = [currentView description];
    
    // update previous button
    if (self.newIndex > 0)
        [self.btnPrev setEnabled:YES];
    else
        [self.btnPrev setEnabled:NO];

    // update next button
    if (self.newIndex < self.viewControllers.count - 1)
        [self.btnNext setTitle:@"Next"];
    else
        [self.btnNext setTitle:@"Save"];
    
    // initialize current view
    if (currentView == self.interfaceView) {
        self.interfaceView.textView.string = [self.model interface];
    } else if (currentView == self.implementationView) {
        self.implementationView.textView.string = [self.model implementation];
    } else if (currentView == self.saveView) {
        self.saveView.dragView.className = self.model.className;
        self.saveView.dragView.interface = self.interfaceView.textView.string;
        self.saveView.dragView.implementation = self.implementationView.textView.string;
    }
}

@end

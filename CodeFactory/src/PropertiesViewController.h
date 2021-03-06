//
//  PropertiesViewController.h
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/1/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Model;

@interface PropertiesViewController : NSViewController <NSComboBoxCellDataSource, NSTableViewDelegate, NSTableViewDataSource>

// initializers
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model:(Model *)aModel;

// methods
- (BOOL)isValid;

- (NSString *)title;
- (NSString *)description;

// outlets
@property (weak) IBOutlet NSTableView *tableView;

@property (weak) IBOutlet NSButton *addButton;
@property (weak) IBOutlet NSButton *removeButton;
@property (weak) IBOutlet NSButton *duplicateButton;

// actions
- (IBAction)addClicked:(id)sender;
- (IBAction)duplicatePressed:(id)sender;
- (IBAction)removeClicked:(id)sender;

@end

//
//  ProtocolsViewController.h
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/1/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Model;

@interface ProtocolsViewController : NSViewController <NSComboBoxCellDataSource, NSTableViewDelegate, NSTableViewDataSource>

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

// actions
- (IBAction)addClicked:(id)sender;
- (IBAction)removeClicked:(id)sender;

@end

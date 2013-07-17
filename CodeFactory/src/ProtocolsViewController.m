//
//  ProtocolsViewController.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/1/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "ProtocolsViewController.h"

#import "Model.h"
#import "TraceLog.h"

@interface ProtocolsViewController ()

@property (strong, nonatomic) Model *model;
@property (strong, nonatomic) NSArray *protocols;

@end

@implementation ProtocolsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model:(Model *)aModel
{
    TraceLog();
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        _model = aModel;
        _protocols = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Protocols" ofType:@"plist"]];
    }
    
    return self;
}

- (BOOL)isValid
{
    TraceLog();
    
    return YES;
}

- (NSString *)title
{
    return @"Select Protocols";
}

- (NSString *)description
{
    return @"Enter the protocols you want to be addded to the interface declaration.";
}

- (IBAction)addClicked:(id)sender
{
    TraceLog();
    
    // add new protocol
    [self.model.protocols addObject:@""];
    
    // get new row index
    NSInteger rowIndex = self.model.protocols.count - 1;
    
    // insert new row into the table view
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexes:[NSIndexSet indexSetWithIndex:rowIndex] withAnimation:NSTableViewAnimationEffectGap];
    [self.tableView endUpdates];
    
    // select the new row and make sure it is visible
    [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:rowIndex] byExtendingSelection:NO];
    [self.tableView scrollRowToVisible:rowIndex];
    
    // begin editing
    [self.tableView editColumn:0 row:rowIndex withEvent:nil select:YES];
}

- (IBAction)removeClicked:(id)sender
{
    TraceLog();
    
    NSInteger rowIndex = self.tableView.selectedRow;
    
    // remove from table view
    [self.tableView beginUpdates];
    [self.tableView removeRowsAtIndexes:[NSIndexSet indexSetWithIndex:rowIndex] withAnimation:NSTableViewAnimationEffectFade];
    [self.tableView endUpdates];
    
    // remove from model
    [self.model.protocols removeObjectAtIndex:rowIndex];
    
    // calculate row index to select
    if (rowIndex == self.model.protocols.count)
        rowIndex = self.model.protocols.count - 1;
    
    // select row
    [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:rowIndex] byExtendingSelection:NO];
}

// NSComboBoxDataSource
- (NSInteger)numberOfItemsInComboBoxCell:(NSComboBoxCell *)comboBoxCell
{
    TraceLog();
    
    return self.protocols.count;
}

- (id) comboBoxCell:(NSComboBoxCell *)aComboBoxCell objectValueForItemAtIndex:(NSInteger)index
{
    TraceLog();
    
    return self.protocols[index];
}

// NSTableViewDelegate methods
- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    TraceLog();
    
    [self.removeButton setEnabled:self.tableView.selectedRow != -1];
}

// NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    TraceLog();
    
    return self.model.protocols.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return self.model.protocols[row];
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    self.model.protocols[row] = object;
}

@end

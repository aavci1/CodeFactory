//
//  PropertiesViewController.m
//  Code Factory
//
//  Created by Abdurrahman AVCI on 7/1/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "PropertiesViewController.h"

#import "ClassModel.h"
#import "TraceLog.h"

@interface PropertiesViewController ()

@property (strong, nonatomic) NSArray *primitiveTypes;
@property (strong, nonatomic) NSArray *classes;
@property (strong, nonatomic) NSArray *attributes;

@end

@implementation PropertiesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil delegate:(id)aDelegate
{
    TraceLog();
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        _primitiveTypes = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PrimitiveTypes" ofType:@"plist"]];
        _classes = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Classes" ofType:@"plist"]];
        _attributes = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Attributes" ofType:@"plist"]];
        _delegate = aDelegate;
    }
    
    return self;
}

- (void)validate
{
    TraceLog();
    
    [self.delegate canDoPrev:YES];
    [self.delegate canDoNext:YES];
}

- (NSString *)name
{
    return @"Properties";
}

- (NSString *)description
{
    return @"Add properties";
}

- (IBAction)addClicked:(id)sender
{
    TraceLog();
    
    // add new protocol
    [self.delegate.model.properties addObject:[Property new]];
    
    // get new row index
    NSInteger rowIndex = self.delegate.model.properties.count - 1;
    
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

- (IBAction)duplicatePressed:(id)sender {
    TraceLog();
    
    Property *currentProperty = self.delegate.model.properties[self.tableView.selectedRow];
    
    Property *property = [Property new];
    property.publicity = currentProperty.publicity;
    property.memory = currentProperty.memory;
    property.atomicity = currentProperty.atomicity;
    property.encapsulation = currentProperty.encapsulation;
    property.type = currentProperty.type;
    property.name = currentProperty.name;
    
    // add new protocol
    [self.delegate.model.properties addObject:property];
    
    // get new row index
    NSInteger rowIndex = self.delegate.model.properties.count - 1;
    
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
    [self.delegate.model.properties removeObjectAtIndex:rowIndex];

    // calculate row index to select
    if (rowIndex == self.delegate.model.properties.count)
        rowIndex = self.delegate.model.properties.count - 1;
    
    // select row
    [self.tableView selectRowIndexes:[NSIndexSet indexSetWithIndex:rowIndex] byExtendingSelection:NO];
}

// NSComboBoxDataSource
- (NSInteger)numberOfItemsInComboBoxCell:(NSComboBoxCell *)comboBoxCell
{
    TraceLog();
    
    if (comboBoxCell.tag == 301)
        return self.attributes.count;
    
    if (comboBoxCell.tag == 302)
        return self.primitiveTypes.count + self.classes.count;
    
    return 0;
}

- (id)comboBoxCell:(NSComboBoxCell *)comboBoxCell objectValueForItemAtIndex:(NSInteger)index
{
    TraceLog();
    
    if (comboBoxCell.tag == 301)
        return self.attributes[index];
    
    if (comboBoxCell.tag == 302) {
        if (index < self.primitiveTypes.count)
            return self.primitiveTypes[index];
        
        return [NSString stringWithFormat:@"%@*", self.classes[index - self.primitiveTypes.count]];
    }

    return nil;
}

// NSTableViewDelegate methods
- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    TraceLog();
    
    [self.removeButton setEnabled:self.tableView.selectedRow != -1];
    [self.duplicateButton setEnabled:self.tableView.selectedRow != -1];
}

// NSTableViewDataSource
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    TraceLog();
    
    return self.delegate.model.properties.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    Property *property = self.delegate.model.properties[row];
    
    if ([tableColumn.identifier isEqualToString:@"PublicityColumn"])
        return property.publicity ? @YES : @NO;
    
    if ([tableColumn.identifier isEqualToString:@"MemoryColumn"])
        return property.memory;
    
    if ([tableColumn.identifier isEqualToString:@"AtomicityColumn"])
        return property.atomicity;

    if ([tableColumn.identifier isEqualToString:@"EncapsulationColumn"])
        return property.encapsulation;
    
    if ([tableColumn.identifier isEqualToString:@"TypeColumn"])
        return property.type;
    
    if ([tableColumn.identifier isEqualToString:@"NameColumn"])
        return property.name;
    
    return nil;
}

- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    Property *property = self.delegate.model.properties[row];
    
    if ([tableColumn.identifier isEqualToString:@"PublicityColumn"])
        property.publicity = [object isEqualTo:@YES] ? YES : NO;
    
    if ([tableColumn.identifier isEqualToString:@"MemoryColumn"])
        property.memory = object;
    
    if ([tableColumn.identifier isEqualToString:@"AtomicityColumn"])
        property.atomicity = object;
    
    if ([tableColumn.identifier isEqualToString:@"EncapsulationColumn"])
        property.encapsulation = object;
    
    if ([tableColumn.identifier isEqualToString:@"TypeColumn"])
        property.type = object;
    
    if ([tableColumn.identifier isEqualToString:@"NameColumn"])
        property.name = object;
}

@end

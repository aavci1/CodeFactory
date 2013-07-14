//
//  ClassViewController.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/1/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "ClassViewController.h"

#import "ClassModel.h"
#import "TraceLog.h"
#import "NSString+StringExtensions.h"

@interface ClassViewController ()

@property (strong, nonatomic) NSArray *classes;

@end

@implementation ClassViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil delegate:(id)aDelegate
{
    TraceLog();
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        _classes = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Classes" ofType:@"plist"]];
        _delegate = aDelegate;
    }
    
    return self;
}

- (void)awakeFromNib
{
    TraceLog();
    
    // select NSObject on startup
    [self.superCombo selectItemAtIndex:[self.classes indexOfObject:@"NSObject"]];
}

- (void)validate
{
    TraceLog();
    
    BOOL prev = NO, next = YES;

    if ([self.delegate.model.className isEqualToString:@""])
        next = NO;
    else if (![self.delegate.model.className isValidIdentifier])
        next = NO;
    
    if ([self.delegate.model.superName isEqualToString:@""])
        next = NO;
    else if (![self.delegate.model.superName isValidIdentifier])
        next = NO;
    
    [self.delegate canDoPrev:prev];
    [self.delegate canDoNext:next];
}

- (NSString *)title
{
    return @"Class information";
}

- (NSString *)description
{
    return @"Enter your class name and super class name";
}

// text change notification
- (void)controlTextDidChange:(NSNotification *)obj
{
    TraceLog();
    
    self.delegate.model.projectName = [self.projectField.stringValue trimmed];
    self.delegate.model.className = [self.classField.stringValue trimmed];
    self.delegate.model.superName = [self.superCombo.stringValue trimmed];
    
    [self validate];
}

// NSComboBoxDataSource
- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox
{
    TraceLog();
    
    return self.classes.count;
}

- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)index
{
    TraceLog();
    
    return self.classes[index];
}

// NSComboBoxDelegate
- (void)comboBoxSelectionDidChange:(NSNotification *)notification
{
    TraceLog();
    
    self.delegate.model.projectName = [self.projectField.stringValue trimmed];
    self.delegate.model.className = [self.classField.stringValue trimmed];
    self.delegate.model.superName = [self.classes[self.superCombo.indexOfSelectedItem] trimmed];
    
    [self validate];
}

@end

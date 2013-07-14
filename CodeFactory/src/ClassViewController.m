//
//  ClassViewController.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/1/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "ClassViewController.h"

#import "Model.h"
#import "TraceLog.h"
#import "NSString+StringExtensions.h"

@interface ClassViewController ()

@property (strong, nonatomic) Model *model;
@property (strong, nonatomic) NSArray *classes;

@end

@implementation ClassViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model:(Model *)aModel
{
    TraceLog();
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        _model = aModel;
        _classes = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Classes" ofType:@"plist"]];
    }
    
    return self;
}

- (void)awakeFromNib
{
    TraceLog();
    
    // select NSObject on startup
    [self.superCombo selectItemAtIndex:[self.classes indexOfObject:@"NSObject"]];
}

- (BOOL)isValid
{
    TraceLog();
    
    NSString *message = @"";
    BOOL classNameValid = YES, superNameValid = YES;
    
    if ([self.model.className isEqualToString:@""]) {
        message = @"Class name can not be empty.";
        classNameValid = NO;
    } else if (![self.model.className isValidIdentifier]) {
        message = [NSString stringWithFormat:@"\'%@\' is not a valid class name.", self.model.className];
        classNameValid = NO;
    } else if ([self.model.superName isEqualToString:@""]) {
        message = @"Super class name can not be empty.";
        superNameValid = NO;
    } else if (![self.model.superName isValidIdentifier]) {
        message = [NSString stringWithFormat:@"\'%@\' is not a valid class name.", self.model.superName];
        superNameValid = NO;
    }
    
    [self.classErrorImage setHidden:classNameValid];
    [self.superErrorImage setHidden:superNameValid];
    
    [self.errorMessage setStringValue:message];
    
    return classNameValid && superNameValid;
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
    
    self.model.projectName = [self.projectField.stringValue trimmed];
    self.model.className = [self.classField.stringValue trimmed];
    self.model.superName = [self.superCombo.stringValue trimmed];
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
    
    self.model.projectName = [self.projectField.stringValue trimmed];
    self.model.className = [self.classField.stringValue trimmed];
    self.model.superName = [self.classes[self.superCombo.indexOfSelectedItem] trimmed];
}

@end

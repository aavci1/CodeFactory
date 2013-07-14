//
//  ClassViewController.h
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/1/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Model;

@interface ClassViewController : NSViewController <NSComboBoxDataSource, NSComboBoxDelegate>

// initializers
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model:(Model *)aModel;

// methods
- (BOOL)isValid;

- (NSString *)title;
- (NSString *)description;

// outlets
@property (weak) IBOutlet NSTextField *projectField;
@property (weak) IBOutlet NSTextField *classField;
@property (weak) IBOutlet NSComboBox *superCombo;
@property (weak) IBOutlet NSImageView *classErrorImage;
@property (weak) IBOutlet NSImageView *superErrorImage;
@property (weak) IBOutlet NSTextField *errorMessage;

@end

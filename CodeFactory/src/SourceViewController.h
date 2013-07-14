//
//  InterfaceViewController.h
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/3/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Model;

@interface SourceViewController : NSViewController

// properties
@property (strong, nonatomic) NSString *extension;

// initializers
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model:(Model *)aModel extension:(NSString *)anExtension;

// methods
- (BOOL)isValid;

- (NSString *)title;
- (NSString *)description;

// outlets
@property (unsafe_unretained) IBOutlet NSTextView *textView;

@end

//
//  InterfaceViewController.h
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/3/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "NavigationDelegate.h"

@interface SourceViewController : NSViewController

// properties
@property (weak, nonatomic) id<NavigationDelegate> delegate;

// initializers
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil delegate:(id)aDelegate;

// methods
- (void)validate;

- (NSString *)title;
- (NSString *)description;

- (NSString *)string;

// outlets
@property (unsafe_unretained) IBOutlet NSTextView *textView;

@end
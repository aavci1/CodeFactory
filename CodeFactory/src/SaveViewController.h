//
//  SaveViewController.h
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/3/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "NavigationDelegate.h"

@class DragView;

@interface SaveViewController : NSViewController

// properties
@property (weak, nonatomic) id<NavigationDelegate> delegate;

// initializers
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil delegate:(id)aDelegate;

// methods
- (void)validate;

- (NSString *)name;
- (NSString *)description;

// outlets
@property (weak) IBOutlet DragView *dragView;

@end

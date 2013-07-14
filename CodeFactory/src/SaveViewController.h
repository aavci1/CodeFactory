//
//  SaveViewController.h
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/3/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Model;
@class DragView;

@interface SaveViewController : NSViewController

// initializers
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil model:(Model *)aModel;

// methods
- (BOOL)isValid;

- (NSString *)title;
- (NSString *)description;

// outlets
@property (weak) IBOutlet DragView *dragView;

@end

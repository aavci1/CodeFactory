//
//  NavigationDelegate.h
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/1/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ClassModel;

@protocol NavigationDelegate <NSObject>

- (ClassModel*)model;

- (void)canDoPrev:(BOOL)prev;
- (void)canDoNext:(BOOL)next;

@end

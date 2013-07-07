//
//  NSString+StringExtensions.h
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/1/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringExtensions)

- (NSString *)trimmed;
- (NSUInteger)indexOfChar:(char)c;
- (BOOL)isValidIdentifier;

@end

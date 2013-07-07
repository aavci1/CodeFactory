//
//  NSString+StringExtensions.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/1/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "NSString+StringExtensions.h"

@implementation NSString (StringExtensions)

- (NSString *)trimmed
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSUInteger)indexOfChar:(char)c
{
    for (int i = 0; i < self.length; ++i)
        if ([self characterAtIndex:i] == c)
            return i;
    
    return NSNotFound;
}

- (BOOL)isValidIdentifier
{
    NSString *letters = @"_ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    NSString *numerals = @"0123456789";

    if (self.length == 0)
        return NO;
    
    if ([letters indexOfChar:[self characterAtIndex:0]] == NSNotFound)
        return NO;
    
    for (int i = 1; i < self.length; ++i) {
        char c = [self characterAtIndex:i];
        
        if (([letters indexOfChar:c] == NSNotFound) && ([numerals indexOfChar:c] == NSNotFound))
            return NO;
    }
    
    return YES;
}

@end

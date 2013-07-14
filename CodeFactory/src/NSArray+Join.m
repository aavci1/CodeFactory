//
//  NSArray+Join.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/14/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "NSArray+Join.h"

#import "TraceLog.h"

@implementation NSArray (Join)

- (NSString *)joinWithPrefix:(NSString *)aPrefix postfix:(NSString *)aPostfix
{
    TraceLog();
    
    NSMutableString *string = [NSMutableString new];
    
    if (self.count == 0)
        return string;
    
    [string appendFormat:@"%@%@", aPrefix, self[0]];
    
    for (int i = 1; i < self.count; ++i)
        [string appendFormat:@", %@", self[i]];
    
    [string appendString:aPostfix];
    
    return string;
}

@end

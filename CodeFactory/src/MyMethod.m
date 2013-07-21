//
//  MyMethod.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/22/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "MyMethod.h"

#import "TraceLog.h"

@implementation MyMethod

- (id)init
{
    TraceLog();
    
    self = [super init];
    
    if (self)
    {
        _returnType = @"void";
        _name = @"";
        _parameters = [NSMutableArray new];
    }
    
    return self;
}

@end

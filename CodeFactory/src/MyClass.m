//
//  MyClass.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/22/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "MyClass.h"

#import "TraceLog.h"

@implementation MyClass

- (id)init
{
    TraceLog();
    
    self = [super init];
    
    if (self)
    {
        _name = @"";
        _superClass = @"";
        _protocols = [NSMutableArray new];
        _properties = [NSMutableArray new];
    }
    
    return self;
}

@end

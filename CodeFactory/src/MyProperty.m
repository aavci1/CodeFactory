//
//  MyProperty.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/22/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "MyProperty.h"

#import "TraceLog.h"

@implementation MyProperty

- (id)init
{
    TraceLog();
    
    self = [super init];
    
    if (self)
    {
        _publicity = YES;
        _attributes = 0;
        _type = @"NSString";
        _name = @"";
    }
    
    return self;
}

@end

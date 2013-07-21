//
//  MyInitializer.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/22/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "MyInitializer.h"

#import "TraceLog.h"

@implementation MyInitializer

- (id)init
{
    TraceLog();
    
    self = [super init];
    
    if (self)
    {
        _parameters = [NSMutableArray new];
    }
    
    return self;
}

@end

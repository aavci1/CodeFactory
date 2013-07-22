//
//  CodeGenerator.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/22/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "CodeGenerator.h"

#import "MyClass.h"
#import "MyInitializer.h"
#import "MyMethod.h"
#import "MyProperty.h"
#import "TraceLog.h"

@implementation CodeGenerator

+ (NSString *)fileHeader:(NSDictionary *)params
{
    TraceLog();
    
    NSMutableString *source = [NSMutableString stringWithString:
                               @"//\n"
                               @"//  ${FileName}\n"
                               @"//  ${ProjectName}\n"
                               @"//\n"
                               @"//  Created by ${UserName} on ${Date}.\n"
                               @"//  Copyright (c) ${Year} ${UserName}. All rights reserved.\n"
                               @"//\n"];
    
    NSEnumerator *keyEnumarator = [params keyEnumerator];
    
    for (NSString *key in keyEnumarator)
        [source replaceOccurrencesOfString:key withString:[params objectForKey:key] options:NSCaseInsensitiveSearch range:NSMakeRange(0, source.length)];
    
    return source;
}

+ (NSString *)interface:(MyClass *)aClass
{
    TraceLog();
    
    NSMutableString *source = [NSMutableString new];
    
    return source;
}

+ (NSString *)implementation:(MyClass *)aClass
{
    TraceLog();
    
    NSMutableString *source = [NSMutableString new];
    
    return source;
}

@end

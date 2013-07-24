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

+ (NSMutableString *)header:(NSDictionary *)params
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
    
    NSString *projectName = @"";
    NSString *fileName = @"";
    
    // get user name
    NSString *userName = NSFullUserName();
    
    // create date formatter
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateStyle = NSDateFormatterShortStyle;
    
    // get date string
    NSString *date = [formatter stringFromDate:[NSDate date]];

    // get year component
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSYearCalendarUnit fromDate:[NSDate date]];
    
    // convert to number
    NSString *year = [NSString stringWithFormat:@"%li", (long)[components year]];
    
    NSDictionary *params = @{
                             @"${ProjectName}": projectName,
                             @"${UserName}": userName,
                             @"${FileName}": fileName,
                             @"${Date}": date,
                             @"${Year}": year
                             };
    
    NSMutableString *source = [NSMutableString new];
    
    [source appendString:[self header:params]];
    
    return source;
}

+ (NSString *)implementation:(MyClass *)aClass
{
    TraceLog();
    
    NSMutableString *source = [NSMutableString new];
    
    return source;
}

@end

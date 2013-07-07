//
//  ClassModel.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/1/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "ClassModel.h"

#import "NSString+StringExtensions.h"
#include "TraceLog.h"

@implementation Property

-(id)init
{
    TraceLog();
    
    self = [super init];
    
    if (self)
    {
        _publicity = YES;
        _memory = @"default";
        _atomicity = @"default";
        _encapsulation = @"default";
        _type = @"NSString*";
        _name = @"";
    }
    
    return self;
}

@end

@implementation Method

- (id)init
{
    TraceLog();
    
    self = [super init];
    
    if (self)
    {
        _type = InstanceMethod;
        _returnType = @"";
        _name = @"";
        _parameters = @"";
    }
    
    return self;
}

- (NSString *)string
{
    NSMutableString *result = [NSMutableString new];
    
    if (self.type == ClassMethod)
        [result appendString:@"+"];
    else
        [result appendString:@"-"];
    
    [result appendFormat:@" (%@)%@", self.returnType, self.name];
    
    [result appendString: self.parameters];
    
    return result;
}

@end

@implementation ClassModel

- (id)init
{
    TraceLog();
    
    self = [super init];
    
    if (self)
    {
        _projectName = @"";
        _className = @"";
        _superName = @"";
        _protocols = [NSMutableArray new];
        _properties = [NSMutableArray new];
        _methods = [NSMutableArray new];
    }
    
    return self;
}
- (NSString *)header:(NSString *)extension
{
    TraceLog();
    
    NSMutableString *source = [NSMutableString stringWithCapacity:0];
    
    NSString *userName = NSFullUserName();
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M/d/YY"];
    
    NSDateComponents *components = [calendar components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    
    [source appendString:@"//\n"];
    [source appendFormat:@"//  %@.%@\n", self.className, extension];
    [source appendFormat:@"//  %@\n", self.projectName];
    [source appendString:@"//\n"];
    [source appendFormat:@"//  Created by %@ on %@.\n", userName, [formatter stringFromDate:[NSDate date]]];
    [source appendFormat:@"//  Copyright (c) %i %@. All rights reserved.\n", (int)[components year], userName];
    [source appendString:@"//\n\n"];
    
    return source;
}

- (NSString *)join:(NSArray *)strings withPrefix:(NSString *)prefix andPostfix:(NSString *)postfix
{
    NSMutableString *string = [NSMutableString new];
    
    if (strings.count == 0)
        return string;
    
    [string appendFormat:@"%@%@", prefix, strings[0]];
    
    for (int i = 1; i < strings.count; ++i)
        [string appendFormat:@", %@", strings[i]];
    
    [string appendString:postfix];
    
    return string;
}

- (NSString *)propertiesWithPublicity:(BOOL)publicity
{
    TraceLog();
    
    NSMutableString *source = [NSMutableString new];
    
    int propertyCount = 0;
    
    for (Property *property in _properties)
    {
        if (property.publicity != publicity)
            continue;
        
        propertyCount++;
        
        [source appendString:@"@property"];
        
        NSMutableArray *attributes = [NSMutableArray arrayWithCapacity:3];
        
        if (![property.memory isEqualToString:@"default"])
            [attributes addObject:property.memory];
        
        if (![property.atomicity isEqualToString:@"default"])
            [attributes addObject:property.atomicity];
        
        if (![property.encapsulation isEqualToString:@"default"])
            [attributes addObject:property.encapsulation];
        
        [source appendFormat:@"%@ %@ %@;\n", [self join:attributes withPrefix:@" (" andPostfix:@")"], property.type, property.name];
    }
    
    if (propertyCount)
        [source appendString:@"\n"];
    
    return source;
}

- (NSString *)interface
{
    TraceLog();
    
    NSMutableString *source = [NSMutableString stringWithCapacity:0];
    
    // header
    [source appendString:[self header:@"h"]];
    
    // imports
    [source appendString:@"#import <Cocoa/Cocoa.h>\n\n"];
    
    // interface
    [source appendFormat:@"@interface %@ : %@", self.className, self.superName];
    
    // protocols
    NSMutableArray *protocols = [NSMutableArray arrayWithCapacity:self.protocols.count];
    
    for (NSString *protocol in self.protocols)
        if (![[protocol trimmed] isEqualToString:@""])
            [protocols addObject:[protocol trimmed]];
    
    [source appendString:[self join:protocols withPrefix:@" <" andPostfix:@">"]];
    
    [source appendString:@"\n\n"];

    [source appendString:[self propertiesWithPublicity:YES]];

    for (Method *method in self.methods)
         [source appendFormat:@"%@;\n", [method string]];
    
    [source appendString:@"@end\n"];
    
    return source;
}

- (NSString *)implementation
{
    TraceLog();
    
    NSMutableString *source = [NSMutableString stringWithCapacity:0];
    
    [source appendString:[self header:@"m"]];
    
    [source appendFormat:@"#import \"%@.h\"\n\n", self.className];
    
    [source appendFormat:@"@interface %@ ()\n\n", self.className];
    
    [source appendString:[self propertiesWithPublicity:NO]];
    
    [source appendString:@"@end\n\n"];
    
    [source appendFormat:@"@implementation %@\n\n", self.className];
    
    for (Method *method in self.methods)
        [source appendFormat:@"%@\n{\n\n}\n\n", [method string]];
    
    [source appendString:@"@end\n"];
    
    return source;
}
@end

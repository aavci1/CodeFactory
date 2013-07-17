//
//  ClassModel.m
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/1/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import "Model.h"

#import "NSArray+Join.h"
#import "NSString+StringExtensions.h"
#import "TraceLog.h"


@interface Property ()

@property (strong, nonatomic) NSArray *primitiveTypes;

@end

@implementation Property

- (id)init
{
    TraceLog();
    
    self = [super init];
    
    if (self)
    {
        _primitiveTypes = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PrimitiveTypes" ofType:@"plist"]];

        _publicity = YES;
        _memory = @"default";
        _atomicity = @"default";
        _encapsulation = @"default";
        _type = @"NSString";
        _name = @"";
    }
    
    return self;
}

- (NSString *)string
{
    TraceLog();
    
    NSMutableString *source = [NSMutableString new];
    
    if ([[self.name trimmed] isEqualToString:@""])
        return source;
    
    [source appendString:@"@property"];

    NSMutableArray *attributes = [NSMutableArray new];
    
    if (![self.memory isEqualToString:@"default"])
        [attributes addObject:self.memory];
    
    if (![self.atomicity isEqualToString:@"default"])
        [attributes addObject:self.atomicity];
    
    if (![self.encapsulation isEqualToString:@"default"])
        [attributes addObject:self.encapsulation];
    
    [source appendString:[attributes joinWithPrefix:@" (" postfix:@")"]];
    
    if ([self.primitiveTypes indexOfObject:self.type] != NSNotFound)
        [source appendFormat:@" %@ ", self.type];
    else
        [source appendFormat:@" %@ *", self.type];
    
    [source appendFormat:@"%@;\n", self.name];
    
    return source;
}

@end

@implementation Model

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
        
        [source appendString:[property string]];
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
    
    [source appendString:[protocols joinWithPrefix:@" <" postfix:@">"]];
    
    [source appendString:@"\n\n"];

    // properties
    [source appendString:[self propertiesWithPublicity:YES]];
    
    // end
    [source appendString:@"@end\n"];
    
    return source;
}

- (NSString *)implementation
{
    TraceLog();
    
    NSMutableString *source = [NSMutableString stringWithCapacity:0];
    
    // header
    [source appendString:[self header:@"m"]];
    
    // imports
    [source appendFormat:@"#import \"%@.h\"\n\n", self.className];
    
    // interface
    [source appendFormat:@"@interface %@ ()\n\n", self.className];
    
    // private properties
    [source appendString:[self propertiesWithPublicity:NO]];
    
    // end
    [source appendString:@"@end\n\n"];
    
    // implementation
    [source appendFormat:@"@implementation %@\n\n", self.className];
    
    // implement description class
    [source appendString:@"- (NSString *)description\n{\n"];
    
    if (self.properties.count <= 0) {
        [source appendString:@"    return [NSString stringWithFormat:@\"<%@: %p>\", [self class], self];\n"];
    } else {
        [source appendString:@"    return [NSString stringWithFormat:@\"<%@: %p, %@>\", [self class], self,\n"];
        [source appendString:@"            @{"];
        [source appendFormat:@"\n                 @\"%@\": self.%@", [self.properties[0] name], [self.properties[0] name]];
        
        for (int i = 1; i < self.properties.count; ++i)
            [source appendFormat:@",\n                 @\"%@\": self.%@", [self.properties[i] name], [self.properties[i] name]];
        [source appendString:@"\n             }\n"];
        [source appendString:@"            ];\n"];
    }
    [source appendString:@"}\n\n"];
    
    // end
    [source appendString:@"@end\n"];
    
    return source;
}
@end

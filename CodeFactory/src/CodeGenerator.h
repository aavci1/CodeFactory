//
//  CodeGenerator.h
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/22/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyClass;

@interface CodeGenerator : NSObject

+ (NSString *)fileHeader:(NSDictionary *)params;

+ (NSString *)interface:(MyClass *)aClass;
+ (NSString *)implementation:(MyClass *)aClass;

@end

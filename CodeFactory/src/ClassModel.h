//
//  ClassModel.h
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/1/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Property : NSObject

@property (assign, nonatomic) BOOL publicity;
@property (strong, nonatomic) NSString *memory;
@property (strong, nonatomic) NSString *atomicity;
@property (strong, nonatomic) NSString *encapsulation;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *name;

@end

enum MethodType {
    ClassMethod = 0,
    InstanceMethod = 1
};

@interface Method : NSObject

@property (nonatomic) enum MethodType type;
@property (strong, nonatomic) NSString *returnType;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *parameters;

@end

@interface ClassModel : NSObject

@property (strong, nonatomic) NSString *projectName;
@property (strong, nonatomic) NSString *className;
@property (strong, nonatomic) NSString *superName;
@property (strong, nonatomic) NSMutableArray *protocols;
@property (strong, nonatomic) NSMutableArray *properties;
@property (strong, nonatomic) NSMutableArray *methods;

- (NSString *)interface;
- (NSString *)implementation;

@end

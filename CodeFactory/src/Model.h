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

@interface Model : NSObject

@property (strong, nonatomic) NSString *projectName;
@property (strong, nonatomic) NSString *className;
@property (strong, nonatomic) NSString *superName;
@property (strong, nonatomic) NSMutableArray *protocols;
@property (strong, nonatomic) NSMutableArray *properties;

- (NSString *)interface;
- (NSString *)implementation;

@end

//
//  MyProperty.h
//  CodeFactory
//
//  Created by Abdurrahman AVCI on 7/22/13.
//  Copyright (c) 2013 Abdurrahman AVCI. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    PropertyAttributeDefault    = 0x00,
    
    // memory
    PropertyAttributeWeak       = 0x01,
    PropertyAttributeStrong     = 0x02,
    PropertyAttributeAssign     = 0x04,
    PropertyAttributeCopy       = 0x08,
    
    // atomicity
    PropertyAttributeAtomic     = 0x10,
    PropertyAttributeNonatomic  = 0x20,

    // encapsulation
    PropertyAttributeReadOnly   = 0x40,
    PropertyAttributeReadWrite  = 0x80,
};

@interface MyProperty : NSObject

@property (assign, nonatomic) BOOL publicity;
@property (assign, nonatomic) NSInteger attributes;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *name;

@end

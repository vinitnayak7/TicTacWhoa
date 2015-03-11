//
//  Selection.m
//  TicTacWhoa
//
//  Created by Vinit Nayak on 3/8/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Selection.h"

@implementation Selection
@synthesize picker;
@synthesize rowInPicker;

-(id)initWithPicker:(NSString*)pickerView forRow:(NSInteger) row {
    self = [super init];
    if (self) {
        self.picker = pickerView;
        self.rowInPicker = row;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:picker forKey:@"picker"];
    [coder encodeInteger:rowInPicker forKey:@"rowInPicker"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        picker = [coder decodeObjectForKey:@"picker"];
        rowInPicker = [coder decodeIntegerForKey:@"rowInPicker"];
    }
    return self;
}
@end
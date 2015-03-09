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

-(id)initWithPicker:(UIPickerView*)pickerView forRow:(NSInteger) row {
    self = [super init];
    if (self) {
        self.picker = pickerView;
        self.rowInPicker = row;
    }
    return self;
}
@end
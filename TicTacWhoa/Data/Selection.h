//
//  NSObject_Selection.h
//  TicTacWhoa
//
//  Created by Vinit Nayak on 3/8/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Selection : NSObject<NSCoding>
@property NSString *picker;
@property NSInteger rowInPicker;
// TODO make currentlySelected work! (?)

-(id)initWithPicker:(NSString*)pickerView forRow:(NSInteger)row;
@end

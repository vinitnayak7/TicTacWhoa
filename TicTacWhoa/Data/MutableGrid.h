//
//  NSObject_MutableGrid.h
//  TicTacWhoa
//
//  Created by Vinit Nayak on 3/8/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GridProtocol.h"

@interface MutableGrid: NSObject<GridProtocol>
- (id)initWithPickers:(NSArray *)pickers;
- (BOOL)isSelectedForPicker:(UIPickerView *)picker forRow:(NSInteger)row;
@end

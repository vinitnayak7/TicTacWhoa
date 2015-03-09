//
//  GridProtocol.h
//  TicTacWhoa
//
//  Created by Vinit Nayak on 3/8/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol GridProtocol <NSObject>

-(void)resetDataState;
-(BOOL)validate;
-(BOOL)saveGrid;
-(NSInteger)getAttempts;
-(void)updateSelectionForPicker:(UIPickerView *)picker forRow:(NSInteger)row;



@end

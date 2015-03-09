//
//  MainBoardViewController.h
//  TicTacWhoa
//
//  Created by Vinit Nayak on 2/28/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainBoardViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate>

//========== ROW 1 =====================
@property (weak, nonatomic) IBOutlet UIPickerView *m1x1pickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *m1x2pickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *m1x3pickerView;



//========== ROW 2 =====================
@property (weak, nonatomic) IBOutlet UIPickerView *m2x1pickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *m2x2pickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *m2x3pickerView;


//========== ROW 3 =====================
@property (weak, nonatomic) IBOutlet UIPickerView *m3x1pickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *m3x2pickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *m3x3pickerView;


@end

//
//  ChangePassphraseViewController.h
//  TicTacWhoa
//
//  Created by Vinit Nayak on 4/28/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePassphraseViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate, UIPickerViewAccessibilityDelegate, UIAlertViewDelegate>


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


@property (weak, nonatomic) IBOutlet UIView *optionsView;
- (IBAction)cancelAction:(id)sender;
- (IBAction)submitAction:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *inputOrderSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *multipleSelectionSwitch;
- (IBAction)changePassphraseAction:(id)sender;
- (IBAction)multiSelectSwitchAction:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *changePassphraseSwitch;
@property (weak, nonatomic) IBOutlet UILabel *toggleHintLabel;

@end

//
//  MainBoardViewController.h
//  TicTacWhoa
//
//  Created by Vinit Nayak on 2/28/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"

@interface NewUserViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate, UIPickerViewAccessibilityDelegate>

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

@property (strong,nonatomic) MenuViewController *menuViewController;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;


- (IBAction)submitButtonAction:(id)sender;
- (IBAction)cancelButtonAction:(id)sender;
- (IBAction)logoutAction:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *inputOrderSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *inputOrderInDigitSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *multipleSelectionSwitch;
+ (void)showAlert:(NSString *)message
        withDelegate:(id)delegate
        withTitle:(NSString *)title
        withOtherButtonTitle:(NSString*)otherButtonTitle;

@end

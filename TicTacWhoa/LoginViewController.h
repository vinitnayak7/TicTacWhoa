//
//  LoginViewController.h
//  TicTacWhoa
//
//  Created by Vinit Nayak on 2/27/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewUserViewController.h"
#import "MenuViewController.h"

@interface LoginViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate, UIPickerViewAccessibilityDelegate, UIAlertViewDelegate>


@property (strong,nonatomic) NewUserViewController *createUserViewController;
@property (strong,nonatomic) MenuViewController *menuViewController;

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

//========== ROW 4 =====================
@property (weak, nonatomic) IBOutlet UIPickerView *m4x1pickerView;


@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UIButton *loginExistingUser;
@property (weak, nonatomic) IBOutlet UIButton *loginNewUser;

//========== Actions
- (IBAction)submitExistingUser:(id)sender;
- (IBAction)submitNewUser:(id)sender;
- (IBAction)resetGridAction:(id)sender;

-(id)initWithUsername:(NSString*)name;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIButton *createUserButton;

@end

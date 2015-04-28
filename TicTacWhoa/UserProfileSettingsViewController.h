//
//  UserProfileSettingsViewController.h
//  TicTacWhoa
//
//  Created by Vinit Nayak on 4/21/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MutableGrid.h"
#import "AccessibilityUtils.h"

@interface UserProfileSettingsViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIGestureRecognizerDelegate, UIPickerViewAccessibilityDelegate, UIAlertViewDelegate>


@property (strong, nonatomic) IBOutlet UIView *changeEmailView;
@property (weak, nonatomic) IBOutlet UILabel *currentEmailLabel;
@property (weak, nonatomic) IBOutlet UITextField *currentEmailTextField;


@property (strong, nonatomic) IBOutlet UIView *changeAccountView;
@property (weak, nonatomic) IBOutlet UITextField *accountUsernameTextField;


- (IBAction)saveEmailAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)changeAccountAction:(id)sender;


typedef NS_ENUM(NSInteger, SETTING_STATE) {
    CHANGE_EMAIL,
    CHANGE_PASSPHRASE,
    CHANGE_ACCOUNT
};

-(id)initWithEnum:(SETTING_STATE) setting;
@end

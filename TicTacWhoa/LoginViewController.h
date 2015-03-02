//
//  LoginViewController.h
//  TicTacWhoa
//
//  Created by Vinit Nayak on 2/27/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainBoardViewController.h"

@interface LoginViewController : UIViewController

@property (strong,nonatomic) MainBoardViewController *boardViewController;

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

//========== Actions
- (IBAction)submitCredentials:(id)sender;

@end

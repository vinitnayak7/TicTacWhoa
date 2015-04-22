//
//  UserProfileViewController.h
//  TicTacWhoa
//
//  Created by Vinit Nayak on 4/21/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfileSettingsViewController.h"

@interface UserProfileViewController : UIViewController

@property (strong,nonatomic) UserProfileSettingsViewController *userProfileSettingsViewController;


- (IBAction)changePassphraseAction:(id)sender;
- (IBAction)changeEmailAction:(id)sender;
- (IBAction)changeAccountAction:(id)sender;

@end

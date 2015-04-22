//
//  MenuViewController.h
//  TicTacWhoa
//
//  Created by Vinit Nayak on 3/14/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserProfileViewController.h"

@interface MenuViewController : UIViewController

@property (strong,nonatomic) UserProfileViewController *userProfileViewController;

- (IBAction)userProfileAction:(id)sender;
- (IBAction)logoutAction:(id)sender;
@end

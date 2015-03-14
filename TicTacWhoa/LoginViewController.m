//
//  LoginViewController.m
//  TicTacWhoa
//
//  Created by Vinit Nayak on 2/27/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import "LoginViewController.h"
#import "MainBoardViewController.h"
#import "Constants.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize userNameTextField;
@synthesize boardViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // UNCOMMENT TO ERASE ALL NSUserDefaults
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitExistingUser:(id)sender {
    if ([userNameTextField.text isEqual: @""]) {
        NSLog(@"username empty");
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:userNameTextField.text]) {
        boardViewController = [[MainBoardViewController alloc] initWithUserName:userNameTextField.text forNewUser:NO];
        [self presentViewController:boardViewController animated:YES completion:nil];
        [userNameTextField setText:@""];
    } else {
        [LoginViewController showAlert:@"No user found, please login to create a new account!"];
    }
}

- (IBAction)submitNewUser:(id)sender {
    if ([userNameTextField.text isEqual: @""]) {
        NSLog(@"username empty");
        return;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults objectForKey:userNameTextField.text]) {
        boardViewController = [[MainBoardViewController alloc] initWithUserName:userNameTextField.text forNewUser:YES];
        [self presentViewController:boardViewController animated:YES completion:nil];
        [userNameTextField setText:@""];
    } else {
        [LoginViewController showAlert:@"User already exists, please select a different username!"];
    }
}

+(void)showAlert:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Hold up"
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil];
    [alert show];
}
@end

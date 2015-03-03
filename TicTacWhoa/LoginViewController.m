//
//  LoginViewController.m
//  TicTacWhoa
//
//  Created by Vinit Nayak on 2/27/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import "LoginViewController.h"
#import "MainBoardViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize userNameTextField;
@synthesize boardViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// TODO everything
- (IBAction)submitExistingUser:(id)sender {
    if ([userNameTextField.text isEqual: @""]) {
        NSLog(@"username empty");
    }
    
    // Go to the next MainBoardViewController
    boardViewController = [[MainBoardViewController alloc] initWithNibName:@"MainBoardViewController" bundle:nil];
    [self presentViewController:boardViewController animated:YES completion:nil];
}

// TODO everything
- (IBAction)submitNewUser:(id)sender {
    boardViewController = [[MainBoardViewController alloc] initWithNibName:@"MainBoardViewController" bundle:nil];
    [self presentViewController:boardViewController animated:YES completion:nil];
}
@end

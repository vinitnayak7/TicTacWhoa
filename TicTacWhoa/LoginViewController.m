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
@synthesize passwordTextField;
@synthesize boardViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)submitCredentials:(id)sender {
    if ([userNameTextField.text isEqual: @""]) {
        NSLog(@"username empty");
    }
    if ([passwordTextField.text isEqual: @""]) {
        NSLog(@"pass empty");
    }
    
    // Go to the next MainBoardViewController
    boardViewController = [[MainBoardViewController alloc] initWithNibName:@"MainBoardViewController" bundle:nil];
//    [self.navigationController pushViewController:boardViewController animated:YES];
    [self presentViewController:boardViewController animated:YES completion:nil];
}
@end

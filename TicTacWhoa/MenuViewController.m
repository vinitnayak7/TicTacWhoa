//
//  MenuViewController.m
//  TicTacWhoa
//
//  Created by Vinit Nayak on 3/14/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize userProfileViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)userProfileAction:(id)sender {
    userProfileViewController = [[UserProfileViewController alloc] initWithNibName:@"UserProfileViewController" bundle:nil];
    [self presentViewController:userProfileViewController animated:YES completion:nil];
}

- (IBAction)logoutAction:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate setUserName:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

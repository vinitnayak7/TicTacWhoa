//
//  UserProfileViewController.m
//  TicTacWhoa
//
//  Created by Vinit Nayak on 4/21/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import "UserProfileViewController.h"
#import "AppDelegate.h"
#import "ChangePassphraseViewController.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController
@synthesize userProfileSettingsViewController;

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

- (IBAction)changePassphraseAction:(id)sender {
    ChangePassphraseViewController *vc = [[ChangePassphraseViewController alloc] initWithNibName:@"ChangePassphraseViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)changeEmailAction:(id)sender {
    userProfileSettingsViewController = [[UserProfileSettingsViewController alloc]
                                         initWithEnum:CHANGE_EMAIL];
    [self.navigationController pushViewController:userProfileSettingsViewController animated:YES];
}

- (IBAction)changeAccountAction:(id)sender {
    userProfileSettingsViewController = [[UserProfileSettingsViewController alloc]
                                         initWithEnum:CHANGE_ACCOUNT];
    [self.navigationController pushViewController:userProfileSettingsViewController animated:YES];
}

- (IBAction)logoutAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate setUserName:nil];
}

- (IBAction)cancelAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end

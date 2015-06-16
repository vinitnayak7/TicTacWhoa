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

@implementation MenuViewController {
    NSString* userName;
}
@synthesize userProfileViewController;
@synthesize userNameLabel;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [userNameLabel setText:[NSString stringWithFormat:@"Welcome, %@", self->userName]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithUserName:(NSString*)name {
    self = [super init];
    if (self) {
        self->userName = name;
    }
    return self;
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
    [self.navigationController pushViewController:userProfileViewController animated:YES];
}

- (IBAction)logoutAction:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate setUserName:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end

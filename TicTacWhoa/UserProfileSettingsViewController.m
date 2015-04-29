//
//  UserProfileSettingsViewController.m
//  TicTacWhoa
//
//  Created by Vinit Nayak on 4/21/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import "UserProfileSettingsViewController.h"
#import "AppDelegate.h"

@interface UserProfileSettingsViewController ()

@end

@implementation UserProfileSettingsViewController {
    SETTING_STATE currentState;
}

@synthesize changeEmailView;
@synthesize currentEmailLabel;
@synthesize currentEmailTextField;
@synthesize changeAccountView;
@synthesize accountUsernameTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    changeEmailView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if (currentState == CHANGE_EMAIL) {
        [self setInitialEmailState];
        [[self view] addSubview:changeEmailView];
    } else if (currentState == CHANGE_ACCOUNT) {
        [[self view] addSubview:changeAccountView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithEnum:(SETTING_STATE) setting {
    self = [super initWithNibName:@"UserProfileSettingsViewController" bundle:nil];
    if (self) {
        currentState = setting;
    }
    return self;
}


-(void)setInitialEmailState {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *userEmailKey = [NSString stringWithFormat:@"%@_email", appDelegate.userName];
    
    if ([defaults objectForKey:userEmailKey]) {
        currentEmailLabel.text = [defaults objectForKey:userEmailKey];
    } else {
        currentEmailLabel.text = @"No email registered";
    }
}

- (IBAction)saveEmailAction:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *userEmailKey = [NSString stringWithFormat:@"%@_email", appDelegate.userName];
    
    [defaults setObject:currentEmailTextField.text forKey:userEmailKey];
    [defaults synchronize];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Saved" message:@"Your email was saved!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changeAccountAction:(id)sender {
    if ([accountUsernameTextField.text isEqualToString:@""] || accountUsernameTextField.text == nil) {
        return;
    }
    UIViewController *currentViewController = self.presentingViewController;
    LoginViewController *loginViewController = [[LoginViewController alloc] initWithUsername:accountUsernameTextField.text];
    [self dismissViewControllerAnimated:NO completion:^{
        [currentViewController presentViewController:loginViewController animated:NO completion:nil];
    }];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate setUserName:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]) {
        [self cancelAction:nil];
    }
}


@end


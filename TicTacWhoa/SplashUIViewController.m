//
//  SplashUIViewController.m
//  TicTacWhoa
//
//  Created by Vinit Nayak on 2/27/15.
//  Copyright (c) 2015 Vinit Nayak. All rights reserved.
//

#import "SplashUIViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "MainBoardViewController.h"

@interface SplashUIViewController ()

@end

@implementation SplashUIViewController
@synthesize loginViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [NSThread sleepForTimeInterval:2.5];
    // Override point for customization after application launch.
    loginViewController = [[MainBoardViewController alloc] initWithNibName:@"MainBoardViewController" bundle:nil];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = self.loginViewController;
    [appDelegate.window makeKeyAndVisible];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

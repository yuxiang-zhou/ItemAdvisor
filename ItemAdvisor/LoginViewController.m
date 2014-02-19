//
//  LoginViewController.m
//  ItemAdvisor
//
//  Created by Xiaoming Chen on 19/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)login:(id)sender {
    [[UserManager getUserManager] loginAs:[_userName text] withPassword:[_passWord text] withDelegate:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onUserInfoReceived:(NSDictionary *)userData {
    
}

-(void)onLogin:(NSDictionary *)response {
    if([[UserManager getUserManager] isAuthenticated]) {
        NSLog(@"User Authenticated");
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Announcement" message: @"It turns out that you are playing Addicus!" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

@end

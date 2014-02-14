//
//  MakePostViewController.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 07/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "MakePostViewController.h"

@interface MakePostViewController ()

@end

@implementation MakePostViewController
- (IBAction)CancelOrDraft:(id)sender {
    TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"即将返回" message:@"要保存草稿吗？" confirmButtonTitle:@"不要" cancelButtonTitle:@"要"];
    
    [alertView handleCancel:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }         handleConfirm:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    alertView.TLAnimationType = (arc4random_uniform(10) % 2 == 0) ? TLAnimationType3D : tLAnimationTypeHinge;
    [alertView show];
    alertView.buttonColor = UIColorFromRGB(0x718969);
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

@end

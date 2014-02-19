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

-(void)refreshScrollView
{
    CGSize contentSize=CGSizeMake(320, 458);
    [_scrollView setContentSize:contentSize];
}

- (IBAction)addPic:(id)sender
{
    UIImageView *aImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"haha.jpeg"]];
    [aImageView setFrame:CGRectMake(20, 20, PIC_WIDTH, PIC_HEIGHT)];
    [addedPicArray addObject:aImageView];
    [_scrollView addSubview:aImageView];
    
//    for (UIImageView *img in addedPicArray) {
//        
//        CABasicAnimation *positionAnim=[CABasicAnimation animationWithKeyPath:@"position"];
//        [positionAnim setFromValue:[NSValue valueWithCGPoint:CGPointMake(img.center.x, img.center.y)]];
//        [positionAnim setToValue:[NSValue valueWithCGPoint:CGPointMake(img.center.x+INSETS+PIC_WIDTH, img.center.y)]];
//        [positionAnim setDelegate:self];
//        [positionAnim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//        [positionAnim setDuration:0.25f];
//        [img.layer addAnimation:positionAnim forKey:nil];
//        
//        [img setCenter:CGPointMake(img.center.x+INSETS+PIC_WIDTH, img.center.y)];
//    }
    
    UIButton *sampleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sampleButton setFrame:CGRectMake(97,15,20,20)];
    [sampleButton setTitle:@"" forState:UIControlStateNormal];
    [sampleButton setBackgroundImage:[[UIImage imageNamed:@"deleteIcon.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0] forState:UIControlStateNormal];
    [sampleButton addTarget:self action:@selector(deleteButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:sampleButton];
    
//    [self refreshScrollView];
}

-(void)deleteButtonPressed
{
    for (UIView *v in [_scrollView subviews]) {
        [v removeFromSuperview];
    }
    [addedPicArray removeAllObjects];
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

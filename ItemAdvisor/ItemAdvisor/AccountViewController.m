//
//  SecondViewController.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 05/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController ()


@end

@implementation AccountViewController
@synthesize profileImage;
- (IBAction)editProfile:(UIButton *)sender {
}

- (void)viewDidLoad
{
    //Initialise profile image
    UIImage *image = [UIImage imageNamed:@"haha.jpeg"];
    [profileImage setImage:image];
    
    //Initialise username
    NSString *name = @"陈 晓明";
    self.userName.text = [NSString stringWithFormat:@"%@", name];
    [self.userName setFont:[UIFont systemFontOfSize:20]];
    
    //Initialise introduction
    NSString *intro = @"自我简介";
    self.userIntroduction.text = [NSString stringWithFormat:@"%@", intro];
    [self.userIntroduction setFont:[UIFont systemFontOfSize:11]];
    
    //Initialise details(post,following,follower,stuff)
    NSUInteger numOfpost = 88;
    [self.postDetail setTitle:[NSString stringWithFormat:@"\n%lu", (unsigned long)numOfpost] forState:UIControlStateNormal];

    NSUInteger numOffollowing = 88;
    [self.followingDetail setTitle:[NSString stringWithFormat:@"\n%lu", (unsigned long)numOffollowing] forState:UIControlStateNormal];
    
    NSUInteger numOffollower = 88;
    [self.followerDetail setTitle:[NSString stringWithFormat:@"\n%lu", (unsigned long)numOffollower] forState:UIControlStateNormal];
    
    NSUInteger numOfstuff = 88;
    [self.stuffDetail setTitle:[NSString stringWithFormat:@"\n%lu", (unsigned long)numOfstuff] forState:UIControlStateNormal];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

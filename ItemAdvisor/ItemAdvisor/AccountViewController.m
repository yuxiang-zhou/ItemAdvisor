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


- (void)viewDidLoad
{
    //Create scroll view
    UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, 320, 460)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    [self.view addSubview:scrollview];
    scrollview.contentSize = CGSizeMake(320,960);
    
    //Create 4 buttons switching contents in scroll view
    //日志
    UIButton *post = [UIButton buttonWithType:UIButtonTypeCustom];
    [post setBackgroundColor:[UIColor blackColor]];
    post.frame = CGRectMake(0, 0, 80, 20);
    [post setTitle:@"日志" forState:UIControlStateNormal];
    [post.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
    [self.view addSubview: post];
    
    NSUInteger numOfpost = [UserManager getUserManager].noPost;
    NSString *postDetailTitle = [NSString stringWithFormat:@"%lu",(unsigned long)numOfpost];
    
    UIButton *postNum = [UIButton buttonWithType:UIButtonTypeCustom];
    [postNum setBackgroundColor:[UIColor blackColor]];
    postNum.frame = CGRectMake(0, 20, 80, 20);
    [postNum setTitle:postDetailTitle forState:UIControlStateNormal];
    [postNum.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:12]];
    [self.view addSubview: postNum];
    
    //关注
    UIButton *follow = [UIButton buttonWithType:UIButtonTypeCustom];
    [follow setBackgroundColor:[UIColor blackColor]];
    follow.frame = CGRectMake(80, 0, 80, 20);
    [follow setTitle:@"关注" forState:UIControlStateNormal];
    [follow.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
    [self.view addSubview: follow];
    
    NSUInteger numOfFollow = [UserManager getUserManager].noFollowing;
    NSString *followDetailTitle = [NSString stringWithFormat:@"%lu",(unsigned long)numOfFollow];
    
    UIButton *followNum = [UIButton buttonWithType:UIButtonTypeCustom];
    [followNum setBackgroundColor:[UIColor blackColor]];
    followNum.frame = CGRectMake(80, 20, 80, 20);
    [followNum setTitle:followDetailTitle forState:UIControlStateNormal];
    [followNum.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:12]];
    [self.view addSubview: followNum];
    
    //粉丝
    UIButton *follower = [UIButton buttonWithType:UIButtonTypeCustom];
    [follower setBackgroundColor:[UIColor blackColor]];
    follower.frame = CGRectMake(160, 0, 80, 20);
    [follower setTitle:@"粉丝" forState:UIControlStateNormal];
    [follower.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
    [self.view addSubview: follower];
    
    NSUInteger numOfFollower = [UserManager getUserManager].noFollower;
    NSString *followerDetailTitle = [NSString stringWithFormat:@"%lu",(unsigned long)numOfFollower];
    
    UIButton *followerNum = [UIButton buttonWithType:UIButtonTypeCustom];
    [followerNum setBackgroundColor:[UIColor blackColor]];
    followerNum.frame = CGRectMake(160, 20, 80, 20);
    [followerNum setTitle:followerDetailTitle forState:UIControlStateNormal];
    [followerNum.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:12]];
    [self.view addSubview: followerNum];
    
    //物品
    UIButton *things = [UIButton buttonWithType:UIButtonTypeCustom];
    [things setBackgroundColor:[UIColor blackColor]];
    things.frame = CGRectMake(240, 0, 80, 20);
    [things setTitle:@"物品" forState:UIControlStateNormal];
    [things.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
    [self.view addSubview: things];
    
    NSUInteger numOfThings = [UserManager getUserManager].noItems;
    NSString *thingsDetailTitle = [NSString stringWithFormat:@"%lu",(unsigned long)numOfThings];
    
    UIButton *thingsNum = [UIButton buttonWithType:UIButtonTypeCustom];
    [thingsNum setBackgroundColor:[UIColor blackColor]];
    thingsNum.frame = CGRectMake(240, 20, 80, 20);
    [thingsNum setTitle:thingsDetailTitle forState:UIControlStateNormal];
    [thingsNum.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:12]];
    [self.view addSubview: thingsNum];
    
    //Create profile pic
    UIImageView *myProfile = [[UIImageView alloc] init];
    if (![UserManager getUserManager].profile) {
        myProfile.image = [UIImage imageNamed:@"haha.jpeg"];
    }else{
        myProfile.image = [UserManager getUserManager].profile;
    }
    myProfile.frame = CGRectMake(0, 0, 160, 160);
    [scrollview addSubview:myProfile];
    
    
    //Create and Initialise username
    NSString *nameString = [NSString stringWithFormat:@"%@ %@", [UserManager getUserManager].lastName, [UserManager getUserManager].firstName];
    UITextView *tfn = [[UITextView alloc] initWithFrame:CGRectMake(165, 60, 150, 30)];
    tfn.textColor = [UIColor blackColor];
    tfn.font = [UIFont fontWithName:@"Trebuchet MS" size:20];
    tfn.text = nameString;
    tfn.editable = NO;
    [scrollview addSubview:tfn];
    
    //Create and Initialise introduction
    NSString *intro = [NSString stringWithFormat:@"%@", [UserManager getUserManager].description];
    UITextView *tf = [[UITextView alloc] initWithFrame:CGRectMake(165, 90, 150, 65)];
    tf.textColor = [UIColor blackColor];
    tf.font = [UIFont fontWithName:@"Trebuchet MS" size:11];
    tf.text = intro;
    tf.editable = NO;
    [scrollview addSubview:tf];
    
    //Create edit button
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [editButton setBackgroundColor:UIColorFromRGB(0x502d25)];
    editButton.frame = CGRectMake(0, 160, 320, 60);
    [editButton setTitle:@"编  辑" forState:UIControlStateNormal];
    [editButton.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:22]];
    [scrollview addSubview: editButton];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

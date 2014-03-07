//
//  SecondViewController.h
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 05/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserManager.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AccountViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UITextView *userName;
@property (weak, nonatomic) IBOutlet UITextView *userIntroduction;
@property (weak, nonatomic) IBOutlet UIButton *postDetail;
@property (weak, nonatomic) IBOutlet UIButton *followingDetail;
@property (weak, nonatomic) IBOutlet UIButton *followerDetail;
@property (weak, nonatomic) IBOutlet UIButton *stuffDetail;

@end

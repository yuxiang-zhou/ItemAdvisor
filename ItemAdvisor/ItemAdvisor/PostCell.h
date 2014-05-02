//
//  PostCell.h
//  PostTableView
//
//  Created by Xiaoming Chen on 06/04/2014.
//  Copyright (c) 2014 Xiaoming Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PostEntity.h"
#import "TagEntity.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface PostCell : UITableViewCell

@property (strong,nonatomic)NSMutableArray *addedTagArray;

@property (strong,nonatomic)UIButton *colorButton;
@property (strong,nonatomic)UIColor *color;
@property (strong,nonatomic)UIImageView *profilePic;
@property (strong,nonatomic)UILabel *name;
@property (strong,nonatomic)UILabel *time;

@property (strong,nonatomic)UIImageView *firstPic;
@property (strong,nonatomic)UILabel *desc;
@property (strong,nonatomic)UILabel *likeLabel;
@property (strong,nonatomic)UILabel *likes;
@property (strong,nonatomic)UILabel *oneCommentLabel;
@property (strong,nonatomic)UILabel *recentCommment;
@property (strong,nonatomic)UIButton *makeCommentButton;
@property (strong,nonatomic)UILabel * commentLogo;
@property (strong,nonatomic)UILabel *commentLogoText;
@property (strong,nonatomic)UIButton *toLikeButton;
@property (strong,nonatomic)UILabel * likeLogo;
@property (strong,nonatomic)UILabel *likeLogoText;
@property (strong,nonatomic)UILabel *tagDecisionMark;

@property NSURL* url;
@property NSURL* profileUrl;
@property PostEntity* post;

+(CGFloat)cellHeight;
-(void)createContentInCell;
-(void)createTagLabels;

@end

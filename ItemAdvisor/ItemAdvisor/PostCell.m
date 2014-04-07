//
//  PostCell.m
//  PostTableView
//
//  Created by Xiaoming Chen on 06/04/2014.
//  Copyright (c) 2014 Xiaoming Chen. All rights reserved.
//

#import "PostCell.h"


@implementation PostCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createContentInCell];
    }
    return self;
}

-(void)createContentInCell{
    [self createColorButtonWithColor:_color];
    [self addContentColorButton];
    [self createTagLabel];
    [self createImageView];
    [self createTexts];
}


-(void)createColorButtonWithColor:(UIColor *)color{
    if (!_colorButton) {
        _colorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _colorButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_colorButton setBackgroundColor:color];
        _colorButton.frame = CGRectMake(160, 0, 160, 120);
        [self addSubview: _colorButton];
    }
}

-(void)addContentColorButton{
    //Create profile pic in color button of post
    if (!_profilePic) {
        _profilePic = [[UIImageView alloc] init];
        _profilePic.frame = CGRectMake(10, 10, 46, 46);
        [_colorButton addSubview:_profilePic];
    }
    
    //Create labels in right button of post
    if (!_name) {
        _name = [[UILabel alloc]initWithFrame:CGRectMake(8, 63, 100, 25)];
        _name.backgroundColor = [UIColor clearColor];
        _name.textColor = [UIColor whiteColor];
        _name.textAlignment = NSTextAlignmentLeft;
        [_name setFont:[UIFont fontWithName:@"Trebuchet MS" size:23]];
        [_colorButton  addSubview:_name];
    }
    
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(8, 90, 100, 25)];
    time.text = [NSString stringWithFormat:@"08/08/2014"];
    time.backgroundColor = [UIColor clearColor];
    time.textColor = [UIColor whiteColor];
    time.textAlignment = NSTextAlignmentLeft;
    [time setFont:[UIFont fontWithName:@"Trebuchet MS" size:12]];
    [_colorButton  addSubview:time];

}

-(void)createTexts{
    if (!_desc) {
        _desc = [[UILabel alloc]initWithFrame:CGRectMake(10, 445, 320, 0)];
        _desc.text = [NSString stringWithFormat:@"tttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttttt"];
        _desc.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
        _desc.textColor = [UIColor blackColor];
        _desc.backgroundColor = [UIColor clearColor];
        _desc.textAlignment = NSTextAlignmentLeft;
        [_desc sizeToFit];
        _desc.numberOfLines = 0;
        [self addSubview:_desc];
    }
    
    //Create like list in the post
    UILabel *likeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 465, 10, 10)];
    likeLabel.backgroundColor = [UIColor lightGrayColor];
    likeLabel.layer.cornerRadius = 10.0;
    [self addSubview:likeLabel];
    
    UILabel *likes = [[UILabel alloc]initWithFrame:CGRectMake(25, 462, 320, 0)];
    likes.text = [NSString stringWithFormat:@"(List of Likes)"];
    likes.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
    likes.textColor = [UIColor blackColor];
    likes.backgroundColor = [UIColor clearColor];
    likes.textAlignment = NSTextAlignmentLeft;
    [likes sizeToFit];
    likes.numberOfLines = 0;
    [self addSubview:likes];
    
    //Create like list in the post
    UILabel *oneCommentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 482, 10, 10)];
    oneCommentLabel.backgroundColor = [UIColor lightGrayColor];
    oneCommentLabel.layer.cornerRadius = 10.0;
    [self addSubview:oneCommentLabel];
    
    UILabel *recentCommment = [[UILabel alloc]initWithFrame:CGRectMake(25, 479, 320, 0)];
    recentCommment.text = [NSString stringWithFormat:@"(Show one comment, and the num of comments)"];
    recentCommment.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
    recentCommment.textColor = [UIColor blackColor];
    recentCommment.backgroundColor = [UIColor clearColor];
    recentCommment.textAlignment = NSTextAlignmentLeft;
    [recentCommment sizeToFit];
    recentCommment.numberOfLines = 0;
    [self addSubview:recentCommment];
    
    //--Create buttons in the bottom
    UIButton *makeCommentButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 500, 60, 25)];
    [makeCommentButton setBackgroundColor:UIColorFromRGB(0xd2d2d2)];
    [self addSubview:makeCommentButton];
    
    UILabel * commentLogo= [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 15, 15)];
    commentLogo.backgroundColor = [UIColor grayColor];
    commentLogo.layer.cornerRadius = 10.0;
    [makeCommentButton addSubview:commentLogo];
    
    UILabel *commentLogoText = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, 35, 15)];
    commentLogoText.text = [NSString stringWithFormat:@"评论"];
    commentLogoText.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
    commentLogoText.textColor = [UIColor grayColor];
    commentLogoText.backgroundColor = [UIColor clearColor];
    commentLogoText.textAlignment = NSTextAlignmentLeft;
    [commentLogoText sizeToFit];
    commentLogoText.numberOfLines = 0;
    [makeCommentButton addSubview:commentLogoText];
    
    UIButton *toLikeButton = [[UIButton alloc]initWithFrame:CGRectMake(80, 500, 60, 25)];
    [toLikeButton setBackgroundColor:UIColorFromRGB(0xd2d2d2)];
    [self addSubview:toLikeButton];
    
    UILabel * likeLogo= [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 15, 15)];
    likeLogo.backgroundColor = [UIColor grayColor];
    likeLogo.layer.cornerRadius = 10.0;
    [toLikeButton addSubview:likeLogo];
    
    UILabel *likeLogoText = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, 35, 15)];
    likeLogoText.text = [NSString stringWithFormat:@"赞"];
    likeLogoText.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
    likeLogoText.textColor = [UIColor grayColor];
    likeLogoText.backgroundColor = [UIColor clearColor];
    likeLogoText.textAlignment = NSTextAlignmentLeft;
    [likeLogoText sizeToFit];
    likeLogoText.numberOfLines = 0;
    [toLikeButton addSubview:likeLogoText];
}

-(void)createImageView{
    _firstPic = [[UIImageView alloc]initWithFrame:CGRectMake(0, 120, 320, 320)];
    [self addSubview:_firstPic];
}

-(void)createTagLabel{
//    for (_i=0; _i<[_addedTagArray count]; _i++) {
//
        UILabel *tag = [[UILabel alloc]init];
        tag.backgroundColor = [UIColor lightGrayColor];
        tag.layer.cornerRadius = 10.0;
        tag.frame = CGRectMake(10, 85, 24, 24);
        [self addSubview:tag];
//
//        switch (_i) {
//            case 0:
//                tag.frame = CGRectMake(10, 85, 24, 24);
//                break;
//            case 1:
//                tag.frame = CGRectMake(44, 85, 24, 24);
//                break;
//            case 2:
//                tag.frame = CGRectMake(78, 85, 24, 24);
//                break;
//            case 3:
//                tag.frame = CGRectMake(112, 85, 24, 24);
//                break;
//            case 4:
//                tag.frame = CGRectMake(10, 50, 24, 24);
//                break;
//            case 5:
//                tag.frame = CGRectMake(44, 50, 24, 24);
//                break;
//            case 6:
//                tag.frame = CGRectMake(78, 50, 24, 24);
//                break;
//            case 7:
//                tag.frame = CGRectMake(112, 50, 24, 24);
//                break;
//                
//            default:
//                tag.frame = CGRectMake(10, 85, 24, 24);
//                break;
//        }
    
}
+(CGFloat)cellHeight{
    return 530;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

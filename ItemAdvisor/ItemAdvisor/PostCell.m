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
    [self createTagArray];
    [self createImageView];
    [self createTexts];
}

-(void)createTagArray{
    if (!_addedTagArray) {
        _addedTagArray = [[NSMutableArray alloc]init];
    }
}

-(void)setColor:(UIColor *)color{
    _color = color;
    [_colorButton setBackgroundColor:color];
}

-(void)createColorButtonWithColor:(UIColor *)color{
    if (!_colorButton) {
        _colorButton = [UIButton buttonWithType:UIButtonTypeCustom];
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
    
    if (!_time) {
        _time = [[UILabel alloc]initWithFrame:CGRectMake(8, 90, 100, 25)];
        _time.text = [NSString stringWithFormat:@"08/08/2014"];
        _time.backgroundColor = [UIColor clearColor];
        _time.textColor = [UIColor whiteColor];
        _time.textAlignment = NSTextAlignmentLeft;
        [_time setFont:[UIFont fontWithName:@"Trebuchet MS" size:12]];
        [_colorButton  addSubview:_time];
        

    }

}

-(void)createTexts{
    if (!_desc) {
        _desc = [[UILabel alloc]initWithFrame:CGRectMake(10, 445, 320, 15)];
        _desc.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
        _desc.textColor = [UIColor blackColor];
        _desc.backgroundColor = [UIColor clearColor];
        _desc.textAlignment = NSTextAlignmentLeft;
        _desc.numberOfLines = 0;
        [self addSubview:_desc];
    }
    
    //Create like list in the post
    if (!_likeLabel) {
        _likeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 465, 10, 10)];
        _likeLabel.backgroundColor = [UIColor lightGrayColor];
        _likeLabel.layer.cornerRadius = 10.0;
        [self addSubview:_likeLabel];
    }
    
    if (!_likes) {
        _likes = [[UILabel alloc]initWithFrame:CGRectMake(25, 462, 320, 15)];
        _likes.text = [NSString stringWithFormat:@"(List of Likes)"];
        _likes.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
        _likes.textColor = [UIColor blackColor];
        _likes.backgroundColor = [UIColor clearColor];
        _likes.textAlignment = NSTextAlignmentLeft;
        //[_likes sizeToFit];
        _likes.numberOfLines = 0;
        [self addSubview:_likes];
    }
    
    
    //Create like list in the post
    if (!_oneCommentLabel) {
        _oneCommentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 482, 10, 10)];
        _oneCommentLabel.backgroundColor = [UIColor lightGrayColor];
        _oneCommentLabel.layer.cornerRadius = 10.0;
        [self addSubview:_oneCommentLabel];
    }
    
    if (!_recentCommment) {
        _recentCommment = [[UILabel alloc]initWithFrame:CGRectMake(25, 479, 320, 15)];
        _recentCommment.text = [NSString stringWithFormat:@"(Show one comment, and the num of comments)"];
        _recentCommment.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
        _recentCommment.textColor = [UIColor blackColor];
        _recentCommment.backgroundColor = [UIColor clearColor];
        _recentCommment.textAlignment = NSTextAlignmentLeft;
        //[_recentCommment sizeToFit];
        _recentCommment.numberOfLines = 0;
        [self addSubview:_recentCommment];
    }
    
    
    //--Create buttons in the bottom
    if (!_makeCommentButton) {
        _makeCommentButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 500, 60, 25)];
        [_makeCommentButton setBackgroundColor:UIColorFromRGB(0xd2d2d2)];
        [self addSubview:_makeCommentButton];
    }
    
    if (!_commentLogo) {
        _commentLogo= [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 15, 15)];
        _commentLogo.backgroundColor = [UIColor grayColor];
        _commentLogo.layer.cornerRadius = 10.0;
        [_makeCommentButton addSubview:_commentLogo];
    }
    
    if (!_commentLogoText) {
        _commentLogoText = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, 35, 15)];
        _commentLogoText.text = [NSString stringWithFormat:@"评论"];
        _commentLogoText.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
        _commentLogoText.textColor = [UIColor grayColor];
        _commentLogoText.backgroundColor = [UIColor clearColor];
        _commentLogoText.textAlignment = NSTextAlignmentLeft;
        [_commentLogoText sizeToFit];
        _commentLogoText.numberOfLines = 0;
        [_makeCommentButton addSubview:_commentLogoText];

    }
    if (!_toLikeButton) {
        _toLikeButton = [[UIButton alloc]initWithFrame:CGRectMake(80, 500, 60, 25)];
        [_toLikeButton setBackgroundColor:UIColorFromRGB(0xd2d2d2)];
        [self addSubview:_toLikeButton];
    }
    
    if (!_likeLogo) {
        _likeLogo= [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 15, 15)];
        _likeLogo.backgroundColor = [UIColor grayColor];
        _likeLogo.layer.cornerRadius = 10.0;
        [_toLikeButton addSubview:_likeLogo];
    }
    
    if (!_likeLogoText) {
        _likeLogoText = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, 35, 15)];
        _likeLogoText.text = [NSString stringWithFormat:@"赞"];
        _likeLogoText.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
        _likeLogoText.textColor = [UIColor grayColor];
        _likeLogoText.backgroundColor = [UIColor clearColor];
        _likeLogoText.textAlignment = NSTextAlignmentLeft;
        [_likeLogoText sizeToFit];
        _likeLogoText.numberOfLines = 0;
        [_toLikeButton addSubview:_likeLogoText];
    }
    
}

-(void)createImageView{
    if (!_firstPic) {
        _firstPic = [[UIImageView alloc]initWithFrame:CGRectMake(0, 120, 320, 320)];
        [self addSubview:_firstPic];
    }
}

-(void)createTagLabels{
    UILabel *truthTag = (UILabel *)[self viewWithTag:100];
    if (!truthTag) {
        for (int i=0; i<[_addedTagArray count]; i++) {
            
            UILabel *tag = [[UILabel alloc]init];
            tag.backgroundColor = [UIColor lightGrayColor];
            tag.layer.cornerRadius = 10.0;
            tag.tag = 100+i;
            [self addSubview:tag];
            
            switch (i) {
                case 0:
                    tag.frame = CGRectMake(10, 85, 24, 24);
                    break;
                case 1:
                    tag.frame = CGRectMake(44, 85, 24, 24);
                    break;
                case 2:
                    tag.frame = CGRectMake(78, 85, 24, 24);
                    break;
                case 3:
                    tag.frame = CGRectMake(112, 85, 24, 24);
                    break;
                case 4:
                    tag.frame = CGRectMake(10, 50, 24, 24);
                    break;
                case 5:
                    tag.frame = CGRectMake(44, 50, 24, 24);
                    break;
                case 6:
                    tag.frame = CGRectMake(78, 50, 24, 24);
                    break;
                case 7:
                    tag.frame = CGRectMake(112, 50, 24, 24);
                    break;
                    
                default:
                    tag.frame = CGRectMake(10, 85, 24, 24);
                    break;
            }
        }

    }
    
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

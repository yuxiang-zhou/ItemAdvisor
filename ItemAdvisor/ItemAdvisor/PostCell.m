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
    [self createTagArray];
    [self createTopPartWithColor:_color];
    [self createMiddlePart];
    [self createBottomPart];
}

-(void)setAddedTagArray:(NSMutableArray *)addedTagArray{
    _firstPic.frame = CGRectMake(15, _prevTagY+10, 160, [self getImageHeight:_firstPic.image]);
    _desc.frame = CGRectMake(15, _prevImgY+10, 290, 15);
}

-(void)createTagArray{
    if (!_addedTagArray) {
        _addedTagArray = [[NSMutableArray alloc]init];
    }
    if (!_tagsWithText) {
        _tagsWithText = [[NSMutableArray alloc]init];
    }
    if (!_tagsWithoutText) {
        _tagsWithoutText = [[NSMutableArray alloc]init];
    }
}

-(void)setColor:(UIColor *)color{
    _color = color;
    [_toCommentButton setBackgroundColor:color];
    [_toLikeButton setBackgroundColor:color];
}

//-(void)createColorButtonWithColor:(UIColor *)color{
//    if (!_colorButton) {
//        _colorButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _colorButton.frame = CGRectMake(160, 0, 160, 120);
//        [self addSubview: _colorButton];
//    }
//}

-(void)createTopPartWithColor:(UIColor *)color{
    //头像，名字，和进入个人主页的按键
    if (!_toAccountViewButton) {
        _toAccountViewButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 203, 80)];
        [self addSubview:_toAccountViewButton];
    }
    if (!_profilePic) {
        _profilePic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        [_toAccountViewButton addSubview:_profilePic];
    }
    if (!_name) {
        _name = [[UILabel alloc]initWithFrame:CGRectMake(70, 20, 133, 25)];
        _name.textColor = [UIColor blackColor];
        _name.textAlignment = NSTextAlignmentLeft;
        [_name setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
        [_toAccountViewButton  addSubview:_name];
    }
    //评论和赞两个色块按键
    if (!_toCommentButton) {
        _toCommentButton = [[UIButton alloc]initWithFrame:CGRectMake(213, 0, 107, 40)];
        _toCommentButton.titleLabel.text = @"评论";
        _toCommentButton.titleLabel.textColor = [UIColor whiteColor];
        _toCommentButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_toCommentButton.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
        [self addSubview:_toCommentButton];
    }
    
    if (!_toLikeButton) {
        _toLikeButton = [[UIButton alloc]initWithFrame:CGRectMake(213, 50, 107, 40)];
        _toLikeButton.titleLabel.text = @"赞";
        _toLikeButton.titleLabel.textColor = [UIColor whiteColor];
        _toLikeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_toLikeButton.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
        [self addSubview:_toLikeButton];
    }
    
}

-(void)createMiddlePart{
    //物品标签，包括小图标和文字
    UILabel *truthTagWithText = (UILabel *)[self viewWithTag:100];
    UILabel *truthTagWithoutText = (UILabel *)[self viewWithTag:200];
    
    if (!truthTagWithText && !truthTagWithoutText) {
        
        [self splitTagsArray];
        
        for (int i=0; i<[_tagsWithText count]; i++) {
            TagEntity *theTag = [[TagEntity alloc]init];
            theTag = [_tagsWithText objectAtIndex:i];
            
            UILabel *tag = [[UILabel alloc]initWithFrame:CGRectMake(15, 100+30*i, 20, 20)];
            tag.backgroundColor = [UIColor lightGrayColor];
            tag.layer.cornerRadius = 10.0;
            tag.tag = 100+i;
            [self addSubview:tag];
            UILabel *tagDescription = [[UILabel alloc]initWithFrame:CGRectMake(45, 100+30*i, 255, 20)];
            tagDescription.text = theTag.description;
            tagDescription.textAlignment = NSTextAlignmentLeft;
            [tagDescription setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
            
            _prevTagY = tag.frame.origin.y+20;
        }
        
    }
    if (!truthTagWithText && !truthTagWithoutText) {
        for (int i=0; i<[_tagsWithoutText count]; i++) {
            UILabel *tag = [[UILabel alloc]initWithFrame:CGRectMake(15+35*i, 190, 20, 20)];
            tag.backgroundColor = [UIColor lightGrayColor];
            tag.layer.cornerRadius = 10.0;
            tag.tag = 200+i;
            [self addSubview:tag];
            
            _prevTagY = tag.frame.origin.y+20;
        }
        
    }
    //图片
    if (!_firstPic) {
        _firstPic = [[UIImageView alloc]initWithFrame:CGRectMake(15, _prevTagY+10, 160, [self getImageHeight:_firstPic.image])];
        _firstPic.contentMode = UIViewContentModeScaleAspectFill;
        _firstPic.clipsToBounds = YES;
        [self addSubview:_firstPic];
        
        _prevImgY = _firstPic.frame.origin.y;
    }
    
    //文字叙述
    if (!_desc) {
        _desc = [[UILabel alloc]initWithFrame:CGRectMake(15, _prevImgY+10, 290, 15)];
        _desc.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
        _desc.textColor = [UIColor blackColor];
        _desc.textAlignment = NSTextAlignmentLeft;
        _desc.numberOfLines = 0;
        [self addSubview:_desc];
        
        _prevTxtY = _desc.frame.origin.y;
    }
}

-(void)createBottomPart{
    //先模拟几个数量
    int NumOfReads = 888;
    int NumOfLikes = 689;
    int NumOfCommts = 389;
    
    //浏览，赞，评论的数量
    UILabel *upperLine = [[UILabel alloc]initWithFrame:CGRectMake(0, _prevTxtY+10, 320, 1)];
    upperLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:upperLine];
    UILabel *underLine = [[UILabel alloc]initWithFrame:CGRectMake(0, _prevTxtY+48, 320, 1)];
    underLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:underLine];
    
    CGFloat upperY = upperLine.frame.origin.y;
    _readLogo = [[UILabel alloc]initWithFrame:CGRectMake(30, upperY+10, 30, 15)];
    _readLogo.text = @"浏览";
    _readLogo.textColor = [UIColor lightGrayColor];
    _readLogo.textAlignment = NSTextAlignmentCenter;
    [_readLogo setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
    [self addSubview:_readLogo];
    _readLogoText = [[UILabel alloc]initWithFrame:CGRectMake(55, upperY+10, 35, 15)];
    _readLogoText.text = [NSString stringWithFormat:@"%d",NumOfReads];
    _readLogoText.textColor = [UIColor lightGrayColor];
    _readLogoText.textAlignment = NSTextAlignmentCenter;
    [_readLogoText setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
    [self addSubview:_readLogoText];
    
    _likeLogo = [[UILabel alloc]initWithFrame:CGRectMake(140, upperY+10, 15, 15)];
    _likeLogo.text = @"赞";
    _likeLogo.textColor = [UIColor lightGrayColor];
    _likeLogo.textAlignment = NSTextAlignmentCenter;
    [_likeLogo setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
    [self addSubview:_likeLogo];
    _likeLogoText = [[UILabel alloc]initWithFrame:CGRectMake(150, upperY+10, 35, 15)];
    _likeLogoText.text = [NSString stringWithFormat:@"%d",NumOfLikes];
    _likeLogoText.textColor = [UIColor lightGrayColor];
    _likeLogoText.textAlignment = NSTextAlignmentCenter;
    [_likeLogoText setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
    [self addSubview:_likeLogoText];
    
    _commentLogo = [[UILabel alloc]initWithFrame:CGRectMake(245, upperY+10, 30, 15)];
    _commentLogo.text = @"评论";
    _commentLogo.textColor = [UIColor lightGrayColor];
    _commentLogo.textAlignment = NSTextAlignmentCenter;
    [_commentLogo setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
    [self addSubview:_commentLogo];
    _commentLogoText = [[UILabel alloc]initWithFrame:CGRectMake(270, upperY+10, 35, 15)];
    _commentLogoText.text = [NSString stringWithFormat:@"%d",NumOfCommts];
    _commentLogoText.textColor = [UIColor lightGrayColor];
    _commentLogoText.textAlignment = NSTextAlignmentCenter;
    [_commentLogoText setFont:[UIFont fontWithName:@"Trebuchet MS" size:13]];
    [self addSubview:_commentLogoText];
    
    
}

- (CGFloat)getImageHeight:(UIImage *)image{
    if (image.size.height > image.size.width) {
        return 240;
    }else if (image.size.height == image.size.width){
        return 160;
    }else{
        return 107;
    }
}

-(void)splitTagsArray{
    if (_addedTagArray) {
        for (int i=0; i<[_addedTagArray count]; i++) {
            TagEntity *theTag = [[TagEntity alloc]init];
            theTag = [_addedTagArray objectAtIndex:i];
            if (!theTag.description) {
                [_tagsWithoutText addObject:theTag];
            }else{
                [_tagsWithText addObject:theTag];
            }
        }
    }
}


//-(void)addContentColorButton{
//    //Create profile pic in color button of post
//    if (!_profilePic) {
//        _profilePic = [[UIImageView alloc] init];
//        _profilePic.frame = CGRectMake(10, 10, 46, 46);
//        [_colorButton addSubview:_profilePic];
//    }
//    
//    //Create labels in right button of post
//    if (!_name) {
//        _name = [[UILabel alloc]initWithFrame:CGRectMake(8, 63, 100, 25)];
//        _name.backgroundColor = [UIColor clearColor];
//        _name.textColor = [UIColor whiteColor];
//        _name.textAlignment = NSTextAlignmentLeft;
//        [_name setFont:[UIFont fontWithName:@"Trebuchet MS" size:23]];
//        [_colorButton  addSubview:_name];
//    }
//    
//    if (!_time) {
//        _time = [[UILabel alloc]initWithFrame:CGRectMake(8, 90, 100, 25)];
//        _time.text = [NSString stringWithFormat:@"08/08/2014"];
//        _time.backgroundColor = [UIColor clearColor];
//        _time.textColor = [UIColor whiteColor];
//        _time.textAlignment = NSTextAlignmentLeft;
//        [_time setFont:[UIFont fontWithName:@"Trebuchet MS" size:12]];
//        [_colorButton  addSubview:_time];
//        
//
//    }
//
//}

//-(void)createTexts{
//    if (!_desc) {
//        _desc = [[UILabel alloc]initWithFrame:CGRectMake(10, 445, 320, 15)];
//        _desc.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
//        _desc.textColor = [UIColor blackColor];
//        _desc.backgroundColor = [UIColor clearColor];
//        _desc.textAlignment = NSTextAlignmentLeft;
//        _desc.numberOfLines = 0;
//        [self addSubview:_desc];
//    }
//    
//    //Create like list in the post
//    if (!_likeLabel) {
//        _likeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 465, 10, 10)];
//        _likeLabel.backgroundColor = [UIColor lightGrayColor];
//        _likeLabel.layer.cornerRadius = 10.0;
//        [self addSubview:_likeLabel];
//    }
//    
//    if (!_likes) {
//        _likes = [[UILabel alloc]initWithFrame:CGRectMake(25, 462, 320, 15)];
//        _likes.text = [NSString stringWithFormat:@"(List of Likes)"];
//        _likes.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
//        _likes.textColor = [UIColor blackColor];
//        _likes.backgroundColor = [UIColor clearColor];
//        _likes.textAlignment = NSTextAlignmentLeft;
//        //[_likes sizeToFit];
//        _likes.numberOfLines = 0;
//        [self addSubview:_likes];
//    }
//    
//    
//    //Create like list in the post
//    if (!_oneCommentLabel) {
//        _oneCommentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 482, 10, 10)];
//        _oneCommentLabel.backgroundColor = [UIColor lightGrayColor];
//        _oneCommentLabel.layer.cornerRadius = 10.0;
//        [self addSubview:_oneCommentLabel];
//    }
//    
//    if (!_recentCommment) {
//        _recentCommment = [[UILabel alloc]initWithFrame:CGRectMake(25, 479, 320, 15)];
//        _recentCommment.text = [NSString stringWithFormat:@"(Show one comment, and the num of comments)"];
//        _recentCommment.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
//        _recentCommment.textColor = [UIColor blackColor];
//        _recentCommment.backgroundColor = [UIColor clearColor];
//        _recentCommment.textAlignment = NSTextAlignmentLeft;
//        //[_recentCommment sizeToFit];
//        _recentCommment.numberOfLines = 0;
//        [self addSubview:_recentCommment];
//    }
//    
//    
//    //--Create buttons in the bottom
//    if (!_makeCommentButton) {
//        _makeCommentButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 500, 60, 25)];
//        [_makeCommentButton setBackgroundColor:UIColorFromRGB(0xd2d2d2)];
//        [self addSubview:_makeCommentButton];
//    }
//    
//    if (!_commentLogo) {
//        _commentLogo= [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 15, 15)];
//        _commentLogo.backgroundColor = [UIColor grayColor];
//        _commentLogo.layer.cornerRadius = 10.0;
//        [_makeCommentButton addSubview:_commentLogo];
//    }
//    
//    if (!_commentLogoText) {
//        _commentLogoText = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, 35, 15)];
//        _commentLogoText.text = [NSString stringWithFormat:@"评论"];
//        _commentLogoText.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
//        _commentLogoText.textColor = [UIColor grayColor];
//        _commentLogoText.backgroundColor = [UIColor clearColor];
//        _commentLogoText.textAlignment = NSTextAlignmentLeft;
//        [_commentLogoText sizeToFit];
//        _commentLogoText.numberOfLines = 0;
//        [_makeCommentButton addSubview:_commentLogoText];
//
//    }
//    if (!_toLikeButton) {
//        _toLikeButton = [[UIButton alloc]initWithFrame:CGRectMake(80, 500, 60, 25)];
//        [_toLikeButton setBackgroundColor:UIColorFromRGB(0xd2d2d2)];
//        [self addSubview:_toLikeButton];
//    }
//    
//    if (!_likeLogo) {
//        _likeLogo= [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 15, 15)];
//        _likeLogo.backgroundColor = [UIColor grayColor];
//        _likeLogo.layer.cornerRadius = 10.0;
//        [_toLikeButton addSubview:_likeLogo];
//    }
//    
//    if (!_likeLogoText) {
//        _likeLogoText = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, 35, 15)];
//        _likeLogoText.text = [NSString stringWithFormat:@"赞"];
//        _likeLogoText.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
//        _likeLogoText.textColor = [UIColor grayColor];
//        _likeLogoText.backgroundColor = [UIColor clearColor];
//        _likeLogoText.textAlignment = NSTextAlignmentLeft;
//        [_likeLogoText sizeToFit];
//        _likeLogoText.numberOfLines = 0;
//        [_toLikeButton addSubview:_likeLogoText];
//    }
//    
//}

//-(void)createImageView{
//    if (!_firstPic) {
//        _firstPic = [[UIImageView alloc]initWithFrame:CGRectMake(0, 120, 320, 320)];
//        _firstPic.contentMode = UIViewContentModeScaleAspectFill;
//        _firstPic.clipsToBounds = YES;
//        [self addSubview:_firstPic];
//    }
//}
//
//-(void)createTagLabels{
//    UILabel *truthTag = (UILabel *)[self viewWithTag:100];
//    if (!truthTag) {
//        for (int i=0; i<[_addedTagArray count]; i++) {
//            
//            UILabel *tag = [[UILabel alloc]init];
//            tag.backgroundColor = [UIColor lightGrayColor];
//            tag.layer.cornerRadius = 10.0;
//            tag.tag = 100+i;
//            [self addSubview:tag];
//            
//            switch (i) {
//                case 0:
//                    tag.frame = CGRectMake(10, 85, 24, 24);
//                    break;
//                case 1:
//                    tag.frame = CGRectMake(44, 85, 24, 24);
//                    break;
//                case 2:
//                    tag.frame = CGRectMake(78, 85, 24, 24);
//                    break;
//                case 3:
//                    tag.frame = CGRectMake(112, 85, 24, 24);
//                    break;
//                case 4:
//                    tag.frame = CGRectMake(10, 50, 24, 24);
//                    break;
//                case 5:
//                    tag.frame = CGRectMake(44, 50, 24, 24);
//                    break;
//                case 6:
//                    tag.frame = CGRectMake(78, 50, 24, 24);
//                    break;
//                case 7:
//                    tag.frame = CGRectMake(112, 50, 24, 24);
//                    break;
//                    
//                default:
//                    tag.frame = CGRectMake(10, 85, 24, 24);
//                    break;
//            }
//        }
//
//    }
//    
//}

+(CGFloat)cellHeight{
    return 800;
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

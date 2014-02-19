//
//  PostEntity.h
//  ItemAdvisor
//
//  Created by Hongcheng Guo on 12/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostTag.h"

@interface PostEntity : NSObject

@property (weak,nonatomic) NSString *words;
@property (weak,nonatomic) UIImage *images;
@property (weak,nonatomic) PostTag *tags;
@property (weak,nonatomic) NSDate *timeStamp;

@property (nonatomic) NSInteger NumberOfThumbUp;
@property (nonatomic) NSInteger NumberOfThumbDown;
@property (nonatomic) NSInteger NumberOfViews;

-(void)putAThumbUpFor:(PostEntity*)post;
-(void)putAThumbDownFor:(PostEntity*)post;

-(void)makeComment:(NSString*)comment;
-(void)deleteComment;


@end

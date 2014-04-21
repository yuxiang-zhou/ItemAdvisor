//
//  PostEntity.m
//  ItemAdvisor
//
//  Created by Hongcheng Guo on 12/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "PostEntity.h"
#import "PostCommemts.h"

@interface PostEntity()
@property (weak,nonatomic) NSMutableArray *comments;
@end


@implementation PostEntity

-(id)init {
    if(self = [super init]) {
        _content = @"";
        _images = [NSMutableArray new]; // store URL, not UIImage
        _imageURLs = [NSMutableArray new];
        _tags = [NSMutableArray new];   // store NSNumber
//        _timeStamp;
        _postID = 0;
        _userID = 0;
        _NumberOfThumbUp = 0;
        _NumberOfThumbDown = 0;
        _NumberOfViews = 0;
    }
    return self;
}


@end

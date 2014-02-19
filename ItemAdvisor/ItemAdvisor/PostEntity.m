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

-(id)initAPost
{
    self = [super init];
    

    
    return self;
}






-(void)putAThumbUpFor:(PostEntity*)post
{
    self.NumberOfThumbUp++;
}

-(void)putAThumbDownFor:(PostEntity *)post
{
    self.NumberOfThumbDown++;
}



@end

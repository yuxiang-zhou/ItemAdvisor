//
//  PostManager.h
//  ItemAdvisor
//
//  Created by Hongcheng Guo on 12/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostTag.h"
@interface PostManager : NSObject

//managing the post
-(void) makingAPost;
-(void) deleteAPost;
-(void) saveAPost;

-(void) getMostRatedPost;
-(void) getMostRatedPostFrom:(PostTag*)tag;


//managing the comment;
-(void)makeComment:(NSString*)comment;
-(void)deleteCommentwith;

//managing the tags
-(void) addATag;
-(void) deleteATag;





@end

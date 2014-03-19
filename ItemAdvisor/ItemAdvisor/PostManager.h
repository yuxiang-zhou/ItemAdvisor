//
//  PostManager.h
//  ItemAdvisor
//
//  Created by Hongcheng Guo on 12/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostTag.h"
#import "AddPostRequestHandler.h"
#import "GetPostRequestHandler.h"

@protocol PostManagerDelegate
@required
- (void)onPost:(NSNumber *) isSuccess description:(NSString *)desc;
- (void)onGetPost:(NSNumber *) isSuccess content:(NSArray *)list;
@optional
- (void)onPostImageUploaded:(NSNumber *)isUploaded description:(NSString *)desc;
@end

@interface PostManager : NSObject

@property AddPostRequestHandler* addPostRH;
@property GetPostRequestHandler* getPostRH;

+(instancetype) getPostManager;

-(void)newPost:(NSInteger)userID tagList:(NSArray *)tags imageList:(NSArray *)images contents:(NSString *)text withDelegate:(id)delegate;
-(void)getUserPost:(NSInteger)userID range:(NSRange)range withDelegate:(id)delegate;
-(void)getPublicPostwithDelegate:(id)delegate;

@end

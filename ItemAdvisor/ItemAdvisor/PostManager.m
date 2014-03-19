//
//  PostManager.m
//  ItemAdvisor
//
//  Created by Hongcheng Guo on 12/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "PostManager.h"
#import "BridgeManager.h"

@implementation PostManager

+ (instancetype)getPostManager {
    static PostManager *sharedPostManager = nil;
    if (sharedPostManager == nil) {
        sharedPostManager = [[self alloc] init];
    }
    return sharedPostManager;
}

- (id)init {
    if (self = [super init]) {
        // init propertise
        _addPostRH = [[AddPostRequestHandler alloc] initWithDelegate:self];
        _getPostRH = [[GetPostRequestHandler alloc] initWithDelegate:self];
        _uploadPostImageRH = [[UploadPostImageRequestHandler alloc] initWithDelegate:_addPostRH];
    }
    return self;
}

-(void)newPost:(NSInteger)userID tagList:(NSArray *)tags imageList:(NSArray *)images contents:(NSString *)text withDelegate:(id)delegate{
    [_addPostRH addObserver:delegate];
    _addPostRH.images = [NSMutableArray arrayWithArray:images];
    [[BridgeManager getBridgeManager] newPost:userID tagList:tags contents:text];
}

-(void)getPublicPostwithDelegate:(id)delegate {
    [_getPostRH addObserver:delegate];
    [[BridgeManager getBridgeManager] getPublicPost];
}

-(void)getUserPost:(NSInteger)userID range:(NSRange)range withDelegate:(id)delegate {
    [_getPostRH addObserver:delegate];
    [[BridgeManager getBridgeManager] getUserPost:userID range:range];
}

@end

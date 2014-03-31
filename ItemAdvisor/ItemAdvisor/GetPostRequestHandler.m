//
//  GetPostRequestHandler.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 18/03/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "GetPostRequestHandler.h"
#import "PostManager.h"

@implementation GetPostRequestHandler

-(void)onSuccess:(NSDictionary *) jsonData{
    NSNumber *isSuccess = [NSNumber numberWithBool:[[jsonData objectForKey:@"result"]  isEqual: @"YES"]];
    NSMutableArray *posts = [NSMutableArray new];
    if([self.delegate respondsToSelector:@selector(onGetPost:content:)])
        [self.delegate performSelector:@selector(onGetPost:content:) withObject:isSuccess withObject:posts];
    
    for (id dele in observers) {
        if([dele conformsToProtocol:@protocol(PostManagerDelegate)] && [dele respondsToSelector:@selector(onGetPost:content:)])
            [dele performSelector:@selector(onGetPost:content:) withObject:isSuccess withObject:posts];
    }
    
    [observers removeAllObjects];
}

@end

//
//  AddPostRequestHandler.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 18/03/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "AddPostRequestHandler.h"
#import "PostManager.h"

@implementation AddPostRequestHandler

-(void)onSuccess:(NSDictionary *) jsonData{
    NSNumber *isSuccess = [NSNumber numberWithBool:[[jsonData objectForKey:@"result"]  isEqual: @"YES"]];;
    if([self.delegate respondsToSelector:@selector(onPost:description:)])
        [self.delegate performSelector:@selector(onPost:description:) withObject:isSuccess withObject:[jsonData objectForKey:@"description"]];
    
    for (id dele in observers) {
        if([dele conformsToProtocol:@protocol(PostManagerDelegate)] && [dele respondsToSelector:@selector(onPost:description:)])
            [dele performSelector:@selector(onPost:description:) withObject:isSuccess withObject:[jsonData objectForKey:@"description"]];
    }
    
    [observers removeAllObjects];
}

@end

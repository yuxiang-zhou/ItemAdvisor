//
//  UserInfoRequestHandler.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 19/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "UserInfoRequestHandler.h"

@implementation UserInfoRequestHandler

-(void)onSuccess:(NSDictionary *) jsonData{
    if([self.delegate respondsToSelector:@selector(onUserInfoReceived:)])
        [self.delegate performSelector:@selector(onUserInfoReceived:) withObject:jsonData];
}

@end

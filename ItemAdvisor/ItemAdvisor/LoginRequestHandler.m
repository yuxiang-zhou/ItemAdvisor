//
//  LoginRequestHandler.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 19/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "LoginRequestHandler.h"
#import "UserManager.h"

@implementation LoginRequestHandler

-(void)onSuccess:(NSDictionary *) jsonData{
    if([self.delegate respondsToSelector:@selector(onLogin:)])
        [self.delegate performSelector:@selector(onLogin:) withObject:jsonData];
    
    for (id dele in observers) {
        if([dele conformsToProtocol:@protocol(UserManagerDelegate)])
            [dele performSelector:@selector(onLogin:) withObject:jsonData];
    }
    
    [observers removeAllObjects];
}

@end

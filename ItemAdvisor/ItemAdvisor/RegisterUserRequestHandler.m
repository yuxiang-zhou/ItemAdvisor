//
//  RegisterUserRequestHandler.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 21/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "RegisterUserRequestHandler.h"
#import "BridgeManager.h"
#import "UserManager.h"

@implementation RegisterUserRequestHandler

-(void)onSuccess:(NSDictionary *) jsonData{
    NSNumber * isRegistered = [NSNumber numberWithBool:[[jsonData objectForKey:@"result"]  isEqual: @"YES"]];
    if(isRegistered) {
        [[UserManager getUserManager].uploadImageRH addObserver:self];
        [[BridgeManager getBridgeManager] uploadImage:[UserManager getUserManager].profile];
    } else {
        if([self.delegate respondsToSelector:@selector(onRegistUser:)])
            [self.delegate performSelector:@selector(onRegistUser:) withObject:isRegistered];
        
        for (id dele in observers) {
            if([dele conformsToProtocol:@protocol(UserManagerDelegate)])
                [dele performSelector:@selector(onRegistUser:) withObject:isRegistered];
        }
        
        [observers removeAllObjects];
    }
}

-(void) onImageUploaded:(BOOL)isUploaded {
    if([self.delegate respondsToSelector:@selector(onRegistUser:)])
        [self.delegate performSelector:@selector(onRegistUser:) withObject:[NSNumber numberWithBool:isUploaded]];
    
    for (id dele in observers) {
        if([dele conformsToProtocol:@protocol(UserManagerDelegate)])
            [dele performSelector:@selector(onRegistUser:) withObject:[NSNumber numberWithBool:isUploaded]];
    }
    
    [observers removeAllObjects];
}

@end

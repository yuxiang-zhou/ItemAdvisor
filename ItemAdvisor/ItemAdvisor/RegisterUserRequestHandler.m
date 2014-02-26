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
        [[BridgeManager getBridgeManager] uploadImage:[UserManager getUserManager].profile forUser:[jsonData objectForKey:@"useremail"]];
    } else {
        if([self.delegate respondsToSelector:@selector(onRegistUser:description:)])
            [self.delegate performSelector:@selector(onRegistUser:description:) withObject:isRegistered withObject:[jsonData objectForKey:@"description"]];
        
        for (id dele in observers) {
            if([dele conformsToProtocol:@protocol(UserManagerDelegate)])
                [dele performSelector:@selector(onRegistUser:description:) withObject:isRegistered withObject:[jsonData objectForKey:@"description"]];
        }
        
        [observers removeAllObjects];
    }
}

-(void) onImageUploaded:(BOOL)isUploaded {
    NSString *errorMsg = @"Success";
    if(!isUploaded)
        errorMsg = @"Image failed to uplaod";
    if([self.delegate respondsToSelector:@selector(onRegistUser:description:)])
        [self.delegate performSelector:@selector(onRegistUser:description:) withObject:[NSNumber numberWithBool:isUploaded] withObject:errorMsg];
    
    for (id dele in observers) {
        if([dele conformsToProtocol:@protocol(UserManagerDelegate)])
            [dele performSelector:@selector(onRegistUser:description:) withObject:[NSNumber numberWithBool:isUploaded] withObject:errorMsg];
    }
    
    [observers removeAllObjects];
}

@end

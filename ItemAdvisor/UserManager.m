//
//  UserManager.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 12/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager
{
    BOOL authenticationState;
}

+ (instancetype)getUserManager {
    static UserManager *sharedUserManager = nil;
    if (sharedUserManager == nil) {
        sharedUserManager = [[self alloc] init];
    }
    return sharedUserManager;
}

- (id)init {
    if (self = [super init]) {
        // init propertise
        authenticationState = NO;
    }
    return self;
}

-(BOOL) isAuthenticated {
//    return authenticationState;
    return YES;
}

-(void) updateUserInfo {
//    TODO: update user info
}

-(BOOL) loginAs:(NSString *)userLogin withPassword:(NSString *)password {
    self.userId = 11234;
    self.firstName = @"Xiaoming";
    self.lastName = @"Chen";
    self.description = @"I'am lazy to write descriptions...";
    self.email = @"xiaoming.chen10@gmail.com";
    authenticationState = YES;
    return authenticationState;
}

@end

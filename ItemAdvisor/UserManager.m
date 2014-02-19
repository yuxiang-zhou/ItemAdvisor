//
//  UserManager.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 12/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "UserManager.h"
#import "BridgeManager.h"

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
        _userinfoRH = [[UserInfoRequestHandler alloc] initWithDelegate:self];
    }
    return self;
}

-(BOOL) isAuthenticated {
//    return authenticationState;
    return YES;
}

-(void) updateUserInfo {
    [[BridgeManager getBridgeManager] requestUserInfo:@"1"];
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

-(void) onUserInfoReceived:(NSDictionary *)data {
    NSDictionary* user_data = [data objectForKey:@"user_data_request"];
    self.firstName = [user_data objectForKey:@"firstname"];
    self.userId = [[user_data objectForKey:@"userid"] intValue];
    self.lastName = [user_data objectForKey:@"lastname"];
    self.description = [user_data objectForKey:@"description"];
    self.email = [user_data objectForKey:@"email"];
}

@end

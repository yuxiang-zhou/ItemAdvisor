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
        _loginRH = [[LoginRequestHandler alloc] initWithDelegate:self];
        _registRH = [[RegisterUserRequestHandler alloc] initWithDelegate:self];
        _uploadImageRH = [[UploadImageRequestHandler alloc] initWithDelegate:_registRH];
    }
    return self;
}

#pragma mark - Requests

-(BOOL) isAuthenticated {
    return authenticationState;
}

-(void) getCurrentUserInfoAsync:(NSInteger)userid withDelegate:(id) delegate {
    [_userinfoRH addObserver:delegate];
    [[BridgeManager getBridgeManager] requestUserInfo:@"1"];
}

-(void) loginAs:(NSString *)userLogin withPassword:(NSString *)password withDelegate:(id) delegate{
    [_loginRH addObserver:delegate];
    [[BridgeManager getBridgeManager] login:userLogin password:password];
}

#pragma mark - RequestHandler

-(void) onUserInfoReceived:(NSDictionary *)data {
    NSDictionary* user_data = [data objectForKey:@"user_data_request"];
    self.firstName = [user_data objectForKey:@"firstname"];
    self.userId = [[user_data objectForKey:@"userid"] intValue];
    self.lastName = [user_data objectForKey:@"lastname"];
    self.description = [user_data objectForKey:@"description"];
    self.email = [user_data objectForKey:@"email"];
}

- (void)onLogin:(NSDictionary *)response {
    NSString *isSuccess = [response objectForKey:@"result"];
    if([isSuccess  isEqual: @"YES"]) {
        NSDictionary* user_data = [response objectForKey:@"user_data_request"];
        self.firstName = [user_data objectForKey:@"firstname"];
        self.userId = [[user_data objectForKey:@"userid"] intValue];
        self.lastName = [user_data objectForKey:@"lastname"];
        self.description = [user_data objectForKey:@"description"];
        self.email = [user_data objectForKey:@"email"];
        authenticationState = YES;
    } else {
        authenticationState = NO;
    }

}

@end

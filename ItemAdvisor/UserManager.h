//
//  UserManager.h
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 12/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoRequestHandler.h"

@protocol UserManagerDelegate
@required
- (void)onUserInfoReceived:(NSDictionary *)userData;
@end


@interface UserManager : NSObject

@property NSInteger     userId;
@property NSString*     firstName;
@property NSString*     lastName;
@property NSString*     description;
@property NSString*     email;

@property UserInfoRequestHandler* userinfoRH;


+(instancetype) getUserManager;

-(BOOL) isAuthenticated;
-(void) getCurrentUserInfoAsync:(NSInteger)userid withDelegate:(id) delegate;
-(void) loginAs:(NSString *)userLogin withPassword:(NSString *)password;


@end

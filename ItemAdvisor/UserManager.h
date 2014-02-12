//
//  UserManager.h
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 12/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject

@property NSInteger     userId;
@property NSString*     firstName;
@property NSString*     lastName;
@property NSString*     description;
@property NSString*     email;


+(instancetype) getUserManager;

-(BOOL) isAuthenticated;
-(void) updateUserInfo;
-(BOOL) loginAs:(NSString *)userLogin withPassword:(NSString *)password;


@end

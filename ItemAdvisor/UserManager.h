//
//  UserManager.h
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 12/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoRequestHandler.h"
#import "LoginRequestHandler.h"
#import "RegisterUserRequestHandler.h"
#import "UploadImageRequestHandler.h"

@protocol UserManagerDelegate
@required
- (void)onUserInfoReceived:(NSDictionary *)userData;
- (void)onLogin:(NSDictionary *) response;
- (void)onImageUploaded:(BOOL) isSuccess;
- (void)onRegistUser:(BOOL) isSuccess;
@end

@interface UserManager : NSObject <UserManagerDelegate>

@property NSInteger     userId;
@property NSString*     firstName;
@property NSString*     lastName;
@property NSString*     description;
@property NSString*     email;
@property UIImage *     profile;

@property UserInfoRequestHandler* userinfoRH;
@property LoginRequestHandler* loginRH;
@property RegisterUserRequestHandler* registRH;
@property UploadImageRequestHandler* uploadImageRH;


+(instancetype) getUserManager;

-(BOOL) isAuthenticated;
-(void) getCurrentUserInfoAsync:(NSInteger)userid withDelegate:(id) delegate;
-(void) loginAs:(NSString *)userLogin withPassword:(NSString *)password withDelegate:(id) delegate;
-(void) registerUser:(NSDictionary *)userData image:(UIImage *)image withDelegate:(id)delegate;


@end

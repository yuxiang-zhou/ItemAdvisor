//
//  UserManager.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 12/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

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
    }
    return self;
}

-(BOOL) isAuthenticated {
    return YES;
}

@end

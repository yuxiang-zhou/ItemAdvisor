//
//  BridgeManager.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 12/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "BridgeManager.h"
#import "UserManager.h"

@implementation BridgeManager
{
    NSString* gerUserURL;
}

+ (instancetype)getBridgeManager {
    static BridgeManager *sharedBridgeManager = nil;
    if (sharedBridgeManager == nil) {
        sharedBridgeManager = [[self alloc] init];
    }
    return sharedBridgeManager;
}

- (id)init {	
    if (self = [super init]) {
        // init propertise
        gerUserURL = @"http://113.55.0.233/itemadvisor/getuser.php";
    }
    return self;
}

-(void)requestUserInfo:(NSString *)userid {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:gerUserURL]];
    [[NSURLConnection alloc] initWithRequest:request delegate:[UserManager getUserManager].userinfoRH];
    
}

@end

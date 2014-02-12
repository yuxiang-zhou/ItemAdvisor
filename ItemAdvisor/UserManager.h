//
//  UserManager.h
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 12/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject
{
    NSString* username;
    
}

+(instancetype) getUserManager;

-(BOOL) isAuthenticated;


@end

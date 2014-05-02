//
//  SharedResources.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 21/04/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "SharedResources.h"

@implementation SharedResources

+(instancetype) getResources {
    static SharedResources *sharedResources = nil;
    if (sharedResources == nil) {
        sharedResources = [[self alloc] init];
    }
    return sharedResources;
}

- (id)init {
    if (self = [super init]) {
        _serverIP = @"http://113.55.0.233/itemadvisor";
    }
    return self;
}

@end

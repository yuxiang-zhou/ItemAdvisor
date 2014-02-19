//
//  RequestHandler.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 19/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "RequestHandler.h"

@implementation RequestHandler

-(instancetype)initWithDelegate:(id) delegate {
    if(self = [super init]) {
        self.delegate = delegate;
        observers = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)addObserver:(id)observer {
    [observers addObject:observer];
}

#pragma mark - NSURLRequest Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSError *error = nil;
    id object = [NSJSONSerialization
                 JSONObjectWithData:data
                 options:0
                 error:&error];
    
    if(error) { [self onError:@"Unable to Parse JSON"]; }
    
    if([object isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *results = object;
        [self onSuccess:results];
    }
    else
    {
        [self onError:@"JSON Syntax Error"];
    }
    
//    [[UserManager getUserManager] perf	ormSelector:@selector(onUserInfoReceived:) withObject:str_data];
}

-(void)onSuccess:(NSDictionary *) jsonData{
    if([self.delegate respondsToSelector:@selector(onSuccess:)])
        [self.delegate performSelector:@selector(onSuccess:) withObject:jsonData];
}

-(void)onError:(NSString *) description {
    if([self.delegate respondsToSelector:@selector(onSuccess:)])
        [self.delegate performSelector:@selector(onError:) withObject:description];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
}


@end

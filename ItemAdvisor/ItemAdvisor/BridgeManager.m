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
    NSString* loginURL;
    NSString* registerURL;
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
        loginURL = @"http://113.55.0.233/itemadvisor/login.php";
        registerURL = @"http://113.55.0.233/itemadvisor/register.php";
    }
    return self;
}

#pragma mark - UserManager Requests

-(void)requestUserInfo:(NSString *)userid {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:gerUserURL]];
    [[NSURLConnection alloc] initWithRequest:request delegate:[UserManager getUserManager].userinfoRH];
    
}

-(void)registUser:(NSDictionary *)user_data {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:registerURL]];
//    NSString *postString = [NSString stringWithFormat:@"email=%@&password=%@&firstname=%@&lastname=%@&desc=%@",@"123",@"123",@"123",@"123",@"123"];
    NSString *postString = [NSString stringWithFormat:@"email=%@&password=%@&firstname=%@&lastname=%@&desc=%@",[user_data objectForKey:@"email"],[user_data objectForKey:@"password"],[user_data objectForKey:@"firstname"],[user_data objectForKey:@"lastname"],[user_data objectForKey:@"desc"]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [[NSURLConnection alloc] initWithRequest:request delegate:[UserManager getUserManager].registRH];
    
}

-(void)login:(NSString *)useremail password:(NSString *)password {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:loginURL]];
    NSString *postString = [NSString stringWithFormat:@"login=%@&password=%@",useremail, password];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    
    [[NSURLConnection alloc] initWithRequest:request delegate:[UserManager getUserManager].loginRH];
}

-(void)uploadImage:(UIImage *)image forUser:(NSString *)email{
    /*
     turning the image into a NSData object
     getting the image back out of the UIImageView
     setting the quality to 90
     */
    NSData *imageData = UIImageJPEGRepresentation(image, 90);
    // setting up the URL to post to
    NSString *urlString = @"http://113.55.0.233/itemadvisor/uploadImg.php";
    
    // setting up the request object now
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    /*
     add some header info now
     we always need a boundary when we post a file
     also we need to set the content type
     
     You might want to generate a random boundary.. this is just the same
     as my output from wireshark on a valid html post
     */
    NSString *boundary = @"498huj0ije3f874ew20oijfhfsfgk";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    /*
     now lets create the body of the post
     */
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.jpg\"\r\n",email] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    [[NSURLConnection alloc] initWithRequest:request delegate:[UserManager getUserManager].uploadImageRH];
    
}
@end

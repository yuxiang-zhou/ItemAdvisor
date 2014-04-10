//
//  DetailPostViewController.m
//  ItemAdvisor
//
//  Created by Xiaoming Chen on 20/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "DetailPostViewController.h"

@interface DetailPostViewController ()

@end

@implementation DetailPostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //Create 3 buttons on the top
    _textButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 107, 50)];
    [_textButton setBackgroundColor:UIColorFromRGB(0x333333)];
    [self.view addSubview: _textButton];
    _textButtonText = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, 107, 15)];
    _textButtonText.text = @"文字";
    _textButtonText.textColor = [UIColor whiteColor];
    _textButtonText.textAlignment = NSTextAlignmentCenter;
    [_textButtonText setFont:[UIFont fontWithName:@"Trebuchet MS" size:10]];
    [_textButton addSubview:_textButtonText];
    
    _picButton = [[UIButton alloc]initWithFrame:CGRectMake(107, 0, 107, 50)];
    [_picButton setBackgroundColor:UIColorFromRGB(0x333333)];
    [self.view addSubview: _picButton];
    _picButtonText = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, 107, 15)];
    _picButtonText.text = @"图片";
    _picButtonText.textColor = [UIColor whiteColor];
    _picButtonText.textAlignment = NSTextAlignmentCenter;
    [_picButtonText setFont:[UIFont fontWithName:@"Trebuchet MS" size:10]];
    [_picButton addSubview:_picButtonText];
    
    _comButton = [[UIButton alloc]initWithFrame:CGRectMake(213, 0, 107, 50)];
    [_comButton setBackgroundColor:UIColorFromRGB(0x333333)];
    [self.view addSubview: _comButton];
    _comButtonText = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, 107, 15)];
    _comButtonText.text = @"评论";
    _comButtonText.textColor = [UIColor whiteColor];
    _comButtonText.textAlignment = NSTextAlignmentCenter;
    [_comButtonText setFont:[UIFont fontWithName:@"Trebuchet MS" size:10]];
    [_comButton addSubview:_comButtonText];
    
    _mainContent = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, 320, 405)];
    _mainContent.showsVerticalScrollIndicator=YES;
    _mainContent.scrollEnabled=YES;
    _mainContent.userInteractionEnabled=YES;
    [self.view addSubview:_mainContent];
    _mainContent.contentSize = CGSizeMake(320,[self contentHeight]);

    //load profilePic
    [self performSelectorInBackground:@selector(createAndLoadProfile) withObject:nil];
    
    //username and time
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(63, 14, 270, 25)];
    name.text = _post.username;
    name.backgroundColor = [UIColor clearColor];
    name.textColor = [UIColor blackColor];
    name.textAlignment = NSTextAlignmentLeft;
    [name setFont:[UIFont fontWithName:@"Trebuchet MS" size:18]];
    [_mainContent  addSubview:name];
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(63, 44, 100, 12)];
    time.text = [NSString stringWithFormat:@"08/08/2014"];
    time.backgroundColor = [UIColor clearColor];
    time.textColor = [UIColor blackColor];
    time.textAlignment = NSTextAlignmentLeft;
    [time setFont:[UIFont fontWithName:@"Trebuchet MS" size:12]];
    [_mainContent  addSubview:time];
    
    //descriptions
    _desc = [[UITextView alloc]initWithFrame:CGRectMake(5, 66, 310, 20)];
    _desc.editable = NO;
    _desc.scrollEnabled = NO;
    [_desc setFont:[UIFont fontWithName:@"Trebuchet MS" size:16]];
    _desc.text = _post.content;
    _desc.delegate = self;
    [_desc sizeToFit];
    [_mainContent addSubview:_desc];
    
    //Create gesture for scroll view to dismiss keyboard
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditDesc)];
    
    // prevents the scroll view from swallowing up the touch event of child buttons
    tapGesture.cancelsTouchesInView = NO;
    
    [_mainContent addGestureRecognizer:tapGesture];
}

- (void)endEditDesc{
    [_desc resignFirstResponder];
}

- (void)createAndLoadProfile{
    UIImageView *profilePic = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 46, 46)];
    profilePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_post.profileURL]]]];
    [_mainContent addSubview:profilePic];
}

- (CGFloat)contentHeight{
    return 800;
}

- (IBAction)goBack:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

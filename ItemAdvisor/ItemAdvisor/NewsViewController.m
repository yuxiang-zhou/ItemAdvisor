//
//  FirstViewController.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 05/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "NewsViewController.h"
#import "MakePostViewController.h"

@interface NewsViewController ()

@property (strong,nonatomic)UIScrollView *photoScroll;
@property (strong,nonatomic)UIPageControl *pageControl;

@end

@implementation NewsViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Making A Post"]){
        
    }
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Create Scroll View
    UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    [self.view addSubview:scrollview];
    scrollview.contentSize = CGSizeMake(320,960);
    
    //Create right button in the post
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setBackgroundColor:UIColorFromRGB(0x2a477a)];
    rightButton.frame = CGRectMake(160, 0, 160, 120);
    [rightButton setTitle:@"" forState:UIControlStateNormal];
    [scrollview addSubview: rightButton];
    
    //Create profile pic in color button of post
    UIImageView *myProfile = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sky.jpg"]];
    myProfile.frame = CGRectMake(10, 10, 46, 46);
    [rightButton addSubview:myProfile];
    
    //Create labels in right button of post
    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(8, 63, 100, 25)];
    name.text = [NSString stringWithFormat:@"Jackcxm"];
    name.backgroundColor = [UIColor clearColor];
    name.textColor = [UIColor whiteColor];
    name.textAlignment = NSTextAlignmentLeft;
    [name setFont:[UIFont fontWithName:@"Trebuchet MS" size:23]];
    [rightButton addSubview:name];

    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(8, 90, 100, 25)];
    time.text = [NSString stringWithFormat:@"05/03/2014"];
    time.backgroundColor = [UIColor clearColor];
    time.textColor = [UIColor whiteColor];
    time.textAlignment = NSTextAlignmentLeft;
    [time setFont:[UIFont fontWithName:@"Trebuchet MS" size:12]];
    [rightButton addSubview:time];
    
    //Create left button in the post
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setBackgroundColor:[UIColor whiteColor]];
    leftButton.frame = CGRectMake(0, 0, 160, 120);
    [leftButton setTitle:@"" forState:UIControlStateNormal];
    [scrollview addSubview: leftButton];
    
    //Create labels in left button of post
    UILabel *Views = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 10, 12)];
    Views.text = [NSString stringWithFormat:@""];
    Views.backgroundColor = [UIColor grayColor];
    Views.textAlignment = NSTextAlignmentLeft;
    [leftButton addSubview:Views];
    
    UILabel *noOfViews = [[UILabel alloc]initWithFrame:CGRectMake(25, 8, 35, 13)];
    noOfViews.text = [NSString stringWithFormat:@"88"];
    noOfViews.backgroundColor = [UIColor clearColor];
    noOfViews.textColor = [UIColor grayColor];
    noOfViews.textAlignment = NSTextAlignmentLeft;
    [noOfViews setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
    [leftButton addSubview:noOfViews];
    
    UILabel *Likes = [[UILabel alloc]initWithFrame:CGRectMake(60, 8, 10, 12)];
    Likes.text = [NSString stringWithFormat:@""];
    Likes.backgroundColor = [UIColor grayColor];
    Likes.textAlignment = NSTextAlignmentLeft;
    [leftButton addSubview:Likes];
    
    UILabel *noOfLikes = [[UILabel alloc]initWithFrame:CGRectMake(75, 8, 35, 13)];
    noOfLikes.text = [NSString stringWithFormat:@"88"];
    noOfLikes.backgroundColor = [UIColor clearColor];
    noOfLikes.textColor = [UIColor grayColor];
    noOfLikes.textAlignment = NSTextAlignmentLeft;
    [noOfLikes setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
    [leftButton addSubview:noOfLikes];
    
    UILabel *Comments = [[UILabel alloc]initWithFrame:CGRectMake(110, 8, 10, 12)];
    Comments.text = [NSString stringWithFormat:@""];
    Comments.backgroundColor = [UIColor grayColor];
    Comments.textAlignment = NSTextAlignmentLeft;
    [leftButton addSubview:Comments];
    
    UILabel *noOfComments = [[UILabel alloc]initWithFrame:CGRectMake(125, 8, 35, 13)];
    noOfComments.text = [NSString stringWithFormat:@"88"];
    noOfComments.backgroundColor = [UIColor clearColor];
    noOfComments.textColor = [UIColor grayColor];
    noOfComments.textAlignment = NSTextAlignmentLeft;
    [noOfComments setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
    [leftButton addSubview:noOfComments];
    
    UIImageView *tagOne = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car.png"]];
    tagOne.frame = CGRectMake(10, 80, 32, 32);
    [leftButton addSubview:tagOne];
    
    UIImageView *tagTwo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"camera.png"]];
    tagTwo.frame = CGRectMake(50, 80, 32, 32);
    [leftButton addSubview:tagTwo];
    
    //Create photo horizontal scroll view
    _photoScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 120, 320, 320)];
    _photoScroll.bounces = YES;
    _photoScroll.pagingEnabled = YES;
    _photoScroll.delegate = self;
    _photoScroll.userInteractionEnabled = YES;
    _photoScroll.showsHorizontalScrollIndicator = NO;
    [scrollview addSubview:_photoScroll];
    //Create photo arrays
    NSMutableArray *slideImages = [[NSMutableArray alloc] init];
    [slideImages addObject:@"ocean.jpeg"];
    [slideImages addObject:@"ocean_1.jpg"];
    [slideImages addObject:@"ocean_2.jpg"];
    //Create page control
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(112,445,100,18)]; // 初始化mypagecontrol
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor blackColor]];
    [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    _pageControl.numberOfPages = [slideImages count];
    _pageControl.currentPage = 0;
    [scrollview addSubview:_pageControl];
    //Create image views
    for (int i = 0;i<[slideImages count];i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[slideImages objectAtIndex:i]]];
        imageView.frame = CGRectMake((320 * i), 0, 320, 320);
        [_photoScroll addSubview:imageView];
    }
    
    [_photoScroll setContentSize:CGSizeMake(320 * [slideImages count], 320)]; //  //+上第1页和第4页  原理：4-[1-2-3-4]-1
    [_photoScroll setContentOffset:CGPointMake(0, 0)];
    [_photoScroll scrollRectToVisible:CGRectMake(0,0,320,320) animated:NO];
    
    //Create text in the post
    UITextView *tf = [[UITextView alloc] initWithFrame:CGRectMake(5, 463, 320, 40)];
    tf.textColor = [UIColor blackColor];
    tf.font = [UIFont fontWithName:@"Trebuchet MS" size:12];
    tf.text=@"Hello World!!!";
    tf.editable = NO;
    [scrollview addSubview:tf];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = 320;
    int page = (_photoScroll.contentOffset.x)/pagewidth;
    _pageControl.currentPage = page;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

























@end

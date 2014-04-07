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

//@property (strong,nonatomic)UIScrollView *photoScroll;
//@property (strong,nonatomic)UIPageControl *pageControl;

@end

@implementation NewsViewController

static NSString *CellIdentifier = @"CellIdentifier";

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Making A Post"]){
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _nameArray = [[NSMutableArray alloc]init];
    [_nameArray addObject:[NSString stringWithFormat:@"Tom"]];
    [_nameArray addObject:[NSString stringWithFormat:@"Tom"]];
    [_nameArray addObject:[NSString stringWithFormat:@"Tom"]];
    [_nameArray addObject:[NSString stringWithFormat:@"Tom"]];
    [_nameArray addObject:[NSString stringWithFormat:@"Tom"]];
    
    _dataArray = [[NSMutableArray alloc]init];
    [_dataArray addObject:[NSString stringWithFormat:@"Good Morning!"]];
    [_dataArray addObject:[NSString stringWithFormat:@"Good Morning!"]];
    [_dataArray addObject:[NSString stringWithFormat:@"Good Morning!"]];
    [_dataArray addObject:[NSString stringWithFormat:@"Good Morning!"]];
    [_dataArray addObject:[NSString stringWithFormat:@"Good Morning!"]];
    
    _addedTagArray = [[NSMutableArray alloc]init];
    [_addedTagArray addObject:[NSNumber numberWithInt:100]];
    [_addedTagArray addObject:[NSNumber numberWithInt:100]];
    [_addedTagArray addObject:[NSNumber numberWithInt:100]];
    
    _postTable = [self createTableView];
    _postTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_postTable registerClass:[PostCell class] forCellReuseIdentifier:CellIdentifier];
    [self.view addSubview:_postTable];
    
    
    //Create Scroll View
//    UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 460)];
//    scrollview.showsVerticalScrollIndicator=YES;
//    scrollview.scrollEnabled=YES;
//    scrollview.userInteractionEnabled=YES;
//    [self.view addSubview:scrollview];
//    scrollview.contentSize = CGSizeMake(320,960);
//    
//    //Create right button in the post
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightButton setBackgroundColor:UIColorFromRGB(0x2a477a)];
//    rightButton.frame = CGRectMake(160, 0, 160, 120);
//    [rightButton setTitle:@"" forState:UIControlStateNormal];
//    [scrollview addSubview: rightButton];
//    
//    //Create profile pic in color button of post
//    UIImageView *myProfile = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sky.jpg"]];
//    myProfile.frame = CGRectMake(10, 10, 46, 46);
//    [rightButton addSubview:myProfile];
//    
//    //Create labels in right button of post
//    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(8, 63, 100, 25)];
//    name.text = [NSString stringWithFormat:@"Jackcxm"];
//    name.backgroundColor = [UIColor clearColor];
//    name.textColor = [UIColor whiteColor];
//    name.textAlignment = NSTextAlignmentLeft;
//    [name setFont:[UIFont fontWithName:@"Trebuchet MS" size:23]];
//    [rightButton addSubview:name];
//
//    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(8, 90, 100, 25)];
//    time.text = [NSString stringWithFormat:@"05/03/2014"];
//    time.backgroundColor = [UIColor clearColor];
//    time.textColor = [UIColor whiteColor];
//    time.textAlignment = NSTextAlignmentLeft;
//    [time setFont:[UIFont fontWithName:@"Trebuchet MS" size:12]];
//    [rightButton addSubview:time];
//    
//    //Create left button in the post
//    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [leftButton setBackgroundColor:[UIColor whiteColor]];
//    leftButton.frame = CGRectMake(0, 0, 160, 120);
//    [leftButton setTitle:@"" forState:UIControlStateNormal];
//    [scrollview addSubview: leftButton];
//    
//    UILabel *tagOne = [[UILabel alloc]initWithFrame:CGRectMake(10, 85, 24, 24)];
//    tagOne.backgroundColor = [UIColor lightGrayColor];
//    tagOne.layer.cornerRadius = 10.0;
//    [leftButton addSubview:tagOne];
//    
//    UILabel *tagTwo = [[UILabel alloc]initWithFrame:CGRectMake(44, 85, 24, 24)];
//    tagTwo.backgroundColor = [UIColor lightGrayColor];
//    tagTwo.layer.cornerRadius = 10.0;
//    [leftButton addSubview:tagTwo];
//    
//    //Create photo horizontal scroll view
////    _photoScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 120, 320, 320)];
////    _photoScroll.bounces = YES;
////    _photoScroll.pagingEnabled = YES;
////    _photoScroll.delegate = self;
////    _photoScroll.userInteractionEnabled = YES;
////    _photoScroll.showsHorizontalScrollIndicator = NO;
////    [scrollview addSubview:_photoScroll];
//    //Create photo arrays
//    slideImages = [[NSMutableArray alloc] init];
//    [slideImages addObject:[UIImage imageNamed:@"ocean_0.jpeg"]];
//    [slideImages addObject:[UIImage imageNamed:@"ocean_1.jpg"]];
//    [slideImages addObject:[UIImage imageNamed:@"ocean_2.jpg"]];
//    
//    //Create page control
////    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(108,439,100,18)]; // 初始化mypagecontrol
////    [_pageControl setCurrentPageIndicatorTintColor:[UIColor blackColor]];
////    [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];
////    _pageControl.numberOfPages = [slideImages count];
////    _pageControl.currentPage = 0;
////    [scrollview addSubview:_pageControl];
//    
//    //Create image views
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[slideImages objectAtIndex:0]];
//    imageView.frame = CGRectMake(0, 120, 320, 320);
//    [scrollview addSubview:imageView];
//    
////    for (int i = 0;i<[slideImages count];i++)
////    {
////        UIImageView *imageView = [[UIImageView alloc] initWithImage:[slideImages objectAtIndex:i]];
////        [imageView setupImageViewerWithDatasource:self initialIndex:i onOpen:nil onClose:nil];
////        imageView.frame = CGRectMake((320 * i), 0, 320, 320);
////        [_photoScroll addSubview:imageView];
////    }
////    
////    [_photoScroll setContentSize:CGSizeMake(320 * [slideImages count], 320)]; //  //+上第1页和第4页  原理：4-[1-2-3-4]-1
////    [_photoScroll setContentOffset:CGPointMake(0, 0)];
////    [_photoScroll scrollRectToVisible:CGRectMake(0,0,320,320) animated:NO];
//    
//    //Create text in the post
//    
//    UILabel *desc = [[UILabel alloc]initWithFrame:CGRectMake(10, 445, 320, 0)];
//    desc.text = [NSString stringWithFormat:@"(Main Descriptions)"];
//    desc.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
//    desc.textColor = [UIColor blackColor];
//    desc.backgroundColor = [UIColor clearColor];
//    desc.textAlignment = NSTextAlignmentLeft;
//    [desc sizeToFit];
//    desc.numberOfLines = 0;
//    [scrollview addSubview:desc];
//    
//    //Create like list in the post
//    UILabel *likeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 465, 10, 10)];
//    likeLabel.backgroundColor = [UIColor lightGrayColor];
//    likeLabel.layer.cornerRadius = 10.0;
//    [scrollview addSubview:likeLabel];
//    
//    UILabel *likes = [[UILabel alloc]initWithFrame:CGRectMake(25, 462, 320, 0)];
//    likes.text = [NSString stringWithFormat:@"(List of Likes)"];
//    likes.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
//    likes.textColor = [UIColor blackColor];
//    likes.backgroundColor = [UIColor clearColor];
//    likes.textAlignment = NSTextAlignmentLeft;
//    [likes sizeToFit];
//    likes.numberOfLines = 0;
//    [scrollview addSubview:likes];
//    
//    //Create like list in the post
//    UILabel *oneCommentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 482, 10, 10)];
//    oneCommentLabel.backgroundColor = [UIColor lightGrayColor];
//    oneCommentLabel.layer.cornerRadius = 10.0;
//    [scrollview addSubview:oneCommentLabel];
//    
//    UILabel *recentCommment = [[UILabel alloc]initWithFrame:CGRectMake(25, 479, 320, 0)];
//    recentCommment.text = [NSString stringWithFormat:@"(Show one comment, and the num of comments)"];
//    recentCommment.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
//    recentCommment.textColor = [UIColor blackColor];
//    recentCommment.backgroundColor = [UIColor clearColor];
//    recentCommment.textAlignment = NSTextAlignmentLeft;
//    [recentCommment sizeToFit];
//    recentCommment.numberOfLines = 0;
//    [scrollview addSubview:recentCommment];
//    
//    //--Create buttons in the bottom
//    UIButton *makeCommentButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 500, 60, 25)];
//    [makeCommentButton setBackgroundColor:UIColorFromRGB(0xd2d2d2)];
//    [scrollview addSubview:makeCommentButton];
//    
//    UILabel * commentLogo= [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 15, 15)];
//    commentLogo.backgroundColor = [UIColor grayColor];
//    commentLogo.layer.cornerRadius = 10.0;
//    [makeCommentButton addSubview:commentLogo];
//    
//    UILabel *commentLogoText = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, 35, 15)];
//    commentLogoText.text = [NSString stringWithFormat:@"评论"];
//    commentLogoText.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
//    commentLogoText.textColor = [UIColor grayColor];
//    commentLogoText.backgroundColor = [UIColor clearColor];
//    commentLogoText.textAlignment = NSTextAlignmentLeft;
//    [commentLogoText sizeToFit];
//    commentLogoText.numberOfLines = 0;
//    [makeCommentButton addSubview:commentLogoText];
//    
//    UIButton *toLikeButton = [[UIButton alloc]initWithFrame:CGRectMake(80, 500, 60, 25)];
//    [toLikeButton setBackgroundColor:UIColorFromRGB(0xd2d2d2)];
//    [scrollview addSubview:toLikeButton];
//    
//    UILabel * likeLogo= [[UILabel alloc]initWithFrame:CGRectMake(5, 5, 15, 15)];
//    likeLogo.backgroundColor = [UIColor grayColor];
//    likeLogo.layer.cornerRadius = 10.0;
//    [toLikeButton addSubview:likeLogo];
//    
//    UILabel *likeLogoText = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, 35, 15)];
//    likeLogoText.text = [NSString stringWithFormat:@"赞"];
//    likeLogoText.font = [UIFont fontWithName:@"Trebuchet MS" size:13];
//    likeLogoText.textColor = [UIColor grayColor];
//    likeLogoText.backgroundColor = [UIColor clearColor];
//    likeLogoText.textAlignment = NSTextAlignmentLeft;
//    [likeLogoText sizeToFit];
//    likeLogoText.numberOfLines = 0;
//    [toLikeButton addSubview:likeLogoText];
    
}

- (UITableView *)createTableView{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.view.frame.size.width;
    //CGFloat height = self.view.frame.size.height;
    CGRect tableFrame = CGRectMake(x, y, width, 455);
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    tableView.scrollEnabled = YES;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.userInteractionEnabled = YES;
    tableView.bounces = YES;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    return tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [PostCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PostCell *cell = (PostCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[PostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.addedTagArray = _addedTagArray;
    cell.color = UIColorFromRGB(0x2a477a);
    cell.profilePic.image = [UIImage imageNamed:@"sky.jpg"];
    cell.name.text = [_nameArray objectAtIndex:indexPath.row];
    cell.firstPic.image = [UIImage imageNamed:@"ocean_0.jpeg"];
    cell.desc.text = [_dataArray objectAtIndex:indexPath.row];
    
    return cell;
}

//Methods for pagecontrol scrollview
//- (void)scrollViewDidScroll:(UIScrollView *)sender
//{
//    CGFloat pagewidth = 320;
//    int page = (_photoScroll.contentOffset.x)/pagewidth;
//    _pageControl.currentPage = page;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  SecondViewController.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 05/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "AccountViewController.h"

@interface AccountViewController ()


@end

@implementation AccountViewController

static NSString *CellIdentifier = @"CellIdentifier";

- (void)viewDidLoad
{
    //Create scroll view
    UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 40, 320, 415)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    [self.view addSubview:scrollview];
    scrollview.contentSize = CGSizeMake(320,220+([UserManager getUserManager].noPost)*530);
    //create post arrays
    _postList = [[NSMutableArray alloc]init];
    
    //Create 4 buttons switching contents in view
    //日志
    UIButton *post = [UIButton buttonWithType:UIButtonTypeCustom];
    [post setBackgroundColor:UIColorFromRGB(0x333333)];
    post.frame = CGRectMake(0, 20, 80, 20);
    [post setTitle:@"日志" forState:UIControlStateNormal];
    [post.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:11]];
    [self.view addSubview: post];
    
    NSUInteger numOfpost = [UserManager getUserManager].noPost;
    NSString *postDetailTitle = [NSString stringWithFormat:@"%lu",(unsigned long)numOfpost];
    
    UIButton *postNum = [UIButton buttonWithType:UIButtonTypeCustom];
    [postNum setBackgroundColor:UIColorFromRGB(0x333333)];
    postNum.frame = CGRectMake(0, 0, 80, 20);
    [postNum setTitle:postDetailTitle forState:UIControlStateNormal];
    postNum.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [postNum.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
    [self.view addSubview: postNum];
    
    //关注
    UIButton *follow = [UIButton buttonWithType:UIButtonTypeCustom];
    [follow setBackgroundColor:UIColorFromRGB(0x333333)];
    follow.frame = CGRectMake(80, 20, 80, 20);
    [follow setTitle:@"关注" forState:UIControlStateNormal];
    [follow.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:11]];
    [self.view addSubview: follow];
    
    NSUInteger numOfFollow = [UserManager getUserManager].noFollowing;
    NSString *followDetailTitle = [NSString stringWithFormat:@"%lu",(unsigned long)numOfFollow];
    
    UIButton *followNum = [UIButton buttonWithType:UIButtonTypeCustom];
    [followNum setBackgroundColor:UIColorFromRGB(0x333333)];
    followNum.frame = CGRectMake(80, 0, 80, 20);
    [followNum setTitle:followDetailTitle forState:UIControlStateNormal];
    followNum.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [followNum.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
    [self.view addSubview: followNum];
    
    //粉丝
    UIButton *follower = [UIButton buttonWithType:UIButtonTypeCustom];
    [follower setBackgroundColor:UIColorFromRGB(0x333333)];
    follower.frame = CGRectMake(160, 20, 80, 20);
    [follower setTitle:@"粉丝" forState:UIControlStateNormal];
    [follower.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:11]];
    [self.view addSubview: follower];
    
    NSUInteger numOfFollower = [UserManager getUserManager].noFollower;
    NSString *followerDetailTitle = [NSString stringWithFormat:@"%lu",(unsigned long)numOfFollower];
    
    UIButton *followerNum = [UIButton buttonWithType:UIButtonTypeCustom];
    [followerNum setBackgroundColor:UIColorFromRGB(0x333333)];
    followerNum.frame = CGRectMake(160, 0, 80, 20);
    [followerNum setTitle:followerDetailTitle forState:UIControlStateNormal];
    followerNum.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [followerNum.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
    [self.view addSubview: followerNum];
    
    //物品
    UIButton *things = [UIButton buttonWithType:UIButtonTypeCustom];
    [things setBackgroundColor:UIColorFromRGB(0x333333)];
    things.frame = CGRectMake(240, 20, 80, 20);
    [things setTitle:@"物品" forState:UIControlStateNormal];
    [things.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:11]];
    [self.view addSubview: things];
    
    NSUInteger numOfThings = [UserManager getUserManager].noItems;
    NSString *thingsDetailTitle = [NSString stringWithFormat:@"%lu",(unsigned long)numOfThings];
    
    UIButton *thingsNum = [UIButton buttonWithType:UIButtonTypeCustom];
    [thingsNum setBackgroundColor:UIColorFromRGB(0x333333)];
    thingsNum.frame = CGRectMake(240, 0, 80, 20);
    [thingsNum setTitle:thingsDetailTitle forState:UIControlStateNormal];
    thingsNum.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [thingsNum.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:15]];
    [self.view addSubview: thingsNum];
    
    //Create profile pic
    UIImageView *myProfile = [[UIImageView alloc] init];
    if (![UserManager getUserManager].profile) {
        myProfile.image = [UIImage imageNamed:@"haha.jpeg"];
    }else{
        myProfile.image = [UserManager getUserManager].profile;
    }
    myProfile.frame = CGRectMake(0, 0, 160, 160);
    [scrollview addSubview:myProfile];
    
    
    //Create and Initialise username
    NSString *nameString = [NSString stringWithFormat:@"%@ %@", [UserManager getUserManager].lastName, [UserManager getUserManager].firstName];
    UITextView *tfn = [[UITextView alloc] initWithFrame:CGRectMake(165, 60, 150, 30)];
    tfn.textColor = [UIColor blackColor];
    tfn.font = [UIFont fontWithName:@"Trebuchet MS" size:20];
    tfn.text = nameString;
    tfn.editable = NO;
    [scrollview addSubview:tfn];
    
    //Create and Initialise introduction
    NSString *intro = [NSString stringWithFormat:@"%@", [UserManager getUserManager].description];
    UITextView *tf = [[UITextView alloc] initWithFrame:CGRectMake(165, 90, 150, 65)];
    tf.textColor = [UIColor blackColor];
    tf.font = [UIFont fontWithName:@"Trebuchet MS" size:11];
    tf.text = intro;
    tf.editable = NO;
    [scrollview addSubview:tf];
    
    //Create edit button
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [editButton setBackgroundColor:UIColorFromRGB(0x502d25)];
    editButton.frame = CGRectMake(0, 160, 320, 60);
    [editButton setTitle:@"编  辑" forState:UIControlStateNormal];
    [editButton.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:22]];
    [scrollview addSubview: editButton];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[PostManager getPostManager]getUserPost:[UserManager getUserManager].userId range:NSMakeRange(1, [UserManager getUserManager].noPost) withDelegate:self];
    
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
    
    _postTable = [self createTableViewWithHeight:([UserManager getUserManager].noPost)*530];
    _postTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_postTable registerClass:[PostCell class] forCellReuseIdentifier:CellIdentifier];
    [scrollview addSubview:_postTable];
    
}

- (void)onGetPost:(NSNumber *) isSuccess content:(NSArray *)list{
    if (isSuccess.boolValue) {
        [_postList addObjectsFromArray:list];
    }
}

- (UITableView *)createTableViewWithHeight:(CGFloat)height{
    CGFloat x = 0;
    CGFloat y = 221;
    CGFloat width = self.view.frame.size.width;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    tableView.scrollEnabled = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.userInteractionEnabled = YES;
    tableView.bounces = YES;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    return tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_postList count];
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
    cell.color = UIColorFromRGB(0x502d25);
    cell.name.text = [UserManager getUserManager].firstName;
    cell.firstPic.image = [UIImage imageNamed:@"choco_1.jpg"];
    [self putLabelTextInCell:cell withOrder:indexPath.row];
    
    return cell;
}

-(void)putLabelTextInCell:(PostCell *)cell withOrder:(NSInteger)order{
    [cell.desc setText:((PostEntity *)[_postList objectAtIndex:order]).content];
    [cell.desc sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

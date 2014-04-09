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
    
    [[PostManager getPostManager]getPublicPostwithDelegate:self];
    
    _postList = [[NSMutableArray alloc]init];
    
    _postTable = [self createTableViewWithHeight:455];
    _postTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_postTable registerClass:[PostCell class] forCellReuseIdentifier:CellIdentifier];
    [self.view addSubview:_postTable];
    
}

- (void)onGetPost:(NSNumber *) isSuccess content:(NSArray *)list{
    if (isSuccess.boolValue) {
        [_postList addObjectsFromArray:list];
        [_postTable reloadData];
    }
}

- (UITableView *)createTableViewWithHeight:(CGFloat)height{
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.view.frame.size.width;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
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
    
    [cell.addedTagArray addObjectsFromArray: ((PostEntity *)[_postList objectAtIndex:indexPath.row]).tags];
    cell.color = UIColorFromRGB(0x2a477a);
    cell.profileUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",((PostEntity *)[_postList objectAtIndex:indexPath.row]).profileURL]];
    [self performSelectorInBackground:@selector(loadProfile:) withObject:cell];
    cell.name.text = ((PostEntity *)[_postList objectAtIndex:indexPath.row]).username;
    cell.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[((PostEntity *)[_postList objectAtIndex:indexPath.row]).images objectAtIndex:0]]];
    [self performSelectorInBackground:@selector(loadImage:) withObject:cell];
    [cell.desc setText:((PostEntity *)[_postList objectAtIndex:indexPath.row]).content];
    [cell createContentInCell];
    [cell createTagLabels];
    
    
    return cell;
}

-(void) loadProfile:(PostCell *)cell{
    if (!cell.profilePic.image) {
        cell.profilePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:cell.profileUrl]];
    }
}

-(void) loadImage:(PostCell*)cell{
    if (!cell.firstPic.image) {
        cell.firstPic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:cell.url]];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

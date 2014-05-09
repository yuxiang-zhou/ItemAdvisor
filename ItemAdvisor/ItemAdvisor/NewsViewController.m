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
{
    BOOL loadingLock;
    NSMutableArray *imgLoadingQueue;
}

static NSString *CellIdentifier = @"CellIdentifier";

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"NewsToDetailPost"]) {
        DetailPostViewController *vc = [segue destinationViewController];
        NSIndexPath *path = [_postTable indexPathForSelectedRow];
        vc.post = [[PostEntity alloc]init];
        vc.post = [_postList objectAtIndex:path.row];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typicsally from a nib.
    loadingLock = NO;
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
    
    imgLoadingQueue = [NSMutableArray new];
    
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
        [imgLoadingQueue removeAllObjects];
        for (NSInteger i = [_postList count] - 1; i >= 0; --i) {
            [imgLoadingQueue addObject:@(i)];
        }
        [self performSelectorInBackground:@selector(loadImageList) withObject:nil];
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
    PostCell *cell = (PostCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[PostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    PostEntity* pe = [_postList objectAtIndex:indexPath.row];
    cell.firstPic.image = nil;
    cell.profilePic.image = nil;
    cell.post = pe;
    cell.color = UIColorFromRGB(0x2a477a);
    cell.name.text = pe.username;
    
    if ([pe.images count]) {
        cell.firstPic.image = [pe.images objectAtIndex:0];
    } else {
        [self performSelectorInBackground:@selector(loadImage:) withObject:@(indexPath.row)];
    }
    
    if(pe.profile)
        cell.profilePic.image = pe.profile;
    
    [cell.desc setText:pe.content];
    [cell.addedTagArray addObjectsFromArray: pe.tags];
    cell.tagInMark = 1;
    
    [cell createContentInCell];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:[NSString stringWithFormat:@"NewsToDetailPost"] sender:self];
}

-(void) loadProfile:(PostCell *)cell{
    if (!cell.profilePic.image) {
        cell.profilePic.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:cell.post.profileURL]]];
    }
}
	
-(void) loadImage:(NSNumber *)index{
    [self acquireLock];
    {
        for(NSInteger i = 0; i < [imgLoadingQueue count]; ++i) {
            NSNumber *item = imgLoadingQueue[i];
            if(item.integerValue == index.integerValue) {
                [imgLoadingQueue removeObjectAtIndex:i];
                [imgLoadingQueue addObject:index];
            }
        }
        
    }
    [self releaseLock];
    
}

-(void) loadImageList {
    while ([imgLoadingQueue count]) {
        NSNumber *loadIndex;
        [self acquireLock];
        {
            loadIndex = imgLoadingQueue.lastObject;
            [imgLoadingQueue removeLastObject];
        }
        [self releaseLock];
        NSLog(@"loading: %d", loadIndex.intValue);
        PostEntity* pe = [_postList objectAtIndex:loadIndex.integerValue];
        pe.profile = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:pe.profileURL]]];
        [self downloadImg:pe];
        [_postTable reloadData];
    }
}

-(void) downloadImg:(PostEntity*)pe {
    if ([pe.images count] == 0) {
        for (NSString* url in pe.imageURLs) {
            [pe.images addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]]];
        }
    }
}

-(void) acquireLock {
    while(loadingLock) {[NSThread sleepForTimeInterval:0.1];}
    loadingLock = YES;
}

-(void) releaseLock {
    loadingLock = NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

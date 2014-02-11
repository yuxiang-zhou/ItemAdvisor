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
    UILabel *labelExample = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 130.0, 320.0, 44.0)];
    labelExample.font = [UIFont fontWithName:@"Helvetica-Bold" size:12];
    labelExample.text = @"Example Label";
    labelExample.backgroundColor = [UIColor clearColor];
    labelExample.textColor = [UIColor blackColor];
    [newsView addSubview:labelExample];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  MakePostViewController.h
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 07/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAlertView.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MakePostViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *addText;
@property (weak, nonatomic) IBOutlet UIButton *addTag;
@property (weak, nonatomic) IBOutlet UIButton *addImage;

@end

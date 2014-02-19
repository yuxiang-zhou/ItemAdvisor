//
//  MakePostViewController.h
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 07/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLAlertView.h"
#import <QuartzCore/QuartzCore.h>

#define  PIC_WIDTH 86
#define  PIC_HEIGHT 86
#define  INSETS 10
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MakePostViewController : UIViewController
{
    NSMutableArray *addedPicArray;

}
@property (weak, nonatomic) IBOutlet UIButton *addText;
@property (weak, nonatomic) IBOutlet UIButton *addTag;
@property (weak, nonatomic) IBOutlet UIButton *addImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

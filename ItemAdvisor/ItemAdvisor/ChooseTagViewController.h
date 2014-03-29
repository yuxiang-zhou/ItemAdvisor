//
//  ChooseTagViewController.h
//  ItemAdvisor
//
//  Created by Xiaoming Chen on 27/03/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import <UIKit/UIKit.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#import "MakePostViewController.h"


@interface ChooseTagViewController : UIViewController <UIScrollViewDelegate>{

}

@property (strong,nonatomic)NSMutableArray *addedTagArray;


@end

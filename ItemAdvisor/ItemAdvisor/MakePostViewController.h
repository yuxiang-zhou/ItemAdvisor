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
#import "XWPhotoEditorViewController.h"
#import "ImageFilterProcessViewController.h"
#import "PostManager.h"
#import "UserManager.h"
#import "AllocManager.h"

#define  PIC_WIDTH 86
#define  PIC_HEIGHT 86
#define  INSETS 10
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MakePostViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate, UINavigationControllerDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, ImageFitlerProcessDelegate, UITextViewDelegate, PostManagerDelegate, UserManagerDelegate, UIAlertViewDelegate>
{
    NSMutableArray *addedTagArray;
    NSMutableArray *addedPicArray;
    UIScrollView *scrollview;
    UIButton *addTag;
    UILabel *line;
    UIScrollView *photoScroll;
    UIButton *weiboButton;
    UIButton *wechatButton;
    UIButton *renrenButton;
    UIButton *addPic;
    UIImage *newPic;

}


@end

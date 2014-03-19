//
//  MakePostViewController.m
//  ItemAdvisor
//
//  Created by Yuxiang Zhou on 07/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "MakePostViewController.h"

@interface MakePostViewController ()

@property (strong,nonatomic)UITextView *tf;
@property (strong,nonatomic) UIImagePickerController *picker;

@end

@implementation MakePostViewController
//set cancel button pop up
- (IBAction)CancelOrDraft:(id)sender {
    TLAlertView *alertView = [TLAlertView showInView:self.view withTitle:@"即将返回" message:@"要保存草稿吗？" confirmButtonTitle:@"不保存" cancelButtonTitle:@"要"];
    
    [alertView handleCancel:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }         handleConfirm:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    alertView.TLAnimationType = (arc4random_uniform(10) % 2 == 0) ? TLAnimationType3D : tLAnimationTypeHinge;
    [alertView show];
    alertView.buttonColor = UIColorFromRGB(0x718969);
}

- (void)viewDidAppear:(BOOL)animated{
    _picker = [[UIImagePickerController alloc] init];
    _picker.delegate = self;
}
- (IBAction)sendPost:(id)sender {
    if ([addedPicArray count] != 0 || _tf.textStorage != nil) {
        nil;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //Create scroll view
    scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 504)];
    scrollview.showsVerticalScrollIndicator=YES;
    scrollview.scrollEnabled=YES;
    scrollview.userInteractionEnabled=YES;
    [self.view addSubview:scrollview];
    scrollview.contentSize = CGSizeMake(320,960);
    
    //Create gesture for scroll view to dismiss keyboard
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    
    // prevents the scroll view from swallowing up the touch event of child buttons
    tapGesture.cancelsTouchesInView = NO;
    
    [scrollview addGestureRecognizer:tapGesture];
    
    //-----------Tag
    addedTagArray = [[NSMutableArray alloc]init];
    [addedTagArray addObject:[UIImage imageNamed:@"camera.png"]];
    [addedTagArray addObject:[UIImage imageNamed:@"camera.png"]];
    
    [self initTags];
    
    //---------------Text
    //Create textview
    _tf = [[UITextView alloc] initWithFrame:CGRectMake(10, [addedTagArray count]*50+10, 300, 110)];
    //tf.borderStyle = UITextBorderStyleNone;
    _tf.font = [UIFont fontWithName:@"Trebuchet MS" size:15];
    _tf.text = @"物品描述、使用心得、看法...";
    _tf.textColor = UIColorFromRGB(0xd3d3d3);
    _tf.autocorrectionType = UITextAutocorrectionTypeNo;
    _tf.keyboardType = UIKeyboardTypeDefault;
    _tf.returnKeyType = UIReturnKeyDefault;
    //tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    //tf.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    _tf.delegate = self;
    [scrollview addSubview:_tf];
    
    //Create a line below textview
    line = [[UILabel alloc]initWithFrame:CGRectMake(10, [addedTagArray count]*50+10+88+30, 300, 2)];
    line.text = [NSString stringWithFormat:@""];
    line.backgroundColor = UIColorFromRGB(0xd3d3d3);
    [scrollview addSubview:line];
    
    //-------------Photo
    //Create photo horizontal scroll view
    photoScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, [addedTagArray count]*50+10+100+30, 320, 155)];
    photoScroll.bounces = YES;
    photoScroll.delegate = self;
    photoScroll.userInteractionEnabled = YES;
    photoScroll.showsHorizontalScrollIndicator = YES;
    [scrollview addSubview:photoScroll];
    
    //Create photo arrays
    addedPicArray = [[NSMutableArray alloc]init];
    [addedPicArray addObject:@"grass1.jpg"];
    //[addedPicArray addObject:@"grass2.jpg"];
    //[addedPicArray addObject:@"grass3.jpg"];
    //[addedPicArray addObject:@"grass4.jpg"];
    
    //Create image views
    [self initPhotos];
    
    [photoScroll setContentSize:CGSizeMake(([addedPicArray count]+1)*160 , 155)];
    [photoScroll setContentOffset:CGPointMake(0, 0)];
    [photoScroll scrollRectToVisible:CGRectMake(0,0,320,155) animated:NO];

    
    //---------------ShareToOthers
    weiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [weiboButton setBackgroundImage:[UIImage imageNamed:@"weibo.jpg"] forState:UIControlStateNormal];
    weiboButton.frame = CGRectMake(10, [addedTagArray count]*50+10+270+30, 30, 30);
    [scrollview addSubview: weiboButton];
    
    wechatButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [wechatButton setBackgroundImage:[UIImage imageNamed:@"wechat.jpg"] forState:UIControlStateNormal];
    wechatButton.frame = CGRectMake(50, [addedTagArray count]*50+10+270+30, 30, 30);
    [scrollview addSubview: wechatButton];
    
    renrenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [renrenButton setBackgroundImage:[UIImage imageNamed:@"renren.png"] forState:UIControlStateNormal];
    renrenButton.frame = CGRectMake(90, [addedTagArray count]*50+10+270+30, 30, 30);
    [scrollview addSubview: renrenButton];
    
}

//Methods for photos in horizontal scrollview
- (void)initPhotos
{
    for (int i = 0;i<[addedPicArray count];i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[addedPicArray objectAtIndex:i]]];
        [imageView setUserInteractionEnabled:YES];
        UIButton *deleteView =[[UIButton alloc] initWithFrame:CGRectMake(102, -2, 21, 21)];
        [deleteView setBackgroundImage:[UIImage imageNamed:@"deleteIcon.png"] forState:UIControlStateNormal];
        [deleteView addTarget:self action:@selector(removePhoto:) forControlEvents:UIControlEventTouchDown];
        [deleteView setTag:2000+i];
        
        if (i == 0) {
            imageView.frame = CGRectMake(20, 20, 120, 120);
            [imageView setTag:1000+i];
        }else{
            imageView.frame = CGRectMake(160+(140 * (i-1)), 20, 120, 120);
            [imageView setTag:1000+i];
        }
        [imageView addSubview:deleteView];
        [photoScroll addSubview:imageView];
    }
    addPic = [[UIButton alloc]initWithFrame:CGRectMake(160+(140 * ([addedPicArray count]-1)), 20, 120, 120)];
    [addPic setBackgroundImage:[UIImage imageNamed:@"addPicCamera.png"] forState:UIControlStateNormal];
    [addPic addTarget:self action:@selector(addPhoto) forControlEvents:UIControlEventTouchUpInside];
    [photoScroll addSubview:addPic];
    
}

- (void)addPhoto{
    
    NSString *libraryTitle = @"照片库";
    NSString *takePhotoTitle = @"相机";
    NSString *cancelTitle = @"取消";
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:libraryTitle,takePhotoTitle, nil];
    [actionSheet showInView:self.view];
}

- (void)removePhoto:(UIButton *)sender
{
    NSInteger i = sender.tag - 2000;
    UIImageView *imageView = (UIImageView *)[photoScroll viewWithTag:1000+i];
    [addedPicArray removeObjectAtIndex:i];
    [imageView removeFromSuperview];
    for (NSInteger j = i+1; j<([addedPicArray count]+1); j++) {
        UIImageView *imageView = (UIImageView *)[photoScroll viewWithTag:1000+j];
        UIButton *deleteView = (UIButton *)[photoScroll viewWithTag:2000+j];
        [deleteView setTag:2000+j-1];
        if (i == 0) {
            imageView.frame = CGRectMake(20, 20, 120, 120);
            [imageView setTag:1000+j-1];
        }else{
            imageView.frame = CGRectMake(160+(140 * (j-2)), 20, 120, 120);
            [imageView setTag:1000+j-1];
        }
    }
    [addPic setFrame:CGRectMake(160+(140 * ([addedPicArray count]-1)), 20, 120, 120)];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
    } else if (buttonIndex == 1) {
        [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
    }
}

- (void)showImagePicker:(UIImagePickerControllerSourceType) sourceType {
    _picker.sourceType = sourceType;
    [_picker setAllowsEditing:NO];
    _picker.delegate = self;
    if (_picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        _picker.showsCameraControls = YES;
    }
    if ( [UIImagePickerController isSourceTypeAvailable:sourceType]) {
        [self presentViewController:_picker animated:YES completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    ImageFilterProcessViewController *fitler = [[ImageFilterProcessViewController alloc] init];
    [fitler setDelegate:self];
    fitler.currentImage = [self resizeImage:image toSize:CGSizeMake(900, 1200)];
    [_picker pushViewController:fitler animated:YES];
    [_picker setNavigationBarHidden:YES animated:NO];
    
}

-(UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size
{
    float width = size.width;
    float height = size.height;
    
    UIGraphicsBeginImageContext(size);
    CGRect rect = CGRectMake(0, 0, width, height);
    
    float widthRatio = image.size.width / width;
    float heightRatio = image.size.height / height;
    float divisor = widthRatio > heightRatio ? widthRatio : heightRatio;
    
    width = image.size.width / divisor;
    height = image.size.height / divisor;
    
    rect.size.width  = width;
    rect.size.height = height;
    
    if(height < width)
        rect.origin.y = height / 3;
    
    [image drawInRect: rect];
    
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return smallImage;
}

- (void)imageFitlerProcessDone:(UIImage *)image //图片处理完
{
    //make status bar reappear
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [addedPicArray addObject:image];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setUserInteractionEnabled:YES];
    UIButton *deleteView =[[UIButton alloc] initWithFrame:CGRectMake(102, -2, 21, 21)];
    [deleteView setBackgroundImage:[UIImage imageNamed:@"deleteIcon.png"] forState:UIControlStateNormal];
    [deleteView addTarget:self action:@selector(removePhoto:) forControlEvents:UIControlEventTouchDown];
    [deleteView setTag:2000+[addedPicArray count]-1];
    if ([addedPicArray count] == 1) {
        imageView.frame = CGRectMake(20, 20, 120, 120);
        [imageView setTag:1000+[addedPicArray count]-1];
    }else{
        imageView.frame = CGRectMake(160+(140 * ([addedPicArray count]-2)), 20, 120, 120);
        [imageView setTag:1000+[addedPicArray count]-1];
    }
    [imageView addSubview:deleteView];
    [photoScroll addSubview:imageView];
    [addPic setFrame:CGRectMake(160+(140 * ([addedPicArray count]-1)), 20, 120, 120)];
    
    //reset the photoscroll
    [photoScroll setContentSize:CGSizeMake(([addedPicArray count]+1)*160 , 155)];
    [photoScroll setContentOffset:CGPointMake(0, 0)];
    [photoScroll scrollRectToVisible:CGRectMake(0,0,320,155) animated:NO];
    [_picker setNavigationBarHidden:NO animated:NO];
}

//Methods for add or delete tag
- (void)initTags
{
    for (int u = 0; u <[addedTagArray count]; u++) {
        if (u+1 == [addedTagArray count]){
            //Create the last tag
            //label
            UILabel *Views = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+u*50, 40, 40)];
            Views.text = [NSString stringWithFormat:@"J"];
            Views.font = [UIFont fontWithName:@"Trebuchet MS" size:20];
            Views.textColor = [UIColor whiteColor];
            Views.backgroundColor = [UIColor grayColor];
            Views.textAlignment = NSTextAlignmentCenter;
            [Views setTag:100+u];
            [scrollview addSubview:Views];
            
            //textfield
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(60, 10+u*50+3, 150, 40)];
            textField.borderStyle = UITextBorderStyleNone;
            textField.font = [UIFont fontWithName:@"Trebuchet MS" size:15];
            textField.placeholder = @"品牌、型号...";
            textField.autocorrectionType = UITextAutocorrectionTypeNo;
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.returnKeyType = UIReturnKeyDone;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
            textField.delegate = self;
            [textField setTag:200+u];
            [scrollview addSubview:textField];
            //add underline
            UILabel *aline = [[UILabel alloc]initWithFrame:CGRectMake(60, (u+1)*50-2, 150, 2)];
            aline.text = [NSString stringWithFormat:@""];
            aline.backgroundColor = UIColorFromRGB(0xd3d3d3);
            [aline setTag:300+u];
            [scrollview addSubview:aline];
            
            //add tag button
            addTag = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [addTag setBackgroundColor:UIColorFromRGB(0xd3d3d3)];
            addTag.frame = CGRectMake(220, 10+u*50, 40, 40);
            [addTag setTitle:@"+" forState:UIControlStateNormal];
            [addTag.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:20]];
            [addTag addTarget:self action:@selector(addTag) forControlEvents:UIControlEventTouchUpInside];
            [scrollview addSubview: addTag];
            UIButton *cutTagButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [cutTagButton setBackgroundColor:UIColorFromRGB(0xd3d3d3)];
            cutTagButton.frame = CGRectMake(270, 10+u*50, 40, 40);
            [cutTagButton setTitle:@"-" forState:UIControlStateNormal];
            [cutTagButton.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:20]];
            [cutTagButton addTarget:self action:@selector(deleteTag:) forControlEvents:UIControlEventTouchUpInside];
            [cutTagButton setTag:400+u];
            [scrollview addSubview: cutTagButton];
        }else
        {
            //Create normal tag
            //label
            UILabel *Views = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+u*50, 40, 40)];
            Views.text = [NSString stringWithFormat:@"J"];
            Views.font = [UIFont fontWithName:@"Trebuchet MS" size:20];
            Views.textColor = [UIColor whiteColor];
            Views.backgroundColor = [UIColor grayColor];
            Views.textAlignment = NSTextAlignmentCenter;
            [Views setTag:100+u];
            [scrollview addSubview:Views];
            
            //textfield
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(60, 10+u*50+3, 200, 40)];
            textField.borderStyle = UITextBorderStyleNone;
            textField.font = [UIFont fontWithName:@"Trebuchet MS" size:15];
            textField.placeholder = @"品牌、型号...";
            textField.autocorrectionType = UITextAutocorrectionTypeNo;
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.returnKeyType = UIReturnKeyDone;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            textField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
            textField.delegate = self;
            [textField setTag:200+u];
            [scrollview addSubview:textField];
            //add underline
            UILabel *aline = [[UILabel alloc]initWithFrame:CGRectMake(60, (u+1)*50-2, 200, 2)];
            aline.text = [NSString stringWithFormat:@""];
            aline.backgroundColor = UIColorFromRGB(0xd3d3d3);
            [aline setTag:300+u];
            [scrollview addSubview:aline];
            
            //add tag button
            UIButton *cutTagButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            [cutTagButton setBackgroundColor:UIColorFromRGB(0xd3d3d3)];
            cutTagButton.frame = CGRectMake(270, 10+u*50, 40, 40);
            [cutTagButton setTitle:@"-" forState:UIControlStateNormal];
            [cutTagButton.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:20]];
            [cutTagButton addTarget:self action:@selector(deleteTag:) forControlEvents:UIControlEventTouchUpInside];
            [cutTagButton setTag:400+u];
            [scrollview addSubview: cutTagButton];
        }
    }

}

- (void)addTag
{
    [addedTagArray addObject:[UIImage imageNamed:@"camera.png"]];
    //--Change the ex-last tag
    //textfield
    UITextField *textField = (UITextField *)[scrollview viewWithTag:200+[addedTagArray count]-2];
    [textField setFrame:CGRectMake(60, 10+([addedTagArray count]-2)*50+3, 200, 40)];
    //add underline
    UILabel *aline = (UILabel *)[scrollview viewWithTag:300+[addedTagArray count]-2];
    [aline setFrame:CGRectMake(60, (([addedTagArray count]-2)+1)*50-2, 200, 2)];
    [scrollview addSubview:aline];
    
    //--Create the last tag
    //label
    UILabel *nViews = [[UILabel alloc]initWithFrame:CGRectMake(10, 10+([addedTagArray count]-1)*50, 40, 40)];
    nViews.text = [NSString stringWithFormat:@"J"];
    nViews.font = [UIFont fontWithName:@"Trebuchet MS" size:20];
    nViews.textColor = [UIColor whiteColor];
    nViews.backgroundColor = [UIColor grayColor];
    nViews.textAlignment = NSTextAlignmentCenter;
    [nViews setTag:100+[addedTagArray count]-1];
    [scrollview addSubview:nViews];
    
    //textfield
    UITextField *ntextField = [[UITextField alloc] initWithFrame:CGRectMake(60, 10+([addedTagArray count]-1)*50+3, 150, 40)];
    ntextField.borderStyle = UITextBorderStyleNone;
    ntextField.font = [UIFont fontWithName:@"Trebuchet MS" size:15];
    ntextField.placeholder = @"品牌、型号...";
    ntextField.autocorrectionType = UITextAutocorrectionTypeNo;
    ntextField.keyboardType = UIKeyboardTypeDefault;
    ntextField.returnKeyType = UIReturnKeyDone;
    ntextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    ntextField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    ntextField.delegate = self;
    [ntextField setTag:200+[addedTagArray count]-1];
    [scrollview addSubview:ntextField];
    //add underline
    UILabel *naline = [[UILabel alloc]initWithFrame:CGRectMake(60, (([addedTagArray count]-1)+1)*50-2, 150, 2)];
    naline.text = [NSString stringWithFormat:@""];
    naline.backgroundColor = UIColorFromRGB(0xd3d3d3);
    [naline setTag:300+[addedTagArray count]-1];
    [scrollview addSubview:naline];
    
    //add tag button

    addTag.frame = CGRectMake(220, 10+([addedTagArray count]-1)*50, 40, 40);

    UIButton *ncutTagButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [ncutTagButton setBackgroundColor:UIColorFromRGB(0xd3d3d3)];
    ncutTagButton.frame = CGRectMake(270, 10+([addedTagArray count]-1)*50, 40, 40);
    [ncutTagButton setTitle:@"-" forState:UIControlStateNormal];
    [ncutTagButton.titleLabel setFont:[UIFont fontWithName:@"Trebuchet MS" size:20]];
    [ncutTagButton addTarget:self action:@selector(deleteTag:) forControlEvents:UIControlEventTouchUpInside];
    [ncutTagButton setTag:400+[addedTagArray count]-1];
    [scrollview addSubview: ncutTagButton];

    [self updateUI];
}

- (void)updateUI
{
    _tf.frame = CGRectMake(10, [addedTagArray count]*50+10, 300, 80+30);
    line.frame = CGRectMake(10, [addedTagArray count]*50+10+88+30, 300, 2);
    photoScroll.frame = CGRectMake(0, [addedTagArray count]*50+10+100+30, 320, 155);
    weiboButton.frame = CGRectMake(10, [addedTagArray count]*50+10+270+30, 30, 30);
    wechatButton.frame = CGRectMake(50, [addedTagArray count]*50+10+270+30, 30, 30);
    renrenButton.frame = CGRectMake(90, [addedTagArray count]*50+10+270+30, 30, 30);
}

- (void)deleteTag:(UIButton *) sender{
    NSInteger u = (sender.frame.origin.y - 10)/50;
    if ([addedTagArray count]!=1) {
        if (u+1 == [addedTagArray count]) {
        //delete last object and its components
        [addedTagArray removeLastObject];
        UILabel *Views = (UILabel *)[scrollview viewWithTag:100+u];
        [Views removeFromSuperview];
        UITextField *textField = (UITextField *)[scrollview viewWithTag:200+u];
        [textField removeFromSuperview];
        UILabel *aline = (UILabel *)[scrollview viewWithTag:300+u];
        [aline removeFromSuperview];
        UIButton *cutTagButton = (UIButton *)[scrollview viewWithTag:400+u];
        [cutTagButton  removeFromSuperview];
        //amend new last object components
        UITextField *nTextfield= (UITextField *)[scrollview viewWithTag:200+u-1];
        [nTextfield setFrame:CGRectMake(60, 10+(u-1)*50+3, 150, 40)];
        UILabel *naLine = (UILabel *)[scrollview viewWithTag:300+u-1];
        [naLine setFrame:CGRectMake(60, u*50-2, 150, 2)];
        [addTag setFrame:CGRectMake(220, 10+(u-1)*50, 40, 40)];
    }else{
        //delete the object and its components
        [addedTagArray removeObjectAtIndex:u];
        UILabel *Views = (UILabel *)[scrollview viewWithTag:100+u];
        [Views removeFromSuperview];
        UITextField *textField = (UITextField *)[scrollview viewWithTag:200+u];
        [textField removeFromSuperview];
        UILabel *aline = (UILabel *)[scrollview viewWithTag:300+u];
        [aline removeFromSuperview];
        UIButton *cutTagButton = (UIButton *)[scrollview viewWithTag:400+u];
        [cutTagButton  removeFromSuperview];
        for (NSInteger i = u+1; i<([addedTagArray count]+1); i++) {
            UILabel *Views = (UILabel *)[scrollview viewWithTag:100+i];
            [Views setFrame:CGRectMake(10, 10+(i-1)*50, 40, 40)];
            [Views setTag:100+i-1];
            UIButton *cutTagButton = (UIButton *)[scrollview viewWithTag:400+i];
            [cutTagButton setFrame:CGRectMake(270, 10+(i-1)*50, 40, 40)];
            [cutTagButton setTag:400+i-1];
            UITextField *textField = (UITextField *)[scrollview viewWithTag:200+i];
            [textField setTag:200+i-1];
            UILabel *aline = (UILabel *)[scrollview viewWithTag:300+i];
            [aline setTag:300+i-1];
            [addTag setFrame:CGRectMake(220, 10+(i-1)*50, 40, 40)];
            if (i==[addedTagArray count]) {
                [textField setFrame:CGRectMake(60, 10+(i-1)*50+3, 150, 40)];
                [aline setFrame:CGRectMake(60, i*50-2, 150, 2)];
            }else{
                [textField setFrame:CGRectMake(60, 10+(i-1)*50+3, 200, 40)];
                [aline setFrame:CGRectMake(60, i*50-2, 200, 2)];
            }
        }
    }
        
        [self updateUI];
    }
}


//Override function to make placeholder for UITextView
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    _tf.frame = CGRectMake(10, [addedTagArray count]*50+10, 300, 110);
    line.frame = CGRectMake(10, [addedTagArray count]*50+10+88+30, 300, 2);
    photoScroll.frame = CGRectMake(0, [addedTagArray count]*50+10+100+30, 320, 155);
    weiboButton.frame = CGRectMake(10, [addedTagArray count]*50+10+270+30, 30, 30);
    wechatButton.frame = CGRectMake(50, [addedTagArray count]*50+10+270+30, 30, 30);
    renrenButton.frame = CGRectMake(90, [addedTagArray count]*50+10+270+30, 30, 30);
    if(textView.tag == 0) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
        textView.tag = 1;
    }
    photoScroll.userInteractionEnabled = NO;
    scrollview.scrollEnabled = false;
    CGRect toVisible = CGRectMake(0, [addedTagArray count]*50, 320, 504);
    [scrollview scrollRectToVisible:toVisible animated:YES];
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView;
{
    if(_tf.contentSize.height > _tf.frame.size.height){
        _tf.frame = CGRectMake(10, [addedTagArray count]*50, 300, _tf.contentSize.height);
        line.frame = CGRectMake(10, [addedTagArray count]*50+10+88+30+_tf.contentSize.height-110-20, 300, 2);
        photoScroll.frame = CGRectMake(0, [addedTagArray count]*50+10+100+30+_tf.contentSize.height-110-20, 320, 155);
        weiboButton.frame = CGRectMake(10, [addedTagArray count]*50+10+270+30+_tf.contentSize.height-110-20, 30, 30);
        wechatButton.frame = CGRectMake(50, [addedTagArray count]*50+10+270+30+_tf.contentSize.height-110-20, 30-10, 30);
        renrenButton.frame = CGRectMake(90, [addedTagArray count]*50+10+270+30+_tf.contentSize.height-110-20, 30-10, 30);
    }
    if([textView.text length] == 0)
    {
        textView.text = @"物品描述、使用心得、看法...";
        textView.textColor = UIColorFromRGB(0xd3d3d3);
        textView.tag = 0;
    }
    photoScroll.userInteractionEnabled = YES;
    scrollview.scrollEnabled = true;
    CGRect toVisible = CGRectMake(0, 0, 320, 504);
    [scrollview scrollRectToVisible:toVisible animated:YES];

}

- (void)textViewDidChange:(UITextView *)textView {
    CGRect rline = [textView caretRectForPosition:
                   textView.selectedTextRange.start];
    CGFloat overflow = rline.origin.y + rline.size.height
    - ( textView.contentOffset.y + textView.bounds.size.height
       - textView.contentInset.bottom - textView.contentInset.top );
    if ( overflow > 0 ) {
        // We are at the bottom of the visible text and introduced a line feed, scroll down (iOS 7 does not do it)
        // Scroll caret to visible area
        CGPoint offset = textView.contentOffset;
        offset.y += overflow + 7; // leave 7 pixels margin
        // Cannot animate with setContentOffset:animated: or caret will not appear
        [UIView animateWithDuration:.2 animations:^{
            [textView setContentOffset:offset];
        }];
    }
}

-(void)hideKeyboard
{
    [_tf resignFirstResponder];
}

//Override function to dismiss keyboard for uitextfield by "Done" button
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    photoScroll.userInteractionEnabled = NO;
    _tf.userInteractionEnabled = NO;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    photoScroll.userInteractionEnabled = YES;
    _tf.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

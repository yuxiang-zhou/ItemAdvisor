//
//  RegisterViewController.m
//  ItemAdvisor
//
//  Created by Xiaoming Chen on 20/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (strong,nonatomic) UIImagePickerController *picker;
@property (strong, nonatomic) XWPhotoEditorViewController *photoEditor;
@end

@implementation RegisterViewController

- (IBAction)backToLogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)handInForm:(id)sender {
    
    [self checkTable];
}


-(void)viewDidAppear:(BOOL)animated
{
    _picker = [[UIImagePickerController alloc] init];
    _picker.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    for (UIView *subview in actionSheet.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subview;
            [button setTitleColor:UIColorFromRGB(0xe69a9e) forState:UIControlStateNormal];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return NO;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)editProfileImage:(id)sender {

    NSString *libraryTitle = @"照片库";
    NSString *takePhotoTitle = @"相机";
    NSString *cancelTitle = @"取消";
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:libraryTitle,takePhotoTitle, nil];
    [actionSheet showInView:_registerView];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    _photoEditor = [[XWPhotoEditorViewController alloc] initWithNibName:@"XWPhotoEditorViewController" bundle:nil];
    
    // set photo editor value
    _photoEditor.panEnabled = YES;
    _photoEditor.scaleEnabled = YES;
    _photoEditor.tapToResetEnabled = YES;
    _photoEditor.rotateEnabled = NO;
    _photoEditor.delegate = self;
    // crop window's value
    _photoEditor.cropSize = CGSizeMake(300, 300);
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
        self.photoEditor.sourceImage = image;
        [picker pushViewController:self.photoEditor animated:YES];
        [picker setNavigationBarHidden:YES animated:NO];


}

- (void)finish:(UIImage *)image didCancel:(BOOL)cancel {
    if (!cancel) {
        _profileImage = image;
        [_profilePicButton setBackgroundImage:_profileImage forState:UIControlStateNormal];
        [_profilePicButton setTitle:@"" forState:UIControlStateNormal];
    }
    [_picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark -
#pragma mark UIActionSheetDelegate Methods
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


- (void)checkTable
{
    NSString *passwordNotMatched = @"密码不相同";
    NSString *emailAddressInvalid = @"邮箱地址格式不对";
    NSString *passwordIncorrect = @"密码格式不对";
    NSString *errorContent = [NSString stringWithFormat:@"%@, %@, %@", passwordNotMatched, emailAddressInvalid, passwordIncorrect];
    
    if (![self checkEmailAddress]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"出错" message: errorContent delegate: _registerView cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (BOOL)checkPassword
{
    if (_createPassword.text == _confirmPassword.text) {
        return TRUE;
    }else{
        return FALSE;
    }
}

- (BOOL)checkEmailAddress
{
    if ([_emailAddress.text rangeOfString:@"@"].location != NSNotFound) {
        return TRUE;
    }
    else{
        
        return FALSE;
    }

}

- (void)sendForm
{
    
}

@end













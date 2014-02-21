//
//  RegisterViewController.m
//  ItemAdvisor
//
//  Created by Xiaoming Chen on 20/02/2014.
//  Copyright (c) 2014 ia. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController
- (IBAction)backToLogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)editProfileImage:(id)sender {
    UIActionSheet *profilePicMenu = [[UIActionSheet alloc] initWithTitle:nil
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                           destructiveButtonTitle:nil
                                                otherButtonTitles:@"相机", @"我的相册", nil];
    [profilePicMenu showInView:_registerView];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
        switch (buttonIndex) {
            case 0:
                //FLOG(@"相机");
                _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:_picker animated:YES completion:nil];
                break;
                
            case 1:
                //FLOG(@"我的相册");
                _picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                [self presentViewController:_picker animated:YES completion:nil];
                break;
                
            default:
                break;
        }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //release picker
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self performSegueWithIdentifier:@"test" sender:self];
    _profileImage = [info objectForKey:UIImagePickerControllerEditedImage];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"test"]) {
        
        UIViewController *CropViewController= [segue destinationViewController];
        //CropViewController.
    }
}

-(void)checkTable
{
    
}

@end













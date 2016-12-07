//
//  RedpacketUserLoginViewController.m
//  RedpacketDemo
//
//  Created by Mr.Yang on 2016/11/29.
//  Copyright © 2016年 Mr.Yang. All rights reserved.
//

#import "RedpacketUserLoginViewController.h"
#import "RedpacketUser.h"
#import "RedpacketDefines.h"
#import "RedpacketFucListViewController.h"

@interface RedpacketUserLoginViewController ()
@property (weak, nonatomic) IBOutlet UILabel *fistLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet UILabel *thirdLabel;
@property (nonatomic, assign) IBOutlet  UITextField *sender;
@property (nonatomic, assign) IBOutlet  UITextField *receiver;
@property (weak, nonatomic) IBOutlet UIButton *comeInBtn;

@end

@implementation RedpacketUserLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureClicked)];
    [self.view addGestureRecognizer:tap];
    self.fistLabel.textColor = rpHexColor(0xD24F44);
    self.secondLabel.textColor = rpHexColor(0x999999);
    self.thirdLabel.textColor = rpHexColor(0x999999);
    [self.comeInBtn setTitleColor:rpHexColor(0x44459A) forState:UIControlStateNormal];
    self.navigationController.navigationBarHidden = YES;
}

-(CGFloat)keyboardEndingFrameHeight:(NSDictionary *)userInfo
{
    return 40;
}

-(void)keyboardWillDisappear:(NSNotification *)notification
{

    self.view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}

-(void)keyboardWillAppear:(NSNotification *)notification
{
    CGRect currentFrame = self.view.frame;
    CGFloat change = [self keyboardEndingFrameHeight:[notification userInfo]];
    currentFrame.origin.y = currentFrame.origin.y - change ;
    self.view.frame = currentFrame;
}

- (void)tapGestureClicked
{
    [self.view endEditing:YES];
}

- (IBAction)loginButtonClicked:(id)sender
{
    if (_sender.text.length && _receiver.text.length) {
        
        [[RedpacketUser currentUser] loginWithSender:_sender.text
                                         andReceiver:_receiver.text];

        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    self.navigationController.navigationBar.barStyle       = UIBarStyleDefault;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

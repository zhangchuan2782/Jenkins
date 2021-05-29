//
//  ViewController.m
//  FTBankHelper
//
//  Created by Jermy on 15/11/9.
//  Copyright © 2015年 Jermy. All rights reserved.
//

#import "ViewController.h"
#import "oneKeyCheckViewController.h"
#import "FTPublicMethods.h"

@interface ViewController ()<UIAlertViewDelegate>
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIButton *iphoneInfoButton;
@property (nonatomic, weak) IBOutlet UIButton *bankEnvironment;
@property (nonatomic, weak) IBOutlet UIButton *aboutUs;
@property (nonatomic, weak) IBOutlet UIButton *question;
@property (nonatomic, weak) UIView *alertView;
@property (nonatomic, weak) UIView *coverView;
@property (nonatomic, weak) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, weak) UILabel *tipLabel;
@end

KeyType keyType = KeyType_Audio;    //存储设备类型

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    //设置imageView高度约束为屏幕高度的0.55倍
    NSLayoutConstraint *imageViewHeightConstraint = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.55f constant:0.0f];
    
     NSLayoutConstraint *imageViewWidthConstraint = [NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0f];
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1){
        imageViewHeightConstraint.active = YES;
        imageViewWidthConstraint.active = YES;
    }else{
        [_imageView.superview addConstraint:imageViewHeightConstraint];
        [_imageView.superview addConstraint:imageViewWidthConstraint];
    }
    
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.image = [UIImage imageNamed:@"background.png"];
    
    ////////////////////////////////////////////////////////////////
    //设置button背景图片
    [_iphoneInfoButton setImage:[UIImage imageNamed:@"iphoneInfo.png"] forState:UIControlStateNormal];
    [_iphoneInfoButton setImage:[UIImage imageNamed:@"iphoneInfo_selected.png"] forState:UIControlStateHighlighted];
    _iphoneInfoButton.contentMode = UIViewContentModeScaleAspectFill;
    _iphoneInfoButton.layer.borderWidth = 1.0f;
    _iphoneInfoButton.layer.borderColor = [[UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:242.0/255.0 alpha:1.0] CGColor];
    
    UIImage *m_image = [UIImage imageNamed:@"oneKeyCheck"];
    [_bankEnvironment setImage:m_image forState:UIControlStateNormal];
    _bankEnvironment.contentMode = UIViewContentModeScaleAspectFill;
    [_bankEnvironment setImage:[UIImage imageNamed:@"oneKeyCheck_selected"] forState:UIControlStateHighlighted];
    _bankEnvironment.layer.borderWidth = 1.0f;
    _bankEnvironment.layer.borderColor = [[UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:242.0/255.0 alpha:1.0] CGColor];
    
    [_aboutUs setImage:[UIImage imageNamed:@"aboutUs.png"] forState:UIControlStateNormal];
    [_aboutUs setImage:[UIImage imageNamed:@"aboutUs_selected.png"] forState:UIControlStateHighlighted];
    _aboutUs.contentMode = UIViewContentModeScaleAspectFill;
    _aboutUs.layer.borderWidth = 1.0f;
    _aboutUs.layer.borderColor = [[UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:242.0/255.0 alpha:1.0] CGColor];

    [_question setImage:[UIImage imageNamed:@"question.png"] forState:UIControlStateNormal];
    [_question setImage:[UIImage imageNamed:@"question_selected.png"] forState:UIControlStateHighlighted];
    _question.contentMode = UIViewContentModeScaleAspectFill;
    _question.layer.borderWidth = 1.0f;
    _question.layer.borderColor = [[UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:242.0/255.0 alpha:1.0] CGColor];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if(NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1){
        [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:180/255.0 green:28/255.0 blue:29/255.0 alpha:1.0]];
    }else{
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:13/255.0 green:72/255.0 blue:149/255.0 alpha:1.0];
    }
    
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
}

//选择设备类型界面
-(void)showSelecteKeyType
{
    //背景遮罩
    UIView *coverView = [[UIView alloc] init];
    coverView.frame = [UIScreen mainScreen].bounds;
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.5;
    self.coverView = coverView;
    [self.view.window addSubview:coverView];
    
    //提示框View
    UIView *alertView = [[UIView alloc] init];
    alertView.backgroundColor = [UIColor whiteColor];
    alertView.layer.cornerRadius = 5;
    self.alertView = alertView;
    
    NSInteger alertW = [UIScreen mainScreen].bounds.size.width * 0.8;
    NSInteger alertH = [UIScreen mainScreen].bounds.size.height * 0.2;
    NSInteger alertX = ([UIScreen mainScreen].bounds.size.width - alertW) * 0.5;
    NSInteger alertY = ([UIScreen mainScreen].bounds.size.height - alertH) * 0.5;
    alertView.frame = CGRectMake(alertX, alertY, alertW, alertH);
    [self.view.window addSubview:alertView];
    
    //提示信息label
    UILabel *msgLabel = [[UILabel alloc] init];
    NSInteger msgLabelW = alertW * 0.8;
    NSInteger msgLabelH = 30;
    NSInteger msgLabelX = (alertW - msgLabelW) * 0.5;
    NSInteger msgLabelY = 20;
    msgLabel.frame = CGRectMake(msgLabelX, msgLabelY, msgLabelW, msgLabelH);
    msgLabel.text = @"请选择设备类型";
    msgLabel.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:msgLabel];
    
    //功能按钮
    NSInteger btnW = alertW * 0.5;
    NSInteger btnH = 40;
    NSInteger btnY = alertH - btnH;
    
    //蓝牙按钮
    UIButton *bleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSInteger bleBtnX = 0;
    bleBtn.frame = CGRectMake(bleBtnX, btnY, btnW, btnH);
    bleBtn.layer.borderWidth = 1;
    bleBtn.layer.borderColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    [bleBtn setTitle:@"蓝牙" forState:UIControlStateNormal];
    [bleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bleBtn addTarget:self action:@selector(selBle) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:bleBtn];
    
    //音频按钮
    UIButton *audioBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSInteger audioBtnX = bleBtnX + btnW;
    audioBtn.frame = CGRectMake(audioBtnX, btnY, btnW, btnH);
    audioBtn.layer.borderWidth = 1;
    audioBtn.layer.borderColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
    [audioBtn setTitle:@"音频" forState:UIControlStateNormal];
    [audioBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [audioBtn addTarget:self action:@selector(selAudio) forControlEvents:UIControlEventTouchUpInside];
    [alertView addSubview:audioBtn];
}

//选择蓝牙
-(void)selBle
{
    [_alertView removeFromSuperview];
    [_coverView removeFromSuperview];
    
    keyType = KeyType_BLE;
    [self performSegueWithIdentifier:@"oneKeyCheck1" sender:self];
}

//选择音频
-(void)selAudio
{
    [_alertView removeFromSuperview];
    [_coverView removeFromSuperview];
    
    keyType = KeyType_Audio;
    [self performSegueWithIdentifier:@"oneKeyCheck2" sender:self];
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if([identifier hasPrefix:@"oneKeyCheck"]){
        
//        [self showSelecteKeyType];
        
        [self scan];
        
        return NO;
    }
    
    return YES;
}

- (void)scan {
    
    __block BOOL stop = NO;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"检测中..." message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        stop = YES;
        
    }];
    
    [alertController addAction:cancleAction];

    [self presentViewController:alertController animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (!stop) {
            
            [alertController dismissViewControllerAnimated:YES completion:^{
                
            }];
            
            [self showAlertController];
            
        }
        
    });
    
}

- (void)showAlertController {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"没有发现可用的设备" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
    }];
    
    [alertController addAction:okAction];

    [self presentViewController:alertController animated:YES completion:nil];
    
}

@end

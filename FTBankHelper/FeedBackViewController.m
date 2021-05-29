//
//  FeedBackViewController.m
//  FTBankHelper
//
//  Created by Jermy on 15/11/17.
//  Copyright © 2015年 Jermy. All rights reserved.
//

#import "FeedBackViewController.h"
#import "FeedbackTableViewCell.h"
#import "FeedbackTableViewCell3.h"
#import "FeedBackTableViewCell4.h"

#import "UploadFiles.h"
#import <MediaPlayer/MediaPlayer.h>

@interface FeedBackViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate,UIImagePickerControllerDelegate, UploadFilesDelegate, UIAlertViewDelegate, FeedBackCell4Delegate, UINavigationControllerDelegate>

@property(nonatomic, strong)FeedbackTableViewCell *cell2;
@property(nonatomic, strong)FeedbackTableViewCell3 *cell3;
@property(nonatomic, strong)FeedBackTableViewCell4 *cell4;
@property(nonatomic, strong)UploadFiles *uploadFile;
@property(nonatomic, strong)UIView *loadingView;
@property(nonatomic, strong)UIViewController *topViewController;
@property(nonatomic, strong)UIImagePickerController *imagePickerVC;
@end

@implementation FeedBackViewController
{
    NSData *_imageData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏文字颜色
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
     //去掉导航栏文字，只保留箭头
    if(NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_7_0){
        
    }else{
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                            forBarMetrics:UIBarMetricsDefault];
    }
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitToServer)];
    
    self.navigationItem.rightBarButtonItem = rightButton;
    
    _uploadFile = [[UploadFiles alloc] init];
    _uploadFile.delegate = self;
    
    //去掉IOS7上顶端的空白
    if(NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_7_0){
        
    }else{
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
    //去掉多余显示的cell行
    [_feedBackTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    _feedBackTableView.delegate = self;
    _feedBackTableView.dataSource = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    if(NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_7_0){
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:13/255.0 green:72/255.0 blue:149/255.0 alpha:1.0];
    }

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchMainView)];
    
    [self.view addGestureRecognizer:tapGesture];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier1 = @"feedBackCell1";
    static NSString *cellIdentifier3 = @"feedBackCell3";
    static NSString *cellIdentifier4 = @"feedBackCell4";
    
    UITableViewCell *cell =nil;

    if(indexPath.section == 0){
        
        _cell3 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier3];
        if(_cell3 == nil){
            _cell3 = [[FeedbackTableViewCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier3];
        }
        _cell3.msgTextView.delegate = self;
        _cell3.msgTextView.font = [UIFont systemFontOfSize:15];
        _cell3.msgTextView.layer.borderWidth = 0.6f;
        _cell3.msgTextView.layer.cornerRadius = 6.0f;
        _cell3.msgTextView.layer.borderColor = [[UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:242.0/255.0 alpha:1.0] CGColor];
        
        cell = _cell3;
    }else if(indexPath.section == 1){
        
        _cell4 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier4];
        if(_cell4 == nil){
            _cell4 = [[FeedBackTableViewCell4 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier4];
        }

        _cell4.delegate = self;
        cell = _cell4;
        
    }else if(indexPath.section == 2){
        
        _cell2 = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        if(_cell2 == nil){
            _cell2 = [[FeedbackTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier1];
        }
        
        _cell2.dropDownImage.hidden = YES;
        
        _cell2.bankTextField.delegate = self;
        _cell2.bankTextField.keyboardType = UIKeyboardTypePhonePad;
        _cell2.bankTextField.font = [UIFont systemFontOfSize:18];
        _cell2.bankTextField.layer.borderWidth = 1.0f;
        _cell2.bankTextField.layer.cornerRadius = 2.0f;
        _cell2.bankTextField.layer.borderColor = [[UIColor colorWithRed:236.0/255.0 green:236.0/255.0 blue:242.0/255.0 alpha:1.0] CGColor];
        
        cell = _cell2;

    }
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
//实现代理方法
-(void)addPicker:(UIImagePickerController *)picker{
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)addUIImagePicker:(UIImagePickerController *)picker
{
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

#pragma mark --tableviewdelegete viewForHeaderInSection--
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    CGRect mainScreen = [UIScreen mainScreen].bounds;
    
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, mainScreen.size.width, 44.0)];
    
    UILabel * headerLabel = [[UILabel alloc] init];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor lightGrayColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:16];
    headerLabel.frame = CGRectMake(10.0, 0.0, mainScreen.size.width, 44.0);
    
    if (section == 0) {
        headerLabel.text = @"请填写问题描述";
    }else if (section == 1){
        headerLabel.text = @"请选择问题截图";
    }else if (section == 2){
        headerLabel.text = @"请填写您的联系方式,方便我们与您联系";
    }
    
    [customView addSubview:headerLabel];
    
    return customView;
}

NSInteger returncode = 0;

//提交反馈问题
-(void)submitToServer
{
    [_cell2.bankTextField resignFirstResponder];
    [_cell3.msgTextView resignFirstResponder];
    
    NSString *phoneNumber = _cell2.bankTextField.text;
    NSString *message = _cell3.msgTextView.text;
    UIImage *image = nil;
    
    
    if(([phoneNumber  isEqual: @""]) && ([message  isEqual: @""]) && (image == nil)){
        [self showMsg:@"请填写至少一项反馈信息"];
        return;
    }
    
    if(![UploadFiles canOpenUrl]){
        [self showMsg:@"网络连接失败，请检查网络连接状态"];
        return;
    }
    
    [self setNavigationController:NO];
    
    _loadingView = [_uploadFile showWaitView];
    
    _topViewController = [_uploadFile getTopViewController];
    
    [_topViewController.view addSubview:_loadingView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        [_uploadFile submitToServer:phoneNumber feedbackMessage:message imageData:_imageData returnCode:&returncode];
    });
}

#pragma mark didFinishUploadFiles
-(void)didFinishUploadFiles
{
    dispatch_time_t delaytime = dispatch_time(DISPATCH_TIME_NOW, 2.0*NSEC_PER_SEC);
    
    dispatch_after(delaytime, dispatch_get_main_queue(), ^{
        
        [_loadingView removeFromSuperview];
        
        if(returncode == 200){
            [self showMsg:@"信息上传成功"];
        }else{
            [self showMsg:@"信息上传失败,请稍后重试"];
        }
        
        [self setNavigationController:YES];

    });
}

#pragma mark --tableviewdelegete heightForHeaderInSection--
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

#pragma mark --tableviewdelegate numberOfRowsInSection--
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark --tableviewdelegate numberOfSectionsInTableView--
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

#pragma mark --tableviewdelegate heightForRowAtIndexPath--
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize mainScreen = [UIScreen mainScreen].bounds.size;
    
    if(indexPath.section == 0){
        //iPhone4、4S 手机特殊处理
        if(mainScreen.height == 480){
            return 115;
        }else{
            return 150;
        }
    }else if(indexPath.section == 1){
        return 80;
    }else if(indexPath.section == 2){
        return 44;
    }else{
        return 0;
    }
}

//选择图片
-(void)didSelectedImage
{
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.delegate = self;
    _imagePickerVC = imagePickerVC;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
{
    _imageData = UIImageJPEGRepresentation(image, 0);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [_imagePickerVC dismissViewControllerAnimated:YES completion:nil];
        [_cell4.selImageBtn setImage:image forState:UIControlStateNormal];
    });
}

#pragma mark --textfielddelegate textFieldShouldReturn--
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    CGFloat offset = _feedBackTableView.frame.size.height - _cell2.frame.origin.y - _cell2.frame.size.height - 216;
    
    if(offset < 0){
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y = offset;
            self.view.frame = frame;
        }];
    }
    
    return YES;
}

//设置NavigationController是否可以滑动
-(void)setNavigationController:(BOOL)enable
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = enable;
    }
}

-(void)touchMainView
{
    [_cell2.bankTextField resignFirstResponder];
    [_cell3.msgTextView resignFirstResponder];
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.view.frame = frame;
    }];
}

-(void)showMsg:(NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    alert.delegate = self;
    
    [alert show];
}

#pragma mark clickedButtonAtIndex
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if([alertView.message isEqualToString:@"信息上传成功"]){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end

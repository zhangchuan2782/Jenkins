//
//  IPhoneInfoViewController.m
//  FTBankHelper
//
//  Created by Jermy on 15/11/9.
//  Copyright © 2015年 Jermy. All rights reserved.
//

#import "IPhoneInfoViewController.h"
#import "iphoneInfoTableViewCell.h"

#import <sys/types.h>
#import <sys/sysctl.h>
#import <mach/host_info.h>
#import <mach/mach_host.h>
#import <mach/task_info.h>
#import <mach/task.h>

@interface IPhoneInfoViewController ()
@property(nonatomic, strong)NSString *phoneName;
@property(nonatomic, strong)NSString *systemVersion;
@property(nonatomic, strong)NSString *strTotalSpace;
@property(nonatomic, strong)NSString *strFreeSpace;


@end

@implementation IPhoneInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏文字颜色
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    
    //设置导航栏文字
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backToMainScreen)];
//    self.navigationItem.leftBarButtonItem = backItem;
    
    //去掉导航栏文字，只保留箭头
    if(NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_7_0){
        
    }else{
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                             forBarMetrics:UIBarMetricsDefault];
    }
    
    [self getPhoneInfo];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if(NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_7_0){
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:13/255.0 green:72/255.0 blue:149/255.0 alpha:1.0];
    }
}

-(void)backToMainScreen
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getPhoneInfo
{
    
    _phoneName = [[UIDevice currentDevice] name];

    _systemVersion = [NSString stringWithFormat:@"IOS %@", [[UIDevice currentDevice]systemVersion]];
    
    [self getFreeDiskspace];
    
}

//获取手机内存信息
- (void)getFreeDiskspace{
    float totalSpace;
    float totalFreeSpace=0.f;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes floatValue]/1024.0f/1024.0f/1024.0f;
        totalFreeSpace = [freeFileSystemSizeInBytes floatValue]/1024.0f/1024.0f/1024.0f;
        _strTotalSpace = [NSString stringWithFormat:@"%.2fG",totalSpace];
        _strFreeSpace = [NSString stringWithFormat:@"%.2fG",totalFreeSpace];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"iphoneInfoCell";
    
    iphoneInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[iphoneInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.label.textAlignment = NSTextAlignmentRight;
    
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            cell.textLabel.text = @"手机名称";
            cell.label.text = _phoneName;
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"系统版本";
            cell.label.text = _systemVersion;
        }else if(indexPath.row == 2){
            cell.textLabel.text = @"系统内存";
            cell.label.text = _strTotalSpace;
        }else if(indexPath.row == 3){
            cell.textLabel.text = @"可用内存";
            cell.label.text = _strFreeSpace;
        }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
@end

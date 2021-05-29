//
//  bankEnvironmentViewController.m
//  FTBankHelper
//
//  Created by Jermy on 15/11/10.
//  Copyright © 2015年 Jermy. All rights reserved.
//

#import "bankEnvironmentViewController.h"
#import "bankEnvironmentCell.h"

@interface bankEnvironmentViewController ()

@property (strong, nonatomic) IBOutlet UITableView *bankEnvTableView;
@end

@implementation bankEnvironmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置导航栏文字颜色
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];

    //去掉导航栏文字，只保留箭头
    if(NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_7_0){
        
    }else{
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                             forBarMetrics:UIBarMetricsDefault];
    }
    
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSString *path = [bundle pathForResource:@"BankURL" ofType:@"plist"];
    
    _listDic = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    _listArr = [_listDic allKeys];
    
    //去掉多余显示的cell行
    [_bankEnvTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
}

-(void)viewWillAppear:(BOOL)animated
{
    if(NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_7_0){
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:13/255.0 green:72/255.0 blue:149/255.0 alpha:1.0];
    }
}

//搜索手机中安装的软件
-(void)checkURL
{
    NSDictionary *dic = [NSDictionary dictionary];
    NSString *strKeyName = nil;
    NSString *strUrl = nil;
    NSURL *url = nil;
    
    for(int i = 0; i < _listArr.count; i++){
        strKeyName = [_listArr objectAtIndex:i];
        dic = [_listDic objectForKey:strKeyName];
        strUrl = [dic objectForKey:@"URL"];
        url = [NSURL URLWithString:strUrl];
        
        if(![[UIApplication sharedApplication] canOpenURL:url]){
            [_listDic removeObjectForKey:strKeyName];
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdent = @"bankCell";
    
    bankEnvironmentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdent forIndexPath:indexPath];
    
    if(cell == nil){
        cell = [[bankEnvironmentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdent];
    }
    
    NSString *bankName = nil;

    NSURL *url = [self getUrlFromDic:_listDic index:indexPath.row urlType:@"URL" bankName:&bankName];
    
    NSString *imageName = [NSString stringWithFormat:@"%@.png", bankName];
        
    cell.imageView.image = [UIImage imageNamed:imageName];
    
    cell.textLabel.text = bankName;
    

    if([[UIApplication sharedApplication] canOpenURL:url]){
//        cell.textLabel.textColor = [UIColor greenColor];
//        cell.label.textColor = [UIColor greenColor];
        if([bankName isEqual:@"中国银行"]){
            cell.label.text = @"已下载";
        }else{
            cell.label.text = @"打开";
        }
        
    }else{
        cell.textLabel.textColor = [UIColor redColor];
        cell.label.textColor = [UIColor redColor];
        cell.label.text = @"下载";
    }
    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *bankName = nil;
    
    NSURL *url = [self getUrlFromDic:_listDic index:indexPath.row urlType:@"URL" bankName:&bankName];
    
    NSURL *appLinkUrl = [self getUrlFromDic:_listDic index:indexPath.row urlType:@"APPLink" bankName:&bankName];
    
    if([[UIApplication sharedApplication] canOpenURL:url]){
        if([bankName isEqual:@"中国银行"]){
            
        }else{
            [[UIApplication sharedApplication] openURL:url];
        }
    }else{
        [[UIApplication sharedApplication] openURL:appLinkUrl];
    }

}

-(NSURL*)getUrlFromDic:(NSMutableDictionary *)dic index:(NSInteger)index urlType:(NSString*)urlType bankName:(NSString **)bankName
{
    NSArray *allKeys = [dic allKeys];
    
    NSString *key = [allKeys objectAtIndex:index];
    
    NSDictionary *myDic = [dic objectForKey:key];
    
    NSString *urlName = [myDic objectForKey:urlType];
    
    *bankName = [myDic objectForKey:@"name"];
    
    return ([NSURL URLWithString:urlName]);
}

@end

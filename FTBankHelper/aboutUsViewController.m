//
//  aboutUsViewController.m
//  FTBankHelper
//
//  Created by Jermy on 15/11/10.
//  Copyright © 2015年 Jermy. All rights reserved.
//

#import "aboutUsViewController.h"
#import "aboutUsTableViewCell.h"

@interface aboutUsViewController ()

@end

@implementation aboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置导航栏文字颜色
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    //设置导航栏文字
//        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(backToMainScreen)];
//        self.navigationItem.leftBarButtonItem = backItem;
    
    //去掉导航栏文字，只保留箭头
    if(NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_7_0){
        
    }else{
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    if(NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_7_0){
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:13/255.0 green:72/255.0 blue:149/255.0 alpha:1.0];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 1;
    }else{
        return 3;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"aboutUsCell";
    
    aboutUsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[aboutUsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.label.textColor = [UIColor blueColor];
    cell.label.userInteractionEnabled = YES;

    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(openURL:)];
    [cell.label addGestureRecognizer:tapGesture];
    
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            cell.textLabel.text = @"当前版本";
            cell.label.text = @"V1.0";
        }
    }else if(indexPath.section == 1){
        if(indexPath.row == 0){
            cell.textLabel.text = @"官网";
            NSMutableAttributedString *str = [self addUnderLine:@"http://www.ftsafe.com.cn"];
            [cell.label setAttributedText:str];
            cell.label.tag = 1001;
            
        }else if(indexPath.row == 1){
            cell.textLabel.text = @"技术支持电话";
            cell.label.text = @"4006964466";
            cell.label.tag = 1002;
        }else if(indexPath.row == 2){
            cell.textLabel.text = @"飞天诚信企业QQ";
            cell.label.text = @"4006964466";
            cell.label.tag = 1003;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(NSMutableAttributedString *)addUnderLine:(NSString*)text
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:text];
    
    NSRange strRange = {0, str.length};
    
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    
    return str;
}

-(void)openURL:(UITapGestureRecognizer *)gesture{
    NSInteger tag = gesture.view.tag;
    NSString *url = nil;
    if (tag == 1001) {
        url = @"http://www.ftsafe.com.cn/";
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else if(tag == 1002){
        url = [NSString stringWithFormat:@"telprompt:%@",@"4006964466"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }else if(tag == 1003){
        
        UIPasteboard *pastBoard = [UIPasteboard generalPasteboard];
        
        [pastBoard setString:@"4006964466"];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"QQ号码已复制，请在QQ中搜索并添加号码。" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

@end

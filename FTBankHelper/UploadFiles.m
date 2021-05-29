//
//  UploadFiles.m
//  FTBankHelper
//
//  Created by Jermy on 15/12/16.
//  Copyright © 2015年 Jermy. All rights reserved.
//

#import "UploadFiles.h"
#import "GTMBase64.h"
#import <UIKit/UIKit.h>

#import "Reachability.h"
#import "sys/utsname.h"
#import <sys/sysctl.h>

#define YYEncode(str) [str dataUsingEncoding:NSUTF8StringEncoding]

#define serverUrl @"k4.ftsafe.com"

#define requestMethod @"POST"

#define requestTimeout 60.0

//手机号码信息头
#define headPhoneNumber @"PhoneNumber"

//反馈信息头
#define headMessage @"Message"

//图片信息头
#define headImage @"Image"

//银行信息
#define headBank @"bank"

//视频信息头
#define headAudio @"Audio"

//冒号
#define colon @":"

//字段结束符
#define endIden @"\r\n"

//上传成功返回码
#define uploadSuccess 200

@interface UploadFiles()


@end

@implementation UploadFiles


-(id)init
{
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

//判断网络连接状态
+(BOOL)canOpenUrl
{
    Reachability *r = [Reachability reachabilityWithHostName:serverUrl];
    
    if([r currentReachabilityStatus] == NotReachable){
        return NO;
    }else if(([r currentReachabilityStatus] == ReachableViaWiFi) || ([r currentReachabilityStatus] == ReachableViaWWAN)){
        return YES;
    }else{
        return NO;
    }
}

-(NSData*)encodeBase64String:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    //    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return data;
}

-(NSData*)encodeBase64Data:(NSData*)input
{
    NSData *data = [GTMBase64 encodeData:input];
    
    return data;
}

-(NSString*)getPhoneInfo
{
    
//    NSLog(@"%@", [[UIDevice currentDevice]systemName]);
//    NSLog(@"%@", [[UIDevice currentDevice]systemVersion]);
//    NSLog(@"%@", [[UIDevice currentDevice]model]);
    
    NSString *device = [self deviceVersion];
    
    NSString *systemVersion = [NSString stringWithFormat:@"IOS %@", [[UIDevice currentDevice]systemVersion]];

    NSString *iphoneInfo = [NSString stringWithFormat:@"%@ %@ ",device, systemVersion];
    
    return iphoneInfo;
}

-(NSString*)deviceVersion
{
    // 需要#import "sys/utsname.h"
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *deviceString = [NSString stringWithFormat:@"%s", machine];
    free(machine);
    
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6S Plus";
//    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
//    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
//    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
//    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
//    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
//    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
//    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
//    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
//    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
//    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
//    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
//    if(deviceString == nil){
//        return @"未识别设备";
//    }
    
    return deviceString;
}

//提交反馈问题
-(void)submitToServer:(NSString*)phoneNumber feedbackMessage:(NSString*)feedbackMessage imageData:(NSData *)imageData returnCode:(NSInteger *)returnCode
{
    NSString *strUrl = [NSString stringWithFormat:@"http://%@", serverUrl];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
//    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];//请求头
    [request setHTTPMethod:requestMethod];
    request.timeoutInterval = requestTimeout;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];

    //电话号码base64编码
    NSData *base64 = [self encodeBase64String:phoneNumber];
    NSString *phoneNumberStr = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    [dic setObject:phoneNumberStr forKey:headPhoneNumber];
    
    //获取手机型号、系统版本
    NSString *iphoneInfo = [@" 手机信息:" stringByAppendingString:[self getPhoneInfo]];

    //反馈信息拼接手机信息
    if(iphoneInfo != nil){
        feedbackMessage = [feedbackMessage stringByAppendingString:iphoneInfo];
    }
    
    NSData *messageBase64 = [self encodeBase64String:feedbackMessage];
    NSString *messageStr = [[NSString alloc] initWithData:messageBase64 encoding:NSUTF8StringEncoding];
    [dic setObject:messageStr forKey:headMessage];

    //上传图片文件
    NSData *imageBase64 = [self encodeBase64Data:imageData];
    NSString *imageStr = [[NSString alloc] initWithData:imageBase64 encoding:NSUTF8StringEncoding];
    [dic setObject:imageStr forKey:headImage];

    //将反馈信息转换成JSON格式
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    
    request.HTTPBody = jsonData;
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        NSHTTPURLResponse *httpResponse =(NSHTTPURLResponse*)response;
        
        *returnCode = httpResponse.statusCode;
        
        //上传成功会返回状态码200和请求的页面信息
        if((httpResponse.statusCode == uploadSuccess) && (data != nil)){
            
//            *returnCode = [NSString stringWithFormat:@"success"];
//            NSLog(@"upload success");
            
        }else{
            
//            *returnCode = [NSString stringWithFormat:@"%@", [connectionError localizedDescription]];
//            NSLog(@"upload fail");
//            NSLog(@"%ld", (long)httpResponse.statusCode);
        }
        
        if([_delegate respondsToSelector:@selector(didFinishUploadFiles)]){
            [_delegate didFinishUploadFiles];
        }
    }];
}


-(UIView*)showWaitView
{
    CGRect mainScreen = [UIScreen mainScreen].bounds;
    
    NSInteger screenHeight = mainScreen.size.height;
    
    NSInteger screenWidth = mainScreen.size.width;
    
    NSInteger waitViewHeight = 100;
    
    NSInteger waitViewWidth = screenWidth - 60;
    
    UIView *myView = [[UIView alloc] init];
    myView.frame = mainScreen;
    myView.backgroundColor = [UIColor clearColor];
    
    //背景View
    UIView *waitBackView = [[UIView alloc] init];
    waitBackView.frame = mainScreen;
    waitBackView.backgroundColor = [UIColor blackColor];
    waitBackView.alpha = 0.5;
    [myView addSubview:waitBackView];
    
    UIView *waitView = [[UIView alloc] init];
    waitView.frame = CGRectMake((screenWidth - waitViewWidth)/2, (screenHeight-waitViewHeight)/2, waitViewWidth, waitViewHeight);
    waitView.backgroundColor = [UIColor whiteColor];
    waitView.alpha = 1.0;
    waitView.layer.cornerRadius = 5.0;
    [myView addSubview:waitView];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(waitViewWidth/2 - 20, 10, 40, 40)];
    
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [waitView addSubview:indicator];
    [indicator startAnimating];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"请稍候...";
    label.frame = CGRectMake(waitViewWidth/2 - 50, 50, 100, 44);
    label.textAlignment = NSTextAlignmentCenter;
    [waitView addSubview:label];
    
    return myView;
}

-(UIViewController *)getTopViewController{
    
    return [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

-(UIViewController *)topViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil) {
        return rootViewController;
    }
    
    if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self topViewController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [self topViewController:presentedViewController];
}

@end

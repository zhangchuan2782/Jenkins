//
//  FTPublicMethods.h
//  FTABCBank
//
//  Created by Li Yuelei on 9/12/13.
//  Copyright (c) 2013 FT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "MyAlertView.h"
#define FTPublicMethods ______ft_a81
@interface FTPublicMethods : NSObject


+ (NSString*)getPreferredLanguage;

+(void)showInprogress:(NSString *)MsgKey delegate:(id)delegate isSign:(bool)isSign RemainTimes:(unsigned char)RemainTimes;
+(void)hideInprogress;

+(void)showMsgOnIOS7:(NSString *)MsgKey delegate:(id)delegate;
+(void)showMsg:(NSString *)MsgKey delegate:(id)delegate;
+(void)hideMsg;

+(void)showErr:(NSString *)errStr delegate:(id)delegate;
+(void)hideErr;

+(void)showPINRemainTimes:(unsigned char)RemainTimes message:(NSString *)msg delegate:(id)delegate;
+(void)hidePINRemianTimes;


+(NSString *)getDictValueForKey:(NSString *)key;


+(void)hidePINInfoMsg;
+(void)showPINInfoMsg:(unsigned char)RemainTimes delegate:(id)delegate onlyPressKey:(BOOL) isOnlyPressKey;

+(void)showSignInfo:(id)delegate;
+(void)hideSignInfo;

+(UIViewController *)getTopViewController;

+(void)addApplicationMonitor:(id)observer selector:(SEL)aSelector name:(NSString *)name;

+(void)removeApplicationMonitor:(id)observer name:(NSString *)name;

+(void)EnableSignSwitch;

@end

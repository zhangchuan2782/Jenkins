//
//  MyMacro.h
//  STDDemo
//
//  Created by ftd_feitian on 2017/5/15.
//  Copyright © 2017年 DengYan. All rights reserved.
//

#ifndef MyMacro_h
#define MyMacro_h

//系统版本判断
#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)

#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//屏幕宽、高
#define KS_BOUNDS [[UIScreen mainScreen] bounds]
#define KS_WIDTH KS_BOUNDS.size.width
#define KS_HEIGHT KS_BOUNDS.size.height

//RGB
#define KS_RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define KS_RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define KS_SAMERGB(color) KS_RGB(color,color,color)
#define KS_SAMERGBA(color,a) KS_RGBA(color,color,color,a)

//飞天蓝RGB
#define BLUE_RGB KS_RGB(26,101,170)
#define BLUE_RGBA5 KS_RGBA(26,101,170,0.5)
#define BLUE_RGBA2 KS_RGBA(26,101,170,0.2)

//以iPhone6为标志的比例
#define KS_SCALE(a) a*(KS_WIDTH/375.0)

#endif /* MyMacro_h */

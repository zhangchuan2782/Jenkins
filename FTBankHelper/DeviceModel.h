//
//  DeviceModel.h
//  FTBankHelper
//
//  Created by Jermy on 2017/10/25.
//  Copyright © 2017年 Jermy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceModel : NSObject

@property (nonatomic, copy) NSString *devName;
@property (nonatomic, copy) NSString *UUID;
@property (nonatomic, assign)unsigned int devType;

+(instancetype)deviceWithName:(NSString *)name uuid:(NSString *)uuid devType:(unsigned int)devType;

@end

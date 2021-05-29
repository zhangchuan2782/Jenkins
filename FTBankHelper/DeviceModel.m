//
//  DeviceModel.m
//  FTBankHelper
//
//  Created by Jermy on 2017/10/25.
//  Copyright © 2017年 Jermy. All rights reserved.
//

#import "DeviceModel.h"

@implementation DeviceModel

-(instancetype)initWithName:(NSString *)name uuid:(NSString *)uuid devType:(unsigned int)devType
{
    self = [super init];
    
    if(self){
        self.devName = name;
        self.UUID = uuid;
        self.devType = devType;
    }
    return self;
}

+(instancetype)deviceWithName:(NSString *)name uuid:(NSString *)uuid devType:(unsigned int)devType
{
    return [[self alloc] initWithName:name uuid:uuid devType:devType];
}

@end

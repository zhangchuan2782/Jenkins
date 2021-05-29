//
//  bankEnvironmentViewController.h
//  FTBankHelper
//
//  Created by Jermy on 15/11/10.
//  Copyright © 2015年 Jermy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bankEnvironmentViewController : UITableViewController

@property(nonatomic, strong) NSArray *listArr;
@property(nonatomic, strong) NSMutableArray *urlArr;
@property(nonatomic, strong) NSMutableDictionary *listDic;
@property(nonatomic, strong) NSMutableDictionary *urlDic;

@end

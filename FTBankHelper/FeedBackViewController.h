//
//  FeedBackViewController.h
//  FTBankHelper
//
//  Created by Jermy on 15/11/17.
//  Copyright © 2015年 Jermy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UploadFiles.h"

@interface FeedBackViewController : UIViewController

@property(nonatomic, copy) NSArray *bankList;

@property (strong, nonatomic) IBOutlet UITableView *feedBackTableView;

@end

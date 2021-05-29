//
//  FeedBackTableViewCell4.h
//  FTBankHelper
//
//  Created by Jermy on 15/11/21.
//  Copyright © 2015年 Jermy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FeedBackCell4Delegate <NSObject>

-(void)didSelectedImage;

@end

@interface FeedBackTableViewCell4 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *selImageBtn;

@property (nonatomic, assign)id<FeedBackCell4Delegate> delegate;

@end

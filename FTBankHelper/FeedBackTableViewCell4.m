//
//  FeedBackTableViewCell4.m
//  FTBankHelper
//
//  Created by Jermy on 15/11/21.
//  Copyright © 2015年 Jermy. All rights reserved.
//

#import "FeedBackTableViewCell4.h"
@implementation FeedBackTableViewCell4

//选择图片
- (IBAction)selImageBtnClick:(id)sender {
    
    if([self.delegate respondsToSelector:@selector(didSelectedImage)]){
        [self.delegate didSelectedImage];
    }
}
@end

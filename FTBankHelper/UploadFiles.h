//
//  UploadFiles.h
//  FTBankHelper
//
//  Created by Jermy on 15/12/16.
//  Copyright © 2015年 Jermy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@protocol UploadFilesDelegate <NSObject>

-(void)didFinishUploadFiles;

@end


@interface UploadFiles : NSObject

-(void)submitToServer:(NSString*)phoneNumber feedbackMessage:(NSString*)feedbackMessage imageData:(NSData*)imageData returnCode:(NSInteger*)returnCode;

-(NSData*)encodeBase64String:(NSString * )input ;

-(NSData*)encodeBase64Data:(NSData*)input;

+(BOOL)canOpenUrl;

-(UIView*)showWaitView;

-(UIViewController *)getTopViewController;

@property(nonatomic, assign) id<UploadFilesDelegate> delegate;


@end



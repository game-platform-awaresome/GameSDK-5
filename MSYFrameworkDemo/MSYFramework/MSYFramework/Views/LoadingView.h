//
//  LoadingView.h
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/25.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

+(void)loadingViewWithSuperView:(UIView *)superview AndMessage:(NSString *)msg AndUserType:(NSString *)type;

+(void)loadingSuperViewHide;
+(void)loadingViewHide;

@end

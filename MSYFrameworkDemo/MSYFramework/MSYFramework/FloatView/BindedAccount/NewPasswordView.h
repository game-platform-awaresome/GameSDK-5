//
//  NewPasswordView.h
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/27.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewPasswordView : UIView
@property(nonatomic,copy)NSString *phone_code;

-(void)layoutNewPasswordViewWithSuperView:(UIView *)superView;
@end

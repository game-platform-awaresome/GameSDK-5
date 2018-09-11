//
//  LoginedView.h
//  MSYFramework
//
//  Created by 郭臻 on 2018/4/17.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginedView : UIView
@property(nonatomic,strong)UILabel *accLabel;
@property(nonatomic,copy) NSString *PSW;
@property(nonatomic,copy)NSString *userType;
-(void)layoutLoginedViewWithSuperView:(UIView *)superView;
-(void)otherStyleLogin;

@end

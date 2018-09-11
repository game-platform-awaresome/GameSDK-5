//
//  BindPhoneSuccessView.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/26.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "BindPhoneSuccessView.h"
#import "Masonry.h"
#import "OptionForDevice.h"
@implementation BindPhoneSuccessView

-(void)layoutAccountUpdateWithSuperView:(UIView *)superView AndAccount:(NSString *)phone AndOldAccount:(NSString *)oldAccount{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(superView.mas_width).multipliedBy(0.9);
//        make.height.equalTo(superView.mas_height).multipliedBy(0.4);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
                make.height.equalTo(superView.mas_height).multipliedBy(0.4);
                make.width.equalTo(superView.mas_width).multipliedBy(0.4);
            }else{
                make.height.equalTo(superView.mas_height).multipliedBy(0.35);
                make.width.equalTo(superView.mas_width).multipliedBy(0.5);
            }
            
        }else{
            if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
                if ([[OptionForDevice getDeviceName] isEqualToString:@"iphonex"]) {
                    make.width.equalTo(superView.mas_width).multipliedBy(0.5);
                }else{
                    
                    make.width.equalTo(superView.mas_width).multipliedBy(0.55);
                }
                make.height.equalTo(superView.mas_height).multipliedBy(0.75);
            }else{
                if ([[OptionForDevice getDeviceName] isEqualToString:@"iphonex"]) {
                    make.height.equalTo(superView.mas_height).multipliedBy(0.35);
                }else{
                    make.height.equalTo(superView.mas_height).multipliedBy(0.4);
                }
                make.width.equalTo(superView.mas_width).multipliedBy(0.9);
            }
            
        }
        make.centerY.equalTo(superView.mas_centerY);
        make.centerX.equalTo(superView.mas_centerX);
    }];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = CornerSizeView;
    
    //顶部view
    UIView *topView = [[UIView alloc] init];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height).multipliedBy(0.2);
        make.width.equalTo(self.mas_width);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    //titleLabel
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"账号升级成功";
    titleLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
    [topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(topView.mas_width).multipliedBy(0.5);
        make.height.equalTo(topView.mas_height).multipliedBy(0.8);
        make.centerX.equalTo(topView.mas_centerX);
        make.centerY.equalTo(topView.mas_centerY);
    }];
    
    UIButton *backBtn = [[UIButton alloc] init];
    [backBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/login_close"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.right.equalTo(topView.mas_right).with.offset(-15);
        make.centerY.equalTo(titleLabel.mas_centerY);
    }];
    
    
    //body
    UIView *bodyView = [[UIView alloc] init];
    [self addSubview:bodyView];
    [bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height).multipliedBy(0.375);
        make.width.equalTo(self.mas_width);
        make.top.equalTo(topView.mas_bottom).with.offset(0);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    //contentLabel
    UILabel *contentLable = [[UILabel alloc] init];
    contentLable.numberOfLines = 0;
    contentLable.text = [NSString stringWithFormat:@"您已成功将游客账号 %@ 升级为简单账号 %@ ,以后请您使用 %@ 登录游戏。",oldAccount,phone,phone];
    contentLable.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [bodyView addSubview:contentLable];
    [contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bodyView.mas_left).with.offset(15);
        make.right.equalTo(bodyView.mas_right).with.offset(-15);
        make.height.equalTo(bodyView.mas_height);
        make.top.equalTo(bodyView.mas_top).with.offset(0);
    }];
    //底部view
    UIView *bottomView = [[UIView alloc] init];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.top.equalTo(bodyView.mas_bottom).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    
    //确定按钮
    UIButton *tureBtn = [[UIButton alloc] init];
    [tureBtn setTitle:@"朕知道了" forState:UIControlStateNormal];
    [tureBtn setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1]];
    [tureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tureBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
   
    [bottomView addSubview:tureBtn];
    [tureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height).multipliedBy(0.145);
        make.left.equalTo(bottomView.mas_left).with.offset(10);
        make.right.equalTo(bottomView.mas_right).with.offset(-10);
        make.top.equalTo(bodyView.mas_bottom).with.offset(0);
    }];
    tureBtn.layer.masksToBounds = YES;
    
    [bottomView layoutIfNeeded];
    tureBtn.layer.cornerRadius = tureBtn.frame.size.height/2;
}

-(void)closeView{
    [self.superview removeFromSuperview];
}

@end

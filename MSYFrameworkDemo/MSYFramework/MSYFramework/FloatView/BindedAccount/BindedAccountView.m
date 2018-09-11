//
//  BindedAccountView.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/26.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "BindedAccountView.h"
#import "Masonry.h"
#import "ChangePasswordView.h"
#import "VerifyPhoneView.h"
#import "OptionForDevice.h"
@implementation BindedAccountView

-(void)layoutBindedAccountViewWithSuperView:(UIView *)superView{
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
        make.height.equalTo(self.mas_height).multipliedBy(0.28);
        make.width.equalTo(self.mas_width);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    //titleLabel
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"账号中心";
    titleLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
    [topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(topView.mas_width).multipliedBy(0.5);
        make.height.equalTo(topView.mas_height).multipliedBy(0.8);
        make.centerX.equalTo(topView.mas_centerX);
        make.centerY.equalTo(topView.mas_centerY);
    }];
    
    //返回按钮
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
    
    //bodyView
    UIView *bodyView = [[UIView alloc] init];
    [self addSubview:bodyView];
    [bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height).multipliedBy(0.43);
        make.left.equalTo(self.mas_left).with.offset(25);
        make.right.equalTo(self.mas_right).with.offset(-25);
        make.top.equalTo(topView.mas_bottom).with.offset(0);
    }];
    
    //安全级别label
    UILabel *safelabel = [[UILabel alloc] init];
    safelabel.text = @"账号安全级别：高";
    safelabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    safelabel.font = [UIFont boldSystemFontOfSize:17];
    [bodyView addSubview:safelabel];
    [safelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(200);
        make.left.equalTo(bodyView.mas_left).with.offset(0);
        make.top.equalTo(bodyView.mas_top).with.offset(0);
    }];
    //中部labelview
    UIView *labelView = [[UIView alloc] init];
    [bodyView addSubview:labelView];
    [labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(bodyView.mas_height).multipliedBy(0.4);
        make.width.equalTo(bodyView.mas_width);
        make.left.equalTo(bodyView.mas_left).with.offset(0);
        make.centerY.equalTo(bodyView.mas_centerY);
    }];
    //手机号label
    UILabel *phonelabel = [[UILabel alloc] init];
    NSString *phone = [Username stringByReplacingCharactersInRange:NSMakeRange(3, 6)  withString:@"*******"];
    phonelabel.text = [NSString stringWithFormat:@"您的账号已绑定手机号：%@",phone];
    phonelabel.textColor = [UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1];
    phonelabel.font = [UIFont boldSystemFontOfSize:16];
    [labelView addSubview:phonelabel];
    [phonelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(labelView.mas_width);
        make.top.equalTo(labelView.mas_top).with.offset(0);
        make.left.equalTo(labelView.mas_left).with.offset(0);
    }];
    //提示label
    UILabel *reLabel = [[UILabel alloc] init];
    reLabel.text = @"你可以通过改账号登录或修改密码";
    reLabel.textColor = [UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1];
    reLabel.font = [UIFont boldSystemFontOfSize:16];
    [labelView addSubview:reLabel];
    [reLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(labelView.mas_width);
        make.bottom.equalTo(labelView.mas_bottom).with.offset(0);
        make.left.equalTo(labelView.mas_left).with.offset(0);
    }];
    
    //底部view
    UIView *bottomView = [[UIView alloc] init];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(bodyView.mas_width);
        make.centerX.equalTo(bodyView.mas_centerX);
        make.top.equalTo(bodyView.mas_bottom).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
    }];
    
    //按钮View
    UIView *btnView = [[UIView alloc] init];
    [bottomView addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(bottomView.mas_height).multipliedBy(0.45);
        make.width.equalTo(bottomView.mas_width);
        make.centerX.equalTo(bottomView.mas_centerX);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    
    //修改密码按钮
    UIButton *changePswBtn = [[UIButton alloc] init];
    [changePswBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [changePswBtn setTitleColor:[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1] forState:UIControlStateNormal];
    changePswBtn.layer.borderWidth = 1;
    changePswBtn.layer.borderColor = [[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1] CGColor];
    changePswBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [changePswBtn addTarget:self action:@selector(changePassword) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:changePswBtn];
    [changePswBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(btnView.mas_height);
        make.width.equalTo(btnView.mas_width).multipliedBy(0.45);
        make.left.equalTo(btnView.mas_left).with.offset(0);
        make.top.equalTo(btnView.mas_top).with.offset(0);
    }];
    [btnView layoutIfNeeded];
    changePswBtn.layer.masksToBounds = YES;
    changePswBtn.layer.cornerRadius = changePswBtn.frame.size.height/2;
    //更换绑定手机按钮
    UIButton *bindingBtn = [[UIButton alloc] init];
    [bindingBtn setTitle:@"更换绑定手机" forState:UIControlStateNormal];
    [bindingBtn setTitleColor:[UIColor colorWithRed:110.0f/255.0f green:110.0f/255.0f blue:110.0f/255.0f alpha:1] forState:UIControlStateNormal];
    bindingBtn.layer.borderWidth = 1;
    bindingBtn.layer.borderColor = [[UIColor colorWithRed:110.0f/255.0f green:110.0f/255.0f blue:110.0f/255.0f alpha:1] CGColor];
    bindingBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [bindingBtn addTarget:self action:@selector(bindingPhone) forControlEvents:UIControlEventTouchUpInside];
    [btnView addSubview:bindingBtn];
    [bindingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(btnView.mas_height);
        make.width.equalTo(btnView.mas_width).multipliedBy(0.45);
        make.right.equalTo(btnView.mas_right).with.offset(0);
        make.top.equalTo(btnView.mas_top).with.offset(0);
    }];
    [btnView layoutIfNeeded];
    bindingBtn.layer.masksToBounds = YES;
    bindingBtn.layer.cornerRadius = bindingBtn.frame.size.height/2;
}

#pragma mark - 修改密码
-(void)changePassword{
    ChangePasswordView *view = [[ChangePasswordView alloc] init];
    [self.superview addSubview:view];
    [view layoutChangePasswordViewWithSuperView:self.superview];
}

#pragma mark - 更换绑定手机
-(void)bindingPhone{
    VerifyPhoneView *view = [[VerifyPhoneView alloc] init];
    [self.superview addSubview:view];
    [view layoutVerifyPhoneViewWithSuperView:self.superview];
}

-(void)closeView{
    [self.superview removeFromSuperview];
}

@end

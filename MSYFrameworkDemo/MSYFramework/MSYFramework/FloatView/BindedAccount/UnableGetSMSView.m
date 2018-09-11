//
//  UnableGetSMSView.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/28.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "UnableGetSMSView.h"
#import "Masonry.h"
#import "GetCurrentViewController.h"
#import "OptionForDevice.h"
@implementation UnableGetSMSView

-(void)layoutUnableGetSMSViewWithSuperView:(UIView *)superView{
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
    titleLabel.text = @"无法获取短信？";
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
    [backBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/backp"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backView) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
        make.left.equalTo(topView.mas_left).with.offset(15);
        make.centerY.equalTo(titleLabel.mas_centerY);
    }];
    
    //关闭按钮
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/login_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.right.equalTo(topView.mas_right).with.offset(-15);
        make.centerY.equalTo(titleLabel.mas_centerY);
    }];
    
    //bodyView
    UIView *bodyView = [[UIView alloc] init];
    [self addSubview:bodyView];
    [bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height).multipliedBy(0.45);
        make.left.equalTo(self.mas_left).with.offset(20);
        make.right.equalTo(self.mas_right).with.offset(-20);
        make.top.equalTo(topView.mas_bottom).with.offset(0);
    }];
    
    //labelView
    UIView *labelView = [[UILabel alloc] init];
    [bodyView addSubview:labelView];
    [labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(bodyView.mas_height).multipliedBy(0.65);
        make.width.equalTo(bodyView.mas_width);
        make.top.equalTo(bodyView.mas_top);
        make.centerX.equalTo(bodyView.mas_centerX);
    }];
    
    //上方label
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.text = @"尊敬的玩家，您好";
    topLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    topLabel.font = [UIFont boldSystemFontOfSize:15];
    [topLabel sizeToFit];
    [labelView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(labelView.mas_width);
        make.left.equalTo(labelView.mas_left);
        make.top.equalTo(labelView.mas_top);
    }];
    
    //下方label
    UILabel *bottomLable = [[UILabel alloc] init];
    bottomLable.numberOfLines = 0;
    bottomLable.text = @"如果您无法正常收到短信，为了您的账号安全，请联系客服，提供您近期的登录和充值凭证已申诉更换手机号。";
    bottomLable.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    bottomLable.font = [UIFont boldSystemFontOfSize:15];
    [labelView addSubview:bottomLable];
    [bottomLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(labelView.mas_width);
        make.left.equalTo(labelView.mas_left);
        make.bottom.equalTo(labelView.mas_bottom);
    }];
    
    //底部view
    UIView *bottomView = [[UIView alloc] init];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(bodyView.mas_width);
        make.top.equalTo(bodyView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    //拨打电话按钮
    UIButton *servicePhoneBtn = [[UIButton alloc] init];
    [servicePhoneBtn setTitle:[NSString stringWithFormat:@"客服电话：%@",Phone] forState:UIControlStateNormal];
    [servicePhoneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [servicePhoneBtn setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1]];
    [servicePhoneBtn addTarget:self action:@selector(callservice) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:servicePhoneBtn];
    [servicePhoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(bottomView.mas_width);
        make.height.equalTo(bottomView.mas_height).multipliedBy(0.6);
        make.top.equalTo(bottomView.mas_top);
        make.centerX.equalTo(bottomView.mas_centerX);
    }];
    
    [bottomView layoutIfNeeded];
    servicePhoneBtn.layer.masksToBounds = YES;
    servicePhoneBtn.layer.cornerRadius = servicePhoneBtn.frame.size.height/2;
    
}

-(void)callservice{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *callAction = [UIAlertAction actionWithTitle:Phone style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",Phone];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self addSubview:callWebview];
        
    }];
    [alertController addAction:callAction];
    UIAlertAction *cannelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cannelAction];
    UIViewController *viewController = [GetCurrentViewController getCurrentViewController:self];
    [viewController presentViewController:alertController animated:YES completion:nil];
}

-(void)closeView{
    [self.superview removeFromSuperview];
}

-(void)backView{
    [self removeFromSuperview];
}

@end

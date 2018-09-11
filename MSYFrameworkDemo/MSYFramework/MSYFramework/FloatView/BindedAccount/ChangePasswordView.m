//
//  ChangePasswordView.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/27.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "ChangePasswordView.h"
#import "Masonry.h"
#import "CutdownBuntton.h"
#import "MQVerCodeInputView.h"
#import "NewPasswordView.h"
#import "CheckPhoneNum.h"
#import "UIView+Toast.h"
#import "GZNetwork.h"
#import "GZMd5.h"
#import "GetUserip.h"
#import "GetAppleIFA.h"
#import "ChangeJsonOrString.h"
#import "UIView+Toast.h"
#import "TYProgressHUD.h"
#import "TYUserdefaults.h"
#import "OptionForDevice.h"
static CutdownBuntton *cutdowmBtn;
static NSString *phone_code;
static NSString *sms_code;
@implementation ChangePasswordView

-(void)layoutChangePasswordViewWithSuperView:(UIView *)superView{
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
    titleLabel.text = @"请输入验证码";
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
        make.height.equalTo(self.mas_height).multipliedBy(0.425);
        make.left.equalTo(self.mas_left).with.offset(15);
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.top.equalTo(topView.mas_bottom).with.offset(0);
    }];
    
    //手机号view
    UIView *phoneView = [[UIView alloc] init];
    [bodyView addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(bodyView.mas_height).multipliedBy(0.76);
        make.width.equalTo(bodyView.mas_width);
        make.left.equalTo(bodyView.mas_left).with.offset(0);
        make.top.equalTo(bodyView.mas_top).with.offset(0);
    }];
    
    //手机号label
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = [Username stringByReplacingCharactersInRange:NSMakeRange(3, 6)  withString:@"*******"];
    phoneLabel.textColor = [UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1];
    phoneLabel.font = [UIFont boldSystemFontOfSize:16];
    phoneLabel.textAlignment = NSTextAlignmentRight;
    [phoneView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(phoneView.mas_width).multipliedBy(0.45);
        make.left.equalTo(phoneView.mas_left).with.offset(0);
        make.centerY.equalTo(phoneView.mas_centerY);
    }];
    
    cutdowmBtn = [[CutdownBuntton alloc] init];
    [phoneView addSubview:cutdowmBtn];
    [cutdowmBtn addTarget:self action:@selector(registerNum) forControlEvents:UIControlEventTouchUpInside];
    [cutdowmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(phoneLabel.mas_height).multipliedBy(0.6);
        make.width.equalTo(phoneView.mas_width).multipliedBy(0.35);
        make.centerY.equalTo(phoneLabel.mas_centerY);
        make.left.equalTo(phoneLabel.mas_right).with.offset(10);
    }];
    
    //验证码输入框
    MQVerCodeInputView *inputView = [[MQVerCodeInputView alloc] init];
    
    [bodyView addSubview:inputView];
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(bodyView.mas_width);
        make.height.equalTo(bodyView.mas_height).multipliedBy(0.32);
        make.left.equalTo(bodyView.mas_left).with.offset(0);
        make.bottom.equalTo(bodyView.mas_bottom).with.offset(0);
    }];
    [bodyView layoutIfNeeded];
    inputView.maxLenght = 6;
    
    inputView.keyBoardType = UIKeyboardTypeNumberPad;
    [inputView mq_verCodeViewWithMaxLenght];
    inputView.block = ^(NSString *text){
        NSLog(@"text = %@",text);
        if (text.length == 6) {
            //开始验证
            phone_code = text;
            [self setNewPassword];
        }
    };
    
    //底部view
    UIView *bottomView = [[UIView alloc] init];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.top.equalTo(bodyView.mas_bottom).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    //底部label
    UILabel *bottomLabel = [[UILabel alloc] init];
    bottomLabel.text = @"短信验证通过即可重置密码";
    bottomLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    bottomLabel.font = [UIFont boldSystemFontOfSize:18];
    bottomLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
    [bottomView addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(bottomView.mas_width);
        make.centerX.equalTo(bottomView.mas_centerX);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    
    [self registerNum];
}


#pragma mark - 获取验证码
-(void)registerNum{
    if ([CheckPhoneNum checkTelNumber:[NSString stringWithFormat:@"%@",Username]]) {
        //[self remakeView];
        
        [cutdowmBtn startCutdown];
        NSString *md5 = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@",Username]];
        NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@%@%@",[NSString stringWithFormat:@"%@",Username],@"findpass",@"ios",IMEI]];
        NSString *body = [NSString stringWithFormat:@"mobile=%@&send_code=%@&send_type=%@&type=%@&imei=%@&sign=%@&signtype=%@",[NSString stringWithFormat:@"%@",Username],md5,@"findpass",@"ios",IMEI,sign,signtype];
        NSLog(@"%@",body);
        NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
        [TYProgressHUD showMessage:@"正在获取验证码"];
        [GZNetwork requesetWithData:[NSString stringWithFormat:@"%@%@",UNIFYURL,SendMessageURL] bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
            if (dict != NULL) {
                [TYProgressHUD hide];
                NSLog(@"%@",dict);
                NSDictionary *resultDic = [dict valueForKey:@"result"];
                int code = [[resultDic valueForKey:@"code"] intValue];
                if (code == 200) {
                    sms_code = [NSString stringWithFormat:@"%@",[resultDic valueForKey:@"mobile_code"]];
                }
                MakeToast([resultDic valueForKey:@"msg"]);
            }else{
                [TYProgressHUD hide];
                MakeToast(@"网络不给力");
            }
        }];
    }else{
        MakeToast(@"手机号格式错误！");
    }
}

-(void)setNewPassword{
    
    if ([phone_code isEqualToString:sms_code]) {
        NewPasswordView *view = [[NewPasswordView alloc] init];
        view.phone_code = sms_code;
        [self.superview addSubview:view];
        [view layoutNewPasswordViewWithSuperView:self.superview];
        
    }else{
        MakeToast(@"验证码错误");
    }
    
}

-(void)closeView{
    [self.superview removeFromSuperview];
}

-(void)backView{
    [self removeFromSuperview];
}

@end

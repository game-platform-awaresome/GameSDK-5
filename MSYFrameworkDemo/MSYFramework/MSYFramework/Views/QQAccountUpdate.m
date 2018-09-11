//
//  QQAccountUpdate.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/3/16.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "QQAccountUpdate.h"
#import "Masonry.h"
#import "CutdownBuntton.h"
#import "CheckPhoneNum.h"
#import "GZNetwork.h"
#import "GZMd5.h"
#import "GetUserip.h"
#import "GetAppleIFA.h"
#import "ChangeJsonOrString.h"
#import "UIView+Toast.h"
#import "TYProgressHUD.h"
#import "TYUserdefaults.h"
#import "myBlock.h"
#import "BindPhoneSuccessView.h"
#import "OptionForDevice.h"
static UITextField *phoneTxt;
static UITextField *registerTxt;
static CutdownBuntton *registerBtn;
static NSString *mobileCode;
static NSDictionary *userDic;
@implementation QQAccountUpdate

-(void)layoutQQAccountUpdateWithSuperView:(UIView *)superView{
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
    titleLabel.text = @"绑定手机";
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
    
    //返回按钮
//    UIButton *backBtn = [[UIButton alloc] init];
//    [backBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/login_close"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
//    [topView addSubview:backBtn];
//    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(30);
//        make.height.mas_equalTo(30);
//        make.right.equalTo(topView.mas_right).with.offset(-15);
//        make.centerY.equalTo(titleLabel.mas_centerY);
//    }];
    
    //bodyView
    UIView *bodyView = [[UIView alloc] init];
    [self addSubview:bodyView];
    [bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height).multipliedBy(0.35);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(topView.mas_bottom).with.offset(0);
    }];
    
    //手机号View
    UIView *phoneView = [[UIView alloc] init];
    phoneView.layer.borderWidth = 1;
    phoneView.layer.borderColor = [[UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1] CGColor];
    phoneView.layer.masksToBounds = YES;
    phoneView.layer.cornerRadius = 4;
    [bodyView addSubview:phoneView];
    [phoneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(bodyView.mas_height).multipliedBy(0.45);
        make.width.equalTo(bodyView.mas_width);
        make.top.equalTo(bodyView.mas_top).with.offset(0);
        make.centerX.equalTo(bodyView.mas_centerX);
    }];
    //手机号image
    UIImageView *phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/pop-icon1.jpg"]];
    [phoneView addSubview:phoneImageView];
    [phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(phoneView.mas_height).multipliedBy(0.5);
        make.centerY.equalTo(phoneView.mas_centerY);
        make.left.equalTo(phoneView.mas_left).with.offset(20);
        make.width.equalTo(phoneImageView.mas_height).multipliedBy(0.7);
    }];
    
    
    //手机号输入框
    phoneTxt = [[UITextField alloc] init];
    phoneTxt.borderStyle = UITextBorderStyleNone;
    phoneTxt.placeholder = @"请输入手机号";
    phoneTxt.keyboardType = UIKeyboardTypeNumberPad;
    [phoneView addSubview:phoneTxt];
    [phoneTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(phoneView.mas_height);
        make.left.equalTo(phoneImageView.mas_left).with.offset(40);
        make.right.equalTo(phoneView.mas_right).with.offset(0);
        make.top.equalTo(phoneView.mas_top).with.offset(0);
    }];
    
    //验证码view
    UIView *registerView = [[UIView alloc] init];
    registerView.layer.borderWidth = 1;
    registerView.layer.borderColor = [[UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1] CGColor];
    registerView.layer.masksToBounds = YES;
    registerView.layer.cornerRadius = 4;
    [bodyView addSubview:registerView];
    [registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(bodyView.mas_height).multipliedBy(0.45);
        make.width.equalTo(bodyView.mas_width);
        make.bottom.equalTo(bodyView.mas_bottom).with.offset(0);
        make.centerX.equalTo(bodyView.mas_centerX);
    }];
    
    //验证码image
    UIImageView *registerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/pop-icon2.jpg"]];
    [registerView addSubview:registerImageView];
    [registerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(registerView.mas_height).multipliedBy(0.5);
        make.centerY.equalTo(registerView.mas_centerY);
        make.left.equalTo(registerView.mas_left).with.offset(20);
        make.width.equalTo(registerImageView.mas_height);
    }];
    
    //验证码输入框
    registerTxt = [[UITextField alloc] init];
    registerTxt.borderStyle = UITextBorderStyleNone;
    registerTxt.placeholder = @"请输入验证码";
    registerTxt.keyboardType = UIKeyboardTypeNumberPad;
    [registerView addSubview:registerTxt];
    [registerTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(registerView.mas_height);
        make.left.equalTo(registerImageView.mas_left).with.offset(40);
        make.right.equalTo(registerView.mas_right).with.offset(0);
        make.top.equalTo(registerView.mas_top).with.offset(0);
    }];
    
    //获取验证码按钮
    registerBtn = [[CutdownBuntton alloc] init];
    [registerView addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(registerTxt.mas_height).multipliedBy(0.65);
        make.width.equalTo(registerTxt.mas_width).multipliedBy(0.45);
        make.centerY.equalTo(registerTxt.mas_centerY);
        make.right.equalTo(registerTxt.mas_right).with.offset(-10);
    }];
    
    [registerBtn addTarget:self action:@selector(registerNum) forControlEvents:UIControlEventTouchUpInside];
    
    
    //底部view
    UIView *bottomView = [[UIView alloc] init];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bodyView.mas_bottom).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
    }];
    
    //绑定手机按钮
    UIButton *bindBtn = [[UIButton alloc] init];
    
    [bottomView addSubview:bindBtn];
    [bindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(bottomView.mas_width);
        make.height.equalTo(registerView.mas_height);
        make.centerX.equalTo(bottomView.mas_centerX);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    [bindBtn addTarget:self action:@selector(bindPhone) forControlEvents:UIControlEventTouchUpInside];
    [bindBtn setTitle:@"绑定手机" forState:UIControlStateNormal];
    [bindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bindBtn setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1]];
    bindBtn.layer.masksToBounds = YES;
    [bottomView layoutIfNeeded];
    bindBtn.layer.cornerRadius = bindBtn.frame.size.height/2;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = CornerSizeView;
}

#pragma mark - 获取验证码
-(void)registerNum{
    if ([CheckPhoneNum checkTelNumber:phoneTxt.text]) {
        
        [self endEditing:YES];
        [registerBtn startCutdown];
        NSString *md5 = [GZMd5 md5_32bit:phoneTxt.text];
        NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@%@%@",phoneTxt.text,@"register",@"ios",IMEI]];
        NSString *body = [NSString stringWithFormat:@"mobile=%@&send_code=%@&send_type=%@&type=%@&imei=%@&sign=%@&signtype=%@",phoneTxt.text,md5,@"bindphone",@"ios",IMEI,sign,signtype];
        NSLog(@"%@",body);
        NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
        [TYProgressHUD showMessage:@"正在获取验证码"];
        [GZNetwork requesetWithData:[NSString stringWithFormat:@"%@%@",UNIFYURL,SendMessageURL] bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
            if (dict != NULL) {
                [TYProgressHUD hide];
                NSLog(@"%@",dict);
                NSDictionary *resultDic = [dict valueForKey:@"result"];
                int code = [[resultDic valueForKey:@"code"] intValue];
                NSLog(@"%@",[resultDic valueForKey:@"msg"]);
                if (code == 200) {
                    mobileCode = [NSString stringWithFormat:@"%@",[resultDic valueForKey:@"mobile_code"]];
                    MakeToast([resultDic valueForKey:@"msg"]);
                    
                }else{
                    MakeToast(@"发送失败");
                }
                
                
            }else{
                [TYProgressHUD hide];
                MakeToast(@"网络不给力");
            }
        }];
    }else{
        MakeToast(@"手机号格式错误！");
    }
}

#pragma mark - 绑定手机
-(void)bindPhone{
    [self endEditing:YES];
    
    NSString *body = [NSString stringWithFormat:@"mobile=%@&userid=%@&mobile_code=%@&usertoken=%@",phoneTxt.text,_userid,mobileCode,TOKEN];
    NSLog(@"%@",body);
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,BindPhoneURL];
    MakeTA;
    [GZNetwork requesetWithData:url bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
        HideTA;
        if (dict != NULL) {
            
            
            NSDictionary *resultDic = [dict valueForKey:@"result"];
            NSLog(@"%@",resultDic);
            int code = [[resultDic valueForKey:@"code"] intValue];
            if (code == 200) {
                
                [self login];
            }else{
                MakeToast([resultDic valueForKey:@"msg"]);
            }
            
        }else{
            MakeToast(@"网络不给力");
        }
    }];
    
}

-(void)login{
    [TYProgressHUD showMessage:@"正在登录，请稍等"];
    NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@%@%@",phoneTxt.text,registerTxt.text,APPID,TOKEN]];
    NSString *body = [NSString stringWithFormat:@"username=%@&password=%@&appid=%@&token=%@&channel=%@&type=%@&imei=%@&sign=%@&signtype=%@",phoneTxt.text,registerTxt.text,APPID,TOKEN,@"304,01",@"ios",IMEI,sign,signtype];
    NSLog(@"%@",body);
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,LoginURL];
    [GZNetwork requesetWithData:url bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
        [TYProgressHUD hide];
        if (dict != NULL) {
            
            NSLog(@"%@",dict);
            NSDictionary *resultDic = [dict valueForKey:@"result"];
            int code = [[resultDic valueForKey:@"code"] intValue];
            if (code == 200) {
                
                NSString *result = [ChangeJsonOrString DataTOjsonString:resultDic];
                if ([[resultDic valueForKey:@"isphone"] intValue] == 1) {
                    [TYUserdefaults setUserMsgForArr:result];
                    [TYUserdefaults setFirstUserMsgForArr:result];
                    [myBlock loginWith:[NSString stringWithFormat:@"%@",[resultDic valueForKey:@"username"]] Anduserid:[NSString stringWithFormat:@"%@",[resultDic valueForKey:@"userid"]] And:[NSString stringWithFormat:@"%@",[resultDic valueForKey:@"token"]]];
                    
                    [self.superview removeFromSuperview];
                }
                
            }
            
        }else{
            MakeToast(@"网络不给力");
            
        }
    }];
}

@end

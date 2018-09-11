//
//  RegisterAccountView.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/3.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "RegisterAccountView.h"
#import "Masonry.h"
#import "CutdownBuntton.h"
#import "GZNetwork.h"
#import "GZMd5.h"
#import "CheckPhoneNum.h"
#import "GetUserip.h"
#import "GetAppleIFA.h"
#import "ChangeJsonOrString.h"
#import "UIView+Toast.h"
#import "TYProgressHUD.h"
#import "TYUserdefaults.h"
#import "myBlock.h"
#import "TermView.h"
#import "OptionForDevice.h"
static UIView *registerView;
static UITextField *accountTxt;
static UITextField *registerTxt;
static UITextField *passwordTxt;
static CutdownBuntton *registerBtn;
static UIButton *LoginBtn;
static UIButton *agreeBtn;
@implementation RegisterAccountView

-(void)layoutFindPasswordViewWithSuperView:(UIView *)superView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapEndEdit)];
    [self addGestureRecognizer:tap];
    //    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    //        //如果设备是ipad
    //
    //
    //
    //    }else{
    //如果设备是iPhone
    /**
     *总体大小
     */
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
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
                make.height.equalTo(superView.mas_height).multipliedBy(0.9);
            }else{
                if ([[OptionForDevice getDeviceName] isEqualToString:@"iphonex"]) {
                    make.height.equalTo(superView.mas_height).multipliedBy(0.45);
                }else{
                    make.height.equalTo(superView.mas_height).multipliedBy(0.6);
                }
                make.width.equalTo(superView.mas_width).multipliedBy(0.9);
            }
            
            
        }
        //            make.height.equalTo(superView.mas_height).multipliedBy(0.6);
        //            make.width.equalTo(superView.mas_width).multipliedBy(0.9);
        make.centerY.equalTo(superView.mas_centerY);
        make.centerX.equalTo(superView.mas_centerX);
    }];
    /**
     *顶部View
     */
    UIView *topView = [[UIView alloc] init];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height).multipliedBy(0.17);
        make.width.equalTo(self.mas_width);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.top.equalTo(self.mas_top).with.offset(0);
    }];
    //顶部title
    UILabel *titleLabel = [[UILabel alloc] init];
    [topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(topView.mas_height);
        make.width.equalTo(topView.mas_width);
        make.left.equalTo(topView.mas_left).with.offset(0);
        make.top.equalTo(topView.mas_top).with.offset(0);
    }];
    titleLabel.text = @"注册账号";
    titleLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    titleLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
    titleLabel.font = [UIFont systemFontOfSize:20];
    
    /**
     *中部body
     */
    UIView *bodyView = [[UIView alloc] init];
    [self addSubview:bodyView];
    [bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height).multipliedBy(0.638);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.top.equalTo(topView.mas_bottom).with.offset(0);
    }];
    //输入框view
    UIView *txtView = [[UIView alloc] init];
    [bodyView addSubview:txtView];
    [txtView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(bodyView.mas_height).multipliedBy(0.638);
        make.left.equalTo(bodyView.mas_left).with.offset(10);
        make.right.equalTo(bodyView.mas_right).with.offset(-10);
        make.top.equalTo(bodyView.mas_top).with.offset(0);
    }];
    
    
    //手机号输入框View
    UIView *phoneTxtView = [[UIView alloc] init];
    [txtView addSubview:phoneTxtView];
    [phoneTxtView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(txtView.mas_width);
        make.height.equalTo(txtView.mas_height).multipliedBy(0.28);
        make.left.equalTo(txtView.mas_left).with.offset(0);
        make.top.equalTo(txtView.mas_top).with.offset(0);
    }];
    phoneTxtView.layer.borderWidth = 1;
    phoneTxtView.layer.borderColor = [[UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1] CGColor];
    phoneTxtView.layer.masksToBounds = YES;
    phoneTxtView.layer.cornerRadius = 4;
    
    //手机号输入框image
    UIImageView *phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/pop-icon3.jpg"]];
    [phoneTxtView addSubview:phoneImageView];
    [phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(phoneTxtView.mas_height).multipliedBy(0.35);
        make.centerY.equalTo(phoneTxtView.mas_centerY);
        make.left.equalTo(phoneTxtView.mas_left).with.offset(20);
        make.width.equalTo(phoneImageView.mas_height).multipliedBy(1.5);
    }];
    //手机号输入框
    accountTxt = [[UITextField alloc] init];
    [phoneTxtView addSubview:accountTxt];
    [accountTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(phoneTxtView.mas_height);
        make.left.equalTo(phoneImageView.mas_left).with.offset(30);
        make.right.equalTo(phoneTxtView.mas_right).with.offset(0);
        make.top.equalTo(phoneTxtView.mas_top).with.offset(0);
    }];
    accountTxt.placeholder = @"请输入手机号";
    
    //验证码输入栏View
    registerView = [[UIView alloc] init];
    [txtView addSubview:registerView];
    [registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(txtView.mas_left).with.offset(0);
        make.right.equalTo(txtView.mas_right).with.offset(0);
        make.height.equalTo(phoneTxtView.mas_height);
        make.centerY.equalTo(txtView.mas_centerY);
    }];
    registerView.layer.borderWidth = 1;
    registerView.layer.borderColor = [[UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1] CGColor];
    registerView.layer.masksToBounds = YES;
    registerView.layer.cornerRadius = 4;
    //验证码输入栏image
    UIImageView *registerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/pop-icon2.jpg"]];
    [registerView addSubview:registerImageView];
    [registerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(registerView.mas_height).multipliedBy(0.5);
        make.centerY.equalTo(registerView.mas_centerY);
        make.left.equalTo(registerView.mas_left).with.offset(20);
        make.width.equalTo(registerImageView.mas_height);
    }];
    //验证码输入栏
    registerTxt = [[UITextField alloc] init];
    [registerView addSubview:registerTxt];
    [registerTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(registerView.mas_height);
        make.left.equalTo(registerImageView.mas_left).with.offset(30);
        make.right.equalTo(registerView.mas_right).with.offset(0);
        make.top.equalTo(registerView.mas_top).with.offset(0);
    }];
    registerTxt.borderStyle = UITextBorderStyleNone;
    registerTxt.placeholder = @"请输入验证码";
    
    //获取验证码按钮
    registerBtn = [[CutdownBuntton alloc] init];
    [registerView addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(registerTxt.mas_height).multipliedBy(0.65);
        if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
            make.width.equalTo(registerTxt.mas_width).multipliedBy(0.4);
        }else{
            make.width.equalTo(registerTxt.mas_width).multipliedBy(0.45);
        }
        make.centerY.equalTo(registerTxt.mas_centerY);
        make.right.equalTo(registerTxt.mas_right).with.offset(-10);
    }];
    
    [registerBtn addTarget:self action:@selector(registerNum) forControlEvents:UIControlEventTouchUpInside];
    /**
     *密码输入栏view
     */
    UIView *passWordView = [[UIView alloc] init];
    [txtView addSubview:passWordView];
    [passWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(txtView.mas_left).with.offset(0);
        make.right.equalTo(txtView.mas_right).with.offset(0);
        make.height.equalTo(registerView.mas_height);
        make.bottom.equalTo(txtView.mas_bottom).with.offset(0);
    }];
    passWordView.layer.borderWidth = 1;
    passWordView.layer.borderColor = [[UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1] CGColor];
    passWordView.layer.masksToBounds = YES;
    passWordView.layer.cornerRadius = 4;
    //密码输入栏image
    UIImageView *passwordImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/pop-icon4.jpg"]];
    [passWordView addSubview:passwordImageView];
    [passwordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(passWordView.mas_height).multipliedBy(0.5);
        make.centerY.equalTo(passWordView.mas_centerY);
        make.left.equalTo(passWordView.mas_left).with.offset(20);
        make.width.equalTo(passwordImageView.mas_height);
    }];
    //密码输入栏
    passwordTxt = [[UITextField alloc] init];
    [passWordView addSubview:passwordTxt];
    [passwordTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(passWordView.mas_height);
        make.left.equalTo(passwordImageView.mas_left).with.offset(30);
        make.right.equalTo(passWordView.mas_right).with.offset(0);
        make.top.equalTo(passWordView.mas_top).with.offset(0);
    }];
    passwordTxt.placeholder = @"请输入新密码";
    
    //按钮View
    UIView *btnView = [[UIView alloc] init];
    [bodyView addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(txtView.mas_width);
        make.centerX.equalTo(txtView.mas_centerX);
        make.top.equalTo(txtView.mas_bottom).with.offset(0);
        make.bottom.equalTo(bodyView.mas_bottom).with.offset(0);
    }];
    
    //修改按钮
    LoginBtn = [[UIButton alloc] init];
    [btnView addSubview:LoginBtn];
    [LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(registerView.mas_width);
        make.height.equalTo(registerView.mas_height);
        make.centerX.equalTo(registerView.mas_centerX);
        make.centerY.equalTo(btnView.mas_centerY);
        
    }];
    [LoginBtn setTitle:@"一键注册" forState:UIControlStateNormal];
    [LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [LoginBtn setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1]];
    LoginBtn.layer.masksToBounds = YES;
    LoginBtn.layer.cornerRadius = 4;
    [LoginBtn addTarget:self action:@selector(registerAccount) forControlEvents:UIControlEventTouchUpInside];
    
    //同意按钮
    agreeBtn = [[UIButton alloc] init];
    [btnView addSubview:agreeBtn];
    [agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        make.left.equalTo(btnView.mas_left).with.offset(0);
        make.bottom.equalTo(btnView.mas_bottom).with.offset(5);
    }];
    agreeBtn.selected = YES;
    [agreeBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/agree"] forState:UIControlStateSelected];
    [agreeBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/disagree"] forState:UIControlStateNormal];
    [agreeBtn addTarget:self action:@selector(agreeDelegate) forControlEvents:UIControlEventTouchUpInside];
    //左边label
    UILabel *leftLabel = [[UILabel alloc] init];
    [btnView addSubview:leftLabel];
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(btnView.mas_width).multipliedBy(0.34);
        make.left.equalTo(agreeBtn.mas_right).with.offset(5);
        make.centerY.equalTo(agreeBtn.mas_centerY);
    }];
    leftLabel.text = @"我已阅读并同意";
    if ([[OptionForDevice getDeviceName] isEqualToString:@"iphone5"]) {
        leftLabel.font = [UIFont systemFontOfSize:12];
    }else{
        leftLabel.font = [UIFont systemFontOfSize:15];
    }
    leftLabel.textColor = [UIColor colorWithRed:138.0f/255.0f green:138.0f/255.0f blue:138.0f/255.0f alpha:1];
    //服务协议按钮
    UIButton *delegateBtn = [[UIButton alloc] init];
    [btnView addSubview:delegateBtn];
    [delegateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(btnView.mas_width).multipliedBy(0.65);
        make.left.equalTo(leftLabel.mas_right).with.offset(0);
        make.centerY.equalTo(leftLabel.mas_centerY);
    }];
    [delegateBtn setTitle:@"《简单游戏用户服务协议》" forState:UIControlStateNormal];
    [delegateBtn setTitleColor:[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1] forState:UIControlStateNormal];
    delegateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    if ([[OptionForDevice getDeviceName] isEqualToString:@"iphone5"]) {
        delegateBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    }else{
        delegateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    delegateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [delegateBtn addTarget:self action:@selector(OpenTerm) forControlEvents:UIControlEventTouchUpInside];
    
    //返回登录按钮
    UIButton *backBtn = [[UIButton alloc] init];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(btnView.mas_width).multipliedBy(0.5);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(bodyView.mas_bottom).with.offset(20);
    }];
    [backBtn setTitle:@"返回登录" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor colorWithRed:174.0f/255.0f green:174.0f/255.0f blue:174.0f/255.0f alpha:1] forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:19];
    [backBtn addTarget:self action:@selector(backAccountView) forControlEvents:UIControlEventTouchUpInside];
    //}
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = CornerSizeView;
}

-(void)agreeDelegate{
    agreeBtn.selected = !agreeBtn.selected;
    if (agreeBtn.selected) {
        LoginBtn.enabled = YES;
        [LoginBtn setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1]];
        
    }else{
        LoginBtn.enabled = NO;
        [LoginBtn setBackgroundColor:[UIColor grayColor]];
    }
}

#pragma mark 获取验证码
-(void)registerNum{
    [self viewTapEndEdit];
    if ([CheckPhoneNum checkTelNumber:accountTxt.text]) {
        
        NSString *md5 = [GZMd5 md5_32bit:accountTxt.text];
        NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@%@%@",accountTxt.text,@"register",@"ios",IMEI]];
        NSString *body = [NSString stringWithFormat:@"mobile=%@&send_code=%@&send_type=%@&type=%@&imei=%@&sign=%@&signtype=%@",accountTxt.text,md5,@"register",@"ios",IMEI,sign,signtype];
        NSLog(@"%@",body);
        NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
        [TYProgressHUD showMessage:@"正在获取验证码"];
        [GZNetwork requesetWithData:[NSString stringWithFormat:@"%@%@",UNIFYURL,SendMessageURL] bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
            if (dict != NULL) {
                [TYProgressHUD hide];
                NSLog(@"%@",dict);
                int code = [[dict valueForKey:@"code"] intValue];
                if (code == 200) {
                    [registerBtn startCutdown];
                }
                NSDictionary *resultDic = [dict valueForKey:@"result"];
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

#pragma mark - 一键注册
-(void)registerAccount{
    [self viewTapEndEdit];
    if (accountTxt.text.length == 0 & registerTxt.text.length == 0 & passwordTxt.text.length == 0) {
        MakeToast(@"手机号验证码密码不能为空");
    }else if (accountTxt.text.length != 0 & registerTxt.text.length == 0 & passwordTxt.text.length == 0){
        MakeToast(@"验证码密码不能为空");
    }else if (accountTxt.text.length != 0 & registerTxt.text.length != 0 & passwordTxt.text.length == 0){
        MakeToast(@"密码不能为空");
    }else if (accountTxt.text.length != 0 & registerTxt.text.length == 0 & passwordTxt.text.length != 0){
        MakeToast(@"验证码不能为空");
    }else if (accountTxt.text.length == 0 & registerTxt.text.length != 0 & passwordTxt.text.length == 0){
        MakeToast(@"手机号密码不能为空");
    }else if (accountTxt.text.length == 0 & registerTxt.text.length != 0 & passwordTxt.text.length != 0){
        MakeToast(@"手机号不能为空");
    }else if (accountTxt.text.length == 0 & registerTxt.text.length == 0 & passwordTxt.text.length != 0){
        MakeToast(@"手机号验证码不能为空");
    }else{
        [TYProgressHUD showMessage:@"正在注册"];
        NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@%@%@",accountTxt.text,passwordTxt.text,APPID,TOKEN]];
        NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,PhoneRegisterURL];
        NSString *body = [NSString stringWithFormat:@"username=%@&mobile_code=%@&password=%@&appid=%@&token=%@&channel=%@&type=%@&imei=%@&sign=%@&signtype=%@",accountTxt.text,registerTxt.text,passwordTxt.text,APPID,TOKEN,@"304,01",@"ios",IMEI,sign,signtype];
        NSLog(@"%@",body);
        NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
        [GZNetwork requesetWithData:url bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
            if (dict != NULL) {
                [TYProgressHUD hide];
                NSLog(@"%@",dict);
                NSDictionary *resultDic = [dict valueForKey:@"result"];
                
                int code = [[resultDic valueForKey:@"code"] intValue];
                if (code == 200) {
                    [self login];
                }else{
                    MakeToast([resultDic valueForKey:@"msg"]);
                }
            }else{
                [TYProgressHUD hide];
                MakeToast(@"网络不给力");
            }
        }];
        
        
        
    }
}


-(void)login{
    [TYProgressHUD showMessage:@"正在登录，请稍等"];
    NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@%@%@",accountTxt.text,passwordTxt.text,APPID,TOKEN]];
    NSString *body = [NSString stringWithFormat:@"username=%@&password=%@&appid=%@&token=%@&channel=%@&type=%@&imei=%@&sign=%@&signtype=%@",accountTxt.text,passwordTxt.text,APPID,TOKEN,@"304,01",@"ios",IMEI,sign,signtype];
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,LoginURL];
    [GZNetwork requesetWithData:url bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
        if (dict != NULL) {
            [TYProgressHUD hide];
            NSLog(@"%@",dict);
            NSDictionary *resultDic = [dict valueForKey:@"result"];
            int code = [[resultDic valueForKey:@"code"] intValue];
            if (code == 200) {
                
                NSString *userMessage = [ChangeJsonOrString DataTOjsonString:resultDic];
                [TYUserdefaults setUserMsgForArr:userMessage];
                [TYUserdefaults setFirstUserMsgForArr:userMessage];
                [myBlock loginWith:[NSString stringWithFormat:@"%@",[resultDic valueForKey:@"username"]] Anduserid:[NSString stringWithFormat:@"%@",[resultDic valueForKey:@"userid"]] And:[NSString stringWithFormat:@"%@",[resultDic valueForKey:@"token"]]];
                [self.superview removeFromSuperview];
            }
            
        }else{
            MakeToast(@"网络不给力");
            [TYProgressHUD hide];
        }
    }];
}

#pragma mark - 打开服务协议
-(void)OpenTerm{
    TermView *view = [[TermView alloc] init];
    [self.superview addSubview:view];
    [view layoutTermViewWithSuperView:self.superview];
    
}

#pragma mark - 返回登录界面
-(void)backAccountView{
    [self removeFromSuperview];
}

-(void)viewTapEndEdit{
    [self endEditing:YES];
}

@end


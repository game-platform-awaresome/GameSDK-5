//
//  FindPasswordView.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/2.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "FindPasswordView.h"
#import "Masonry.h"
#import "CutdownBuntton.h"
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
#import "myBlock.h"
#import "QQLoginView.h"
#import "OptionForDevice.h"
static NSMutableArray *switchArr;
static UIView *registerView;
static UITextField *accountTxt;
static UITextField *registerTxt;
static CutdownBuntton *registerBtn;
static UITextField *passwordTxt;
@implementation FindPasswordView

-(void)layoutFindPasswordViewWithSuperView:(UIView *)superView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapEndEdit)];
    [self addGestureRecognizer:tap];
    switchArr = [NSMutableArray array];
    NSDictionary *switchDic = @{@"qq":@"1",@"weixin":@"0"};
    for (NSString *str in switchDic) {
        if ([[switchDic valueForKey:str] isEqualToString:@"1"]) {
            [switchArr addObject:str];
        }
    }
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
                    make.height.equalTo(superView.mas_height).multipliedBy(0.95);
                    
                }else{
                    if ([[OptionForDevice getDeviceName] isEqualToString:@"iphonex"]) {
                        make.height.equalTo(superView.mas_height).multipliedBy(0.47);
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
        titleLabel.text = @"找回密码";
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
            make.height.equalTo(self.mas_height).multipliedBy(0.64);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.top.equalTo(topView.mas_bottom).with.offset(0);
        }];
        //输入框view
        UIView *txtView = [[UIView alloc] init];
        [bodyView addSubview:txtView];
        [txtView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(bodyView.mas_height).multipliedBy(0.58);
            make.left.equalTo(bodyView.mas_left).with.offset(10);
            make.right.equalTo(bodyView.mas_right).with.offset(-10);
            make.top.equalTo(bodyView.mas_top).with.offset(0);
        }];
        //Account输入框View
        UIView *accountTxtView = [[UIView alloc] init];
        [txtView addSubview:accountTxtView];
        [accountTxtView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(txtView.mas_width);
            make.height.equalTo(txtView.mas_height).multipliedBy(0.28);
            make.left.equalTo(txtView.mas_left).with.offset(0);
            make.top.equalTo(txtView.mas_top).with.offset(0);
        }];
        accountTxtView.layer.borderWidth = 1;
        accountTxtView.layer.borderColor = [[UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1] CGColor];
        accountTxtView.layer.masksToBounds = YES;
        accountTxtView.layer.cornerRadius = 4;
        //Account输入框image
        UIImageView *accountImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/pop-icon3.jpg"]];
        [accountTxtView addSubview:accountImageView];
        [accountImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(accountTxtView.mas_height).multipliedBy(0.35);
            make.centerY.equalTo(accountTxtView.mas_centerY);
            make.left.equalTo(accountTxtView.mas_left).with.offset(20);
            make.width.equalTo(accountImageView.mas_height).multipliedBy(1.5);
        }];
        //Account输入框
        accountTxt = [[UITextField alloc] init];
        [accountTxtView addSubview:accountTxt];
        [accountTxt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(accountTxtView.mas_height);
            make.left.equalTo(accountImageView.mas_left).with.offset(30);
            make.right.equalTo(accountTxtView.mas_right).with.offset(0);
            make.top.equalTo(accountTxtView.mas_top).with.offset(0);
        }];
        accountTxt.placeholder = @"请输入用户名/手机号";
        //验证码输入栏View
        registerView = [[UIView alloc] init];
        [txtView addSubview:registerView];
        [registerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(txtView.mas_left).with.offset(0);
            make.right.equalTo(txtView.mas_right).with.offset(0);
            make.height.equalTo(accountTxtView.mas_height);
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
    passwordTxt.secureTextEntry = YES;
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
        UIButton *LoginBtn = [[UIButton alloc] init];
        [bodyView addSubview:LoginBtn];
        [LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(registerView.mas_width);
            make.height.equalTo(registerView.mas_height);
            make.centerX.equalTo(registerView.mas_centerX);
            make.centerY.equalTo(btnView.mas_centerY).with.offset(-10);
            
        }];
        [LoginBtn setTitle:@"修 改" forState:UIControlStateNormal];
        [LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [LoginBtn setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1]];
        LoginBtn.layer.masksToBounds = YES;
        LoginBtn.layer.cornerRadius = 4;
    [LoginBtn addTarget:self action:@selector(changePassword) forControlEvents:UIControlEventTouchUpInside];
        
        //返回登录按钮
        UIButton *backLoginBtn = [[UIButton alloc] init];
        [btnView addSubview:backLoginBtn];
        [backLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(btnView.mas_width).multipliedBy(0.3);
            make.height.equalTo(LoginBtn.mas_height).multipliedBy(0.3);
            make.left.equalTo(btnView.mas_left).with.offset(0);
            make.bottom.equalTo(btnView.mas_bottom).with.offset(-10);
        }];
        [backLoginBtn setTitle:@"返回登录" forState:UIControlStateNormal];
        [backLoginBtn setTitleColor:[UIColor colorWithRed:67.0f/255.0f green:111.0f/255.0f blue:177.0f/255.0f alpha:1] forState:UIControlStateNormal];
        backLoginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        backLoginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backLoginBtn addTarget:self action:@selector(backAccountLoginView) forControlEvents:UIControlEventTouchUpInside];
        /**
         *底部View
         */
        UIView *bottomView = [[UIView alloc] init];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(btnView.mas_width);
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(bodyView.mas_bottom).with.offset(0);
            make.bottom.equalTo(self.mas_bottom).with.offset(0);
        }];
        //底部上方Label的View
        UIView *labelView = [[UIView alloc] init];
        [bottomView addSubview:labelView];
        [labelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(bottomView.mas_left).with.offset(0);
            make.right.equalTo(bottomView.mas_right).with.offset(0);
            make.height.equalTo(bottomView.mas_height).multipliedBy(0.3);
            make.top.equalTo(bottomView.mas_top).with.offset(0);
            
        }];
        //"快捷登录"label
        UILabel *shortCutLabel = [[UILabel alloc] init];
        [labelView addSubview:shortCutLabel];
        [shortCutLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(labelView.mas_width).multipliedBy(0.25);
            make.height.equalTo(labelView.mas_height);
            make.centerX.equalTo(labelView.mas_centerX);
            make.top.equalTo(labelView.mas_top).with.offset(0);
        }];
        shortCutLabel.text = @"快捷登录";
        shortCutLabel.textColor = [UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1];
        shortCutLabel.font = [UIFont systemFontOfSize:15];
    shortCutLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
        //两条横线
        UILabel *leftLabel = [[UILabel alloc] init];
        [labelView addSubview:leftLabel];
        [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1);
            make.left.equalTo(labelView.mas_left).with.offset(0);
            make.right.equalTo(shortCutLabel.mas_left).with.offset(-5);
            make.centerY.equalTo(shortCutLabel.mas_centerY);
        }];
        leftLabel.backgroundColor = [UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1];
        UILabel *rightLabel = [[UILabel alloc] init];
        [labelView addSubview:rightLabel];
        [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@1);
            make.left.equalTo(shortCutLabel.mas_right).with.offset(5);
            make.right.equalTo(labelView.mas_right).with.offset(0);
            make.centerY.equalTo(shortCutLabel.mas_centerY);
        }];
        rightLabel.backgroundColor = [UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1];
        
    
    //包含底部登录按钮view
    UIView *conView = [[UIView alloc] init];
    [bottomView addSubview:conView];
    [conView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(labelView.mas_width).multipliedBy(0.8);
        make.top.equalTo(labelView.mas_bottom).with.offset(0);
        make.bottom.equalTo(bottomView.mas_bottom).with.offset(0);
        make.centerX.equalTo(bottomView.mas_centerX);
    }];
    //快捷登录按钮View
    UIView *shortCutBtnView = [[UIView alloc] init];
    [conView addSubview:shortCutBtnView];
    [shortCutBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (switchArr.count > 1) {
            make.width.equalTo(conView.mas_width);
        }else{
            make.width.equalTo(conView.mas_width).multipliedBy(0.43);
        }
        make.height.equalTo(bottomView.mas_height).multipliedBy(0.45);
        make.centerY.equalTo(conView.mas_centerY).with.offset(-5);
        make.centerX.equalTo(conView.mas_centerX);
    }];
    
    for (int i = 0; i < switchArr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [shortCutBtnView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(shortCutBtnView.mas_width);
            make.height.equalTo(shortCutBtnView.mas_height);
            if (i == 0) {
                make.left.equalTo(shortCutBtnView.mas_left).with.offset(0);
            }else{
                make.right.equalTo(shortCutBtnView.mas_right).with.offset(0);
            }
            make.centerY.equalTo(shortCutBtnView.mas_centerY);
        }];
        if ([switchArr[i] isEqualToString:@"qq"]) {
            [btn setImage:[UIImage imageNamed:@"MSYBundle.bundle/login_qq"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(qqLogin) forControlEvents:UIControlEventTouchUpInside];
        }else if ([switchArr[i] isEqualToString:@"weixin"]){
            [btn setImage:[UIImage imageNamed:@"MSYBundle.bundle/login_wx"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(weixinLogin) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = CornerSizeView;
}

#pragma mark - 获取验证码
-(void)registerNum{
    if ([CheckPhoneNum checkTelNumber:accountTxt.text]) {
        //[self remakeView];
        [self viewTapEndEdit];
        [registerBtn startCutdown];
        NSString *md5 = [GZMd5 md5_32bit:accountTxt.text];
        NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@%@%@",accountTxt.text,@"findpass",@"ios",IMEI]];
        NSString *body = [NSString stringWithFormat:@"mobile=%@&send_code=%@&send_type=%@&type=%@&imei=%@&sign=%@&signtype=%@",accountTxt.text,md5,@"findpass",@"ios",IMEI,sign,signtype];
        NSLog(@"%@",body);
        NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
        [TYProgressHUD showMessage:@"正在获取验证码"];
        [GZNetwork requesetWithData:[NSString stringWithFormat:@"%@%@",UNIFYURL,SendMessageURL] bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
            if (dict != NULL) {
                [TYProgressHUD hide];
                NSLog(@"%@",dict);
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

#pragma mark - 修改密码并登录
-(void)changePassword{
    [self viewTapEndEdit];
    [TYProgressHUD showMessage:@"请稍等"];
    NSString *body = [NSString stringWithFormat:@"mobile=%@&password=%@&mobile_code=%@",accountTxt.text,passwordTxt.text,registerTxt.text];
    
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,FindPassWordURL];
    [GZNetwork requesetWithData:url bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
        [TYProgressHUD hide];
        if (dict != NULL) {
            NSDictionary *resultDic = [dict valueForKey:@"result"];
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

//登录
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
            }else{
                MakeToast([resultDic valueForKey:@"msg"]);
            }
            
        }else{
            MakeToast(@"网络不给力");
            [TYProgressHUD hide];
        }
    }];
}

#pragma mark - QQ登录
-(void)qqLogin{
    QQLoginView *view = [[QQLoginView alloc] init];
    
    [self.superview addSubview:view];
    [view layoutQQLoginViewWithSuperView:view.superview];
}

#pragma mark - 返回登录界面
-(void)backAccountLoginView{
    [self removeFromSuperview];
}

-(void)viewTapEndEdit{
    [self endEditing:YES];
}

@end

//
//  PhoneLoginView.m
//  MSYFramework
//
//  Created by 郭臻 on 2017/12/28.
//  Copyright © 2017年 郭臻. All rights reserved.
//

#import "PhoneLoginView.h"
#import "Masonry.h"
#import "AccountLoginView.h"
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
#import "OptionForDevice.h"
static UIView *SView;
static UIView *topView;
static UIView *BodyView;
static UIView *bottomView;
static UIView *phoneTxtView;
static UIView *TxtView;
static UIView *registerView;
static CutdownBuntton *registerBtn;
static UITextField *registerTxt;
static UITextField *phoneTxt;
static UITextField *passwordTxt;
static int isReg;
@implementation PhoneLoginView

-(void)layoutPhoneViewWithSuperView:(UIView *)superView{
    SView = superView;
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
                    make.height.equalTo(superView.mas_height).multipliedBy(0.75);
                }else{
                    if ([[OptionForDevice getDeviceName] isEqualToString:@"iphonex"]) {
                        make.height.equalTo(superView.mas_height).multipliedBy(0.37);
                    }else{
                        make.height.equalTo(superView.mas_height).multipliedBy(0.4);
                    }
                    make.width.equalTo(superView.mas_width).multipliedBy(0.9);
                }
                
                
            }

            make.centerX.equalTo(superView.mas_centerX);
            make.centerY.equalTo(superView.mas_centerY);
        }];
        /**
         *顶部View
         */
        topView = [[UIView alloc] init];
        [self addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.mas_height).multipliedBy(0.21);
            make.width.equalTo(self.mas_width);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.top.equalTo(self.mas_top).with.offset(0);
        }];
        //顶部Label
        UILabel *TitleLabel = [[UILabel alloc] init];
        [topView addSubview:TitleLabel];
        [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(topView.mas_width);
            make.height.equalTo(topView.mas_height);
            make.left.equalTo(topView.mas_left).with.offset(0);
            make.top.equalTo(topView.mas_top).with.offset(0);
        }];
        TitleLabel.text = @"手机登录";
        TitleLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        TitleLabel.font = [UIFont boldSystemFontOfSize:10];
        TitleLabel.font = [UIFont systemFontOfSize:20];
        TitleLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
        
        /**
         *中部View
         */
        BodyView = [[UIView alloc] init];
        [self addSubview:BodyView];
        [BodyView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(self.mas_height).multipliedBy(0.6);
            make.width.equalTo(self.mas_width);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.top.equalTo(topView.mas_bottom).with.offset(0);
        }];
        //输入栏View
        TxtView = [[UIView alloc] init];
        [BodyView addSubview:TxtView];
        [TxtView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(BodyView.mas_height).multipliedBy(0.6);
            make.width.equalTo(BodyView.mas_width);
            make.left.equalTo(BodyView.mas_left).with.offset(0);
            make.top.equalTo(BodyView.mas_top).with.offset(0);
        }];
        
        //手机号输入栏View
        phoneTxtView = [[UIView alloc] init];
        [TxtView addSubview:phoneTxtView];
        [phoneTxtView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(TxtView.mas_left).with.offset(10);
            make.right.equalTo(TxtView.mas_right).with.offset(-10);
            make.height.equalTo(TxtView.mas_height).multipliedBy(0.46);
            make.top.equalTo(TxtView.mas_top).with.offset(0);
        }];
        phoneTxtView.layer.borderWidth = 1;
        phoneTxtView.layer.borderColor = [[UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1] CGColor];
        phoneTxtView.layer.masksToBounds = YES;
        phoneTxtView.layer.cornerRadius = 4;
        //手机号输入栏image
        UIImageView *phoneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/pop-icon1.jpg"]];
        [phoneTxtView addSubview:phoneImageView];
        [phoneImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(phoneTxtView.mas_height).multipliedBy(0.5);
            make.centerY.equalTo(phoneTxtView.mas_centerY);
            make.left.equalTo(phoneTxtView.mas_left).with.offset(20);
            make.width.equalTo(phoneImageView.mas_height).multipliedBy(0.7);
        }];
        //手机号输入栏
        phoneTxt = [[UITextField alloc] init];
        [phoneTxtView addSubview:phoneTxt];
        [phoneTxt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(phoneTxtView.mas_height);
            make.left.equalTo(phoneImageView.mas_left).with.offset(30);
            make.right.equalTo(phoneTxtView.mas_right).with.offset(0);
            make.top.equalTo(phoneTxtView.mas_top).with.offset(0);
        }];
        phoneTxt.borderStyle = UITextBorderStyleNone;
        phoneTxt.placeholder = @"请输入手机号";
    phoneTxt.keyboardType = UIKeyboardTypeNumberPad;
        
        //验证码输入栏View
        registerView = [[UIView alloc] init];
        [TxtView addSubview:registerView];
        [registerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(TxtView.mas_left).with.offset(10);
            make.right.equalTo(TxtView.mas_right).with.offset(-10);
            make.height.equalTo(phoneTxtView.mas_height);
            make.bottom.equalTo(TxtView.mas_bottom).with.offset(0);
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
    registerTxt.keyboardType = UIKeyboardTypeNumberPad;
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

        
        //登录按钮
        UIButton *LoginBtn = [[UIButton alloc] init];
        [BodyView addSubview:LoginBtn];
        [LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(registerView.mas_width);
            make.height.equalTo(registerView.mas_height);
            make.centerX.equalTo(registerView.mas_centerX);
            make.bottom.equalTo(BodyView.mas_bottom).with.offset(0);
        }];
        [LoginBtn setTitle:@"登 录" forState:UIControlStateNormal];
        [LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [LoginBtn setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1]];
        LoginBtn.layer.masksToBounds = YES;
        LoginBtn.layer.cornerRadius = 4;
    [LoginBtn addTarget:self action:@selector(phoneLogin) forControlEvents:UIControlEventTouchUpInside];
        /**
         *底部View
         */
        bottomView = [[UIView alloc] init];
        [self addSubview:bottomView];
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(BodyView.mas_bottom).with.offset(0);
            make.bottom.equalTo(self.mas_bottom).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(0);
        }];
        
        //其他方式登录按钮
        UIButton *otherBtn = [[UIButton alloc] init];
        [bottomView addSubview:otherBtn];
        [otherBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(bottomView.mas_height).multipliedBy(0.3);
            make.width.equalTo(bottomView.mas_width).multipliedBy(0.4);
            make.centerX.equalTo(bottomView.mas_centerX);
            make.centerY.equalTo(bottomView.mas_centerY);
        }];
        [otherBtn setTitle:@"其他方式登录" forState:UIControlStateNormal];
        [otherBtn setTitleColor:[UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:101.0f/255.0f alpha:1] forState:UIControlStateNormal];
        [otherBtn addTarget:self action:@selector(OpenAccountView) forControlEvents:UIControlEventTouchUpInside];
    //}
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = CornerSizeView;
}

#pragma mark - 获取验证码
//获取验证码
-(void)registerNum
{
    
    if ([CheckPhoneNum checkTelNumber:phoneTxt.text]) {
        
        [self viewTapEndEdit];
        [registerBtn startCutdown];
        NSString *md5 = [GZMd5 md5_32bit:phoneTxt.text];
        NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@%@%@",phoneTxt.text,@"register",@"ios",IMEI]];
        NSString *body = [NSString stringWithFormat:@"mobile=%@&send_code=%@&send_type=%@&type=%@&imei=%@&sign=%@&signtype=%@",phoneTxt.text,md5,@"login",@"ios",IMEI,sign,signtype];
        NSLog(@"%@",body);
        NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
        [TYProgressHUD showMessage:@"正在获取验证码"];
        [GZNetwork requesetWithData:[NSString stringWithFormat:@"%@%@",UNIFYURL,SendMessageURL] bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
            if (dict != NULL) {
                [TYProgressHUD hide];
                NSLog(@"%@",dict);
                NSDictionary *resultDic = [dict valueForKey:@"result"];
                MakeToast([resultDic valueForKey:@"msg"]);
                isReg = [[resultDic valueForKey:@"isregister"] intValue];
                if (isReg == 0) {
                    [self remakeView];
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
#pragma mark - 登录游戏
-(void)phoneLogin{
    [self viewTapEndEdit];
    if (isReg == 1) {//直接登录
        [self login];
    }else{//注册并登录
        [self registerAccount];
    }
}

//登录
-(void)login{
    [TYProgressHUD showMessage:@"正在登录，请稍等"];
    NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@%@%@",phoneTxt.text,registerTxt.text,APPID,TOKEN]];
    NSString *body;
    if (isReg == 0) {
        body = [NSString stringWithFormat:@"username=%@&password=%@&appid=%@&token=%@&channel=%@&type=%@&imei=%@&sign=%@&signtype=%@",phoneTxt.text,passwordTxt.text,APPID,TOKEN,@"304,01",@"ios",IMEI,sign,signtype];
    }else
    {
        body = [NSString stringWithFormat:@"username=%@&password=%@&appid=%@&token=%@&channel=%@&type=%@&imei=%@&sign=%@&signtype=%@",phoneTxt.text,registerTxt.text,APPID,TOKEN,@"304,01",@"ios",IMEI,sign,signtype];
    }
    
    
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,LoginURL];
    [GZNetwork requesetWithData:url bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
        if (dict != NULL) {
            [TYProgressHUD hide];
            NSLog(@"%@",dict);
            NSDictionary *resultDic = [dict valueForKey:@"result"];
            int code = [[resultDic valueForKey:@"code"] intValue];
            if (code == 200) {
                if (isReg == 0) {
                    NSString *userMessage = [ChangeJsonOrString DataTOjsonString:resultDic];
                    [TYUserdefaults setUserMsgForArr:userMessage];
                    [TYUserdefaults setFirstUserMsgForArr:userMessage];
                }
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

//注册
-(void)registerAccount{
    [TYProgressHUD showMessage:@"正在注册"];
    NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@%@%@",phoneTxt.text,passwordTxt.text,APPID,TOKEN]];
    NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,PhoneRegisterURL];
    NSString *body = [NSString stringWithFormat:@"username=%@&mobile_code=%@&password=%@&appid=%@&token=%@&channel=%@&type=%@&imei=%@&sign=%@&signtype=%@",phoneTxt.text,registerTxt.text,passwordTxt.text,APPID,TOKEN,@"304,01",@"ios",IMEI,sign,signtype];
    
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



//其他方式登录
-(void)OpenAccountView{
    AccountLoginView *view = [[AccountLoginView alloc] init];
    [self.superview addSubview:view];
    [view layoutAccountLoginViewWithSuperView:self.superview];
    [self removeFromSuperview];
}


-(void)remakeView{
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
                make.height.equalTo(SView.mas_height).multipliedBy(0.4);
                make.width.equalTo(SView.mas_width).multipliedBy(0.4);
            }else{
                make.height.equalTo(SView.mas_height).multipliedBy(0.35);
                make.width.equalTo(SView.mas_width).multipliedBy(0.5);
            }
            
        }else{
            if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
                if ([[OptionForDevice getDeviceName] isEqualToString:@"iphonex"]) {
                    
                    make.width.equalTo(SView.mas_width).multipliedBy(0.5);
                }else{
                    
                    make.width.equalTo(SView.mas_width).multipliedBy(0.55);
                }
                make.height.equalTo(SView.mas_height).multipliedBy(0.77);
            }else{
                if ([[OptionForDevice getDeviceName] isEqualToString:@"iphonex"]) {
                    make.height.equalTo(SView.mas_height).multipliedBy(0.4);
                }else{
                    make.height.equalTo(SView.mas_height).multipliedBy(0.42);
                }
                make.width.equalTo(SView.mas_width).multipliedBy(0.9);
            }
            
            
        }
        make.centerX.equalTo(SView.mas_centerX);
        make.centerY.equalTo(SView.mas_centerY);
    }];
    [topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height).multipliedBy(0.1785);
        make.width.equalTo(self.mas_width);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.top.equalTo(self.mas_top).with.offset(0);
    }];
    [BodyView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height).multipliedBy(0.7);
        make.width.equalTo(self.mas_width);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.top.equalTo(topView.mas_bottom).with.offset(0);
    }];
    
    [TxtView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(BodyView.mas_height).multipliedBy(0.72);
        make.width.equalTo(BodyView.mas_width);
        make.left.equalTo(BodyView.mas_left).with.offset(0);
        make.top.equalTo(BodyView.mas_top).with.offset(0);
    }];
    
    [phoneTxtView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TxtView.mas_left).with.offset(10);
        make.right.equalTo(TxtView.mas_right).with.offset(-10);
        make.height.equalTo(TxtView.mas_height).multipliedBy(0.3);
        make.top.equalTo(TxtView.mas_top).with.offset(0);
    }];
    
    [registerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TxtView.mas_left).with.offset(10);
        make.right.equalTo(TxtView.mas_right).with.offset(-10);
        make.height.equalTo(phoneTxtView.mas_height);
        make.centerY.equalTo(TxtView.mas_centerY);
    }];
    
#pragma mark 隐藏的密码输入框
    /**
     *密码输入栏view
     */
    UIView *passWordView = [[UIView alloc] init];
    [TxtView addSubview:passWordView];
    [passWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(TxtView.mas_left).with.offset(10);
        make.right.equalTo(TxtView.mas_right).with.offset(-10);
        make.height.equalTo(phoneTxtView.mas_height);
        make.bottom.equalTo(TxtView.mas_bottom).with.offset(0);
    }];
    passWordView.layer.borderWidth = 1;
    passWordView.layer.borderColor = [[UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1] CGColor];
    passWordView.layer.masksToBounds = YES;
    passWordView.layer.cornerRadius = 4;
    //密码输入栏image
    UIImageView *passwordImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/pop-icon2.jpg"]];
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
        make.left.equalTo(passwordImageView.mas_left).with.offset(40);
        make.right.equalTo(passWordView.mas_right).with.offset(0);
        make.top.equalTo(passWordView.mas_top).with.offset(0);
    }];
    passwordTxt.placeholder = @"设置密码";
    passwordTxt.secureTextEntry = YES;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}

-(void)viewTapEndEdit{
    [self endEditing:YES];
}

@end

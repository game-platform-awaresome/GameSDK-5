//
//  AccountLoginView.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/2.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "AccountLoginView.h"
#import "Masonry.h"
#import "FindPasswordView.h"
#import "RegisterAccountView.h"
#import "PhoneLoginView.h"
#import "TYUserdefaults.h"
#import "GZNetwork.h"
#import "GetUserip.h"
#import "GetAppleIFA.h"
#import "TYProgressHUD.h"
#import "GZMd5.h"
#import "UIView+Toast.h"
#import "ChangeJsonOrString.h"
#import "myBlock.h"
#import "GetCurrentViewController.h"
#import "QQLoginView.h"
#import "FirstLoginView.h"
#import "LoadingView.h"
#import "OptionForDevice.h"
#import "UIView+Extension.h"
#import "UIView+LayoutWithDevice.h"
ListView *listView = NULL;
static UITextField *accountTxt;
static UITextField *passWordTxt;
static UIView *accountTxtView;
static UIButton *dropBtn;
static NSMutableArray *switchArr;
static UIButton *eyeBtn;
static CGSize View_Size;

@implementation AccountLoginView

-(void)layoutAccountLoginViewWithSuperView:(UIView *)superView{
    switchArr = [NSMutableArray array];
    NSDictionary *switchDic = @{@"qq":@"1",@"weixin":@"0"};
    for (NSString *str in switchDic) {
        if ([[switchDic valueForKey:str] isEqualToString:@"1"]) {
            [switchArr addObject:str];
        }
    }

   View_Size = [self GZLayoutWithDevice:superView AndPad_land_width:0.4 AndPad_land_height:0.47 AndPad_portrait_width:0.5 AndPad_portrait_height:0.35 AndPhone_land_width:0.55 AndPhone_land_height:0.85 AndPhone_portrait_width:0.9 AndPhone_portrait_height:0.55 AndX_land_width:0.5 AndX_land_height:0.5 AndX_portrait_width:0.9 AndX_portrait_height:0.43];
    
    

    
    self.frame = CGRectMake(superView.centerX - View_Size.width/2, superView.centerY - View_Size.height/2, View_Size.width, View_Size.height);
    
    
    /**
     *顶部View
     */
        UIView *topView = [[UIView alloc] init];
        [self addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.mas_height).multipliedBy(0.185);
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
    titleLabel.userInteractionEnabled = YES;
        titleLabel.text = @"简单账号登录";
    titleLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        titleLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
        titleLabel.font = [UIFont systemFontOfSize:20];
    //返回按钮
    UIButton *backBtn = [[UIButton alloc] init];
    [titleLabel addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@30);
        make.height.equalTo(@30);
        make.centerY.equalTo(titleLabel.mas_centerY);
        make.left.equalTo(titleLabel.mas_left).with.offset(10);
    }];
    [backBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/backp"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backFirstView) forControlEvents:UIControlEventTouchUpInside];
    
        /**
         *中部body
         */
        UIView *bodyView = [[UIView alloc] init];
        [self addSubview:bodyView];
        [bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.mas_width);
            if ([[OptionForDevice getDeviceName] isEqualToString:@"iphonex"]) {
                make.height.equalTo(self.mas_height).multipliedBy(0.6);
            }else{
                make.height.equalTo(self.mas_height).multipliedBy(0.565);
            }
            
            make.left.equalTo(self.mas_left).with.offset(0);
            make.top.equalTo(topView.mas_bottom).with.offset(0);
        }];
        //输入框view
        UIView *txtView = [[UIView alloc] init];
        [bodyView addSubview:txtView];
        [txtView mas_makeConstraints:^(MASConstraintMaker *make) {
            if ([[OptionForDevice getDeviceName] isEqualToString:@"iphonex"]) {}
            make.height.equalTo(bodyView.mas_height).multipliedBy(0.5);
            make.left.equalTo(bodyView.mas_left).with.offset(10);
            make.right.equalTo(bodyView.mas_right).with.offset(-10);
            make.top.equalTo(bodyView.mas_top).with.offset(0);
        }];
        //Account输入框View
        accountTxtView = [[UIView alloc] init];
        [txtView addSubview:accountTxtView];
        [accountTxtView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(txtView.mas_width);
            make.height.equalTo(txtView.mas_height).multipliedBy(0.44);
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
            make.left.equalTo(accountImageView.mas_left).with.offset(40);
            make.right.equalTo(accountTxtView.mas_right).with.offset(0);
            make.top.equalTo(accountTxtView.mas_top).with.offset(0);
        }];
        accountTxt.placeholder = @"请输入用户名/手机号";
    accountTxt.keyboardType = UIKeyboardTypeASCIICapable;
    //下拉按钮
    dropBtn = [[UIButton alloc] init];
    [accountTxtView addSubview:dropBtn];
    [dropBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(accountTxt.mas_height).multipliedBy(0.6);
        make.width.equalTo(dropBtn.mas_height);
        make.centerY.equalTo(accountTxt.mas_centerY);
        make.right.equalTo(accountTxt.mas_right).with.offset(-10);
    }];
    [dropBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/login_drop"] forState:UIControlStateNormal];
    [dropBtn addTarget:self action:@selector(dropList) forControlEvents:UIControlEventTouchUpInside];
    
        //密码栏View
        UIView *passWordTxtView = [[UIView alloc] init];
        [txtView addSubview:passWordTxtView];
        [passWordTxtView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(accountTxtView.mas_height);
            make.width.equalTo(accountTxtView.mas_width);
            make.centerX.equalTo(accountTxtView.mas_centerX);
            make.bottom.equalTo(txtView.mas_bottom).with.offset(0);
        }];
        passWordTxtView.layer.borderWidth = 1;
        passWordTxtView.layer.borderColor = [[UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1] CGColor];
        passWordTxtView.layer.masksToBounds = YES;
        passWordTxtView.layer.cornerRadius = 4;
        //密码栏image
        UIImageView *passWordImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/pop-icon4.jpg"]];
        [passWordTxtView addSubview:passWordImageView];
        [passWordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(passWordTxtView.mas_height).multipliedBy(0.5);
            make.centerY.equalTo(passWordTxtView.mas_centerY);
            make.left.equalTo(passWordTxtView.mas_left).with.offset(20);
            make.width.equalTo(passWordImageView.mas_height);
        }];
        //密码栏输入框
        passWordTxt = [[UITextField alloc] init];
        [passWordTxtView addSubview:passWordTxt];
        [passWordTxt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(passWordTxtView.mas_height);
            make.left.equalTo(passWordImageView.mas_left).with.offset(40);
            make.right.equalTo(passWordTxtView.mas_right).with.offset(0);
            make.top.equalTo(passWordTxtView.mas_top).with.offset(0);
        }];
        passWordTxt.placeholder = @"请输入密码";
    passWordTxt.secureTextEntry = YES;
    passWordTxt.clearsOnBeginEditing = YES;
     
    //查看密码按钮
    eyeBtn = [[UIButton alloc] init];
    eyeBtn.selected = NO;
    [eyeBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/eye_close"] forState:UIControlStateNormal];
    [eyeBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/eye_open"] forState:UIControlStateSelected];
    [eyeBtn addTarget:self action:@selector(openPassword) forControlEvents:UIControlEventTouchUpInside];
    
    [passWordTxtView addSubview:eyeBtn];
    [eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(20);
        make.centerY.equalTo(passWordTxt.mas_centerY);
        make.centerX.equalTo(dropBtn.mas_centerX);
    }];
    
        //按钮View
        UIView *btnView = [[UIView alloc] init];
        [bodyView addSubview:btnView];
        [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(txtView.mas_width);
            make.centerX.equalTo(txtView.mas_centerX);
            make.top.equalTo(txtView.mas_bottom).with.offset(0);
            make.bottom.equalTo(bodyView.mas_bottom).with.offset(0);
        }];
        //登录按钮
        UIButton *loginBtn = [[UIButton alloc] init];
        [btnView addSubview:loginBtn];
        [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(passWordTxtView.mas_height);
            make.width.equalTo(passWordTxtView.mas_width);
            make.centerX.equalTo(btnView.mas_centerX);
            make.centerY.equalTo(btnView.mas_centerY).with.offset(-10);
        }];
        [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
        [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginBtn setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1]];
        loginBtn.layer.masksToBounds = YES;
        loginBtn.layer.cornerRadius = 4;
    [loginBtn addTarget:self action:@selector(LoginGame) forControlEvents:UIControlEventTouchUpInside];
        //“忘记密码”按钮
        UIButton *forgetBtn = [[UIButton alloc] init];
        [btnView addSubview:forgetBtn];
        [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(btnView.mas_width).multipliedBy(0.3);
            make.height.equalTo(loginBtn.mas_height).multipliedBy(0.3);
            make.left.equalTo(btnView.mas_left).with.offset(0);
            make.bottom.equalTo(btnView.mas_bottom).with.offset(-5);
        }];
        [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [forgetBtn setTitleColor:[UIColor colorWithRed:67.0f/255.0f green:111.0f/255.0f blue:177.0f/255.0f alpha:1] forState:UIControlStateNormal];
        forgetBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        forgetBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
        //"注册账号"按钮
        UIButton *registerBtn = [[UIButton alloc] init];
        [btnView addSubview:registerBtn];
        [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(btnView.mas_width).multipliedBy(0.3);
            make.height.equalTo(loginBtn.mas_height).multipliedBy(0.3);
            make.right.equalTo(btnView.mas_right).with.offset(0);
            make.bottom.equalTo(btnView.mas_bottom).with.offset(-5);
        }];
        [registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
        [registerBtn setTitleColor:[UIColor colorWithRed:133.0f/255.0f green:188.0f/255.0f blue:116.0f/255.0f alpha:1] forState:UIControlStateNormal];
        registerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        registerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [registerBtn addTarget:self action:@selector(openResgisterView) forControlEvents:UIControlEventTouchUpInside];
        
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
            if ([[OptionForDevice getDeviceName] isEqualToString:@"iphonex"]) {
                if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
                    make.height.equalTo(bottomView.mas_height).multipliedBy(0.4);
                }else{
                    make.height.equalTo(bottomView.mas_height).multipliedBy(0.42);
                }
                
            }else{
                if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
                    make.height.equalTo(bottomView.mas_height).multipliedBy(0.4);
                }else{
                    make.height.equalTo(bottomView.mas_height).multipliedBy(0.37);
                }
                
            }
            
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
            [btn addTarget:self action:@selector(QQlogin) forControlEvents:UIControlEventTouchUpInside];
        }else if ([switchArr[i] isEqualToString:@"weixin"]){
            [btn setImage:[UIImage imageNamed:@"MSYBundle.bundle/login_wx"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(weixinLogin) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    
    
    
    //}
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = CornerSizeView;
    
    NSArray *userArr = [TYUserdefaults getUserMsgArr];
    if (userArr.count != 0) {
        dropBtn.hidden = NO;
        NSDictionary *dic = [ChangeJsonOrString dictionaryWithJsonString:[userArr firstObject]];
        
        accountTxt.text = [dic valueForKey:@"username"];
        passWordTxt.text = [NSString stringWithFormat:@"%@",[dic valueForKey:@"password"]];
    }else{
        dropBtn.hidden = YES;
    }
    
    
}

#pragma mark - 登录游戏
-(void)LoginGame{
    [self viewTapEndEdit];
    if ([accountTxt.text isEqualToString:@""]) {
        MakeToast(@"账号不能为空");
    }else if ([passWordTxt.text isEqualToString:@""]){
        MakeToast(@"密码不能为空");
    }else{
        [TYProgressHUD showMessage:@"正在登录，请稍等"];
        NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@%@%@",accountTxt.text,passWordTxt.text,APPID,TOKEN]];
        NSString *body = [NSString stringWithFormat:@"username=%@&password=%@&appid=%@&token=%@&channel=%@&type=%@&imei=%@&sign=%@&signtype=%@",accountTxt.text,passWordTxt.text,APPID,TOKEN,@"304,01",@"ios",IMEI,sign,signtype];
        NSLog(@"%@",body);
        NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
        NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,LoginURL];
        [GZNetwork requesetWithData:url bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
            if (dict != NULL) {
                [TYProgressHUD hide];
                
                NSDictionary *resultDic = [dict valueForKey:@"result"];
                NSLog(@"%@",resultDic);
                NSLog(@"%@",[resultDic valueForKey:@"msg"]);
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
    
    
}

#pragma mark - 忘记密码
-(void)forgetBtnClick{
    FindPasswordView *view = [[FindPasswordView alloc] init];
    [self.superview addSubview:view];
    [view layoutFindPasswordViewWithSuperView:self.superview];
}

#pragma mark - 打开注册界面
-(void)openResgisterView{
    RegisterAccountView *view = [[RegisterAccountView alloc] init];
    [self.superview addSubview:view];
    [view layoutFindPasswordViewWithSuperView:self.superview];
}

#pragma mark - 手机登录
-(void)openPhoneLoginView{
    PhoneLoginView *view = [[PhoneLoginView alloc] init];
    [self.superview addSubview:view];
    [view layoutPhoneViewWithSuperView:self.superview];
    [self removeFromSuperview];
}

#pragma mark - QQ登录
-(void)QQlogin{
    QQLoginView *view = [[QQLoginView alloc] init];
    
    [self.superview addSubview:view];
    [view layoutQQLoginViewWithSuperView:view.superview];
}

#pragma mark - 查看密码
-(void)openPassword{
    eyeBtn.selected = !eyeBtn.selected;
    if (eyeBtn.selected == YES) {
        passWordTxt.secureTextEntry = NO;
    }else{
        passWordTxt.secureTextEntry = YES;
    }
}


#pragma mark - 下拉列表
-(void)dropList{
    
    if (listView == nil) {
        NSArray *arr = [TYUserdefaults getUserMsgArr];
        
        listView = [[ListView alloc]initWithTextfield:accountTxt DataArray:arr];
        listView.delegate = self;
    }else
    {
        [listView hideListview:accountTxt];
        [listView removeFromSuperview];
        listView = nil;
    }
}
//下拉列表代理
-(void)findPassWord:(NSString *)psw{
    passWordTxt.text = [NSString stringWithFormat:@"%@",psw];
    [listView removeFromSuperview];
    listView = nil;
}

-(void)changeUserLogin:(int)row{
    NSArray *userArr =[TYUserdefaults getUserMsgArr];
    NSString *userStr = userArr[row];
    NSDictionary *userDic = [ChangeJsonOrString dictionaryWithJsonString:userStr];
    accountTxt.text = [userDic valueForKey:@"username"];
    passWordTxt.text = [userDic valueForKey:@"password"];
}

-(void)removeListView{
    NSArray *userArr =[TYUserdefaults getUserMsgArr];
    if (userArr.count == 0) {
        accountTxt.text = @"";
        passWordTxt.text = @"";
        dropBtn.hidden = YES;
    }else{
        NSString *userStr = userArr[0];
        NSDictionary *userDic = [ChangeJsonOrString dictionaryWithJsonString:userStr];
        accountTxt.text = [userDic valueForKey:@"username"];
        passWordTxt.text = [userDic valueForKey:@"password"];
    }
    [listView removeFromSuperview];
    listView = NULL;
}


-(void)backFirstView{
    FirstLoginView *view = [[FirstLoginView alloc] init];
    [self.superview addSubview:view];
    [view layoutViewWithSuperView:self.superview];

    view.frame = CGRectMake(-view.width, view.origin.y, view.width, view.height);
    
    [UIView animateWithDuration:0.2 animations:^{
       self.frame = CGRectMake(self.superview.frame.size.width, self.superview.centerY - View_Size.height/2, View_Size.width, View_Size.height);
        
        view.frame = CGRectMake(self.superview.centerX - view.width/2, view.origin.y, view.width, view.height);
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.21 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    
}

-(void)viewTapEndEdit{
    [self endEditing:YES];
}

@end

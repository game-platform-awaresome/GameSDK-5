//
//  VerifyPhoneView.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/27.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "VerifyPhoneView.h"
#import "Masonry.h"
#import "CutdownBuntton.h"
#import "UnableGetSMSView.h"
#import "BindNewPhoneView.h"
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
static CutdownBuntton *cutdownBtn;
static UITextField *registerTxt;
static NSString *phone_code;
@implementation VerifyPhoneView

-(void)layoutVerifyPhoneViewWithSuperView:(UIView *)superView{
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
        make.height.equalTo(self.mas_height).multipliedBy(0.27);
        make.width.equalTo(self.mas_width);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    //titleLabel
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"验证账号";
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
        make.height.equalTo(self.mas_height).multipliedBy(0.55);
        make.left.equalTo(self.mas_left).with.offset(25);
        make.right.equalTo(self.mas_right).with.offset(-25);
        make.top.equalTo(topView.mas_bottom).with.offset(0);
    }];
    
    //body顶部view
    UIView *bodyTopView = [[UIView alloc] init];
    [bodyView addSubview:bodyTopView];
    [bodyTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(bodyView.mas_height).multipliedBy(0.32);
        make.width.equalTo(bodyView.mas_width);
        make.centerX.equalTo(bodyView.mas_centerX);
        make.top.equalTo(bodyView.mas_top);
    }];
    //body顶部label
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.font = [UIFont boldSystemFontOfSize:16];
    topLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    NSString *phone = [Username stringByReplacingCharactersInRange:NSMakeRange(3, 6)  withString:@"*******"];
    NSString *string = [NSString stringWithFormat:@"验证已绑定的手机号：%@",phone];
    
    NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc] initWithString:string];
    [attstring addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1] range:NSMakeRange(10,12)];
    topLabel.attributedText = attstring;
    [bodyTopView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bodyTopView.mas_left).with.offset(10);
        make.width.equalTo(bodyTopView.mas_width);
        make.top.equalTo(bodyTopView.mas_top);
    }];
    
    //输入View
    UIView *txtView = [[UIView alloc] init];
    [bodyView addSubview:txtView];
    [txtView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(bodyView.mas_width);
        make.height.equalTo(bodyView.mas_height).multipliedBy(0.68);
        make.centerX.equalTo(bodyView.mas_centerX);
        make.top.equalTo(bodyTopView.mas_bottom);
    }];
    
    //验证码输入框view
    UIView *registerView = [[UIView alloc] init];
    [txtView addSubview:registerView];
    [registerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(txtView.mas_height).multipliedBy(0.4);
        make.width.equalTo(txtView.mas_width);
        make.top.equalTo(txtView.mas_top);
        make.centerX.equalTo(txtView.mas_centerX);
    }];
    [registerView layoutIfNeeded];
    registerView.layer.borderColor = [[UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1] CGColor];
    registerView.layer.borderWidth = 1;
    registerView.layer.masksToBounds = YES;
    registerView.layer.cornerRadius = registerView.frame.size.height/2;
    //验证码image
    UIImageView *registerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/float_sms"]];
    [registerView addSubview:registerImageView];
    [registerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(registerView.mas_height).multipliedBy(0.6);
        make.width.equalTo(registerImageView.mas_height);
        make.left.equalTo(registerView.mas_left).with.offset(15);
        make.centerY.equalTo(registerView.mas_centerY);
    }];
    
    //验证码输入框
    registerTxt = [[UITextField alloc] init];
    registerTxt.placeholder = @"请输入短信验证码";
    registerTxt.borderStyle = UITextBorderStyleNone;
    registerTxt.keyboardType = UIKeyboardTypeNumberPad;
    [registerView addSubview:registerTxt];
    [registerTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(registerImageView.mas_right).with.offset(5);
        make.right.equalTo(registerView.mas_right);
        make.height.equalTo(registerView.mas_height);
        make.centerY.equalTo(registerView.mas_centerY);
    }];
    
    //获取验证码按钮
    cutdownBtn = [[CutdownBuntton alloc] init];
    [cutdownBtn setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1]];
    [cutdownBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cutdownBtn addTarget:self action:@selector(registerNum) forControlEvents:UIControlEventTouchUpInside];
    [registerView addSubview:cutdownBtn];
    [cutdownBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(registerTxt.mas_height);
        make.width.equalTo(registerTxt.mas_width).multipliedBy(0.4);
        make.centerY.equalTo(registerTxt.mas_centerY);
        make.right.equalTo(registerView.mas_right);
    }];
    [registerView layoutIfNeeded];
    cutdownBtn.layer.masksToBounds = YES;
    cutdownBtn.layer.cornerRadius = cutdownBtn.frame.size.height/2;
    
    //下一步按钮
    UIButton *nextBtn = [[UIButton alloc] init];
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextBtn setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1]];
    [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(openBindNewphoneView) forControlEvents:UIControlEventTouchUpInside];
    [txtView addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(txtView.mas_width);
        make.height.equalTo(registerView.mas_height);
        make.bottom.equalTo(txtView.mas_bottom);
        make.centerX.equalTo(txtView.mas_centerX);
    }];
    [txtView layoutIfNeeded];
    nextBtn.layer.masksToBounds = YES;
    nextBtn.layer.cornerRadius = nextBtn.frame.size.height/2;
    
    //无法接收短信按钮
    UIButton *unableBtn = [[UIButton alloc] init];
    [unableBtn setTitle:@"无法接收短信？" forState:UIControlStateNormal];
    [unableBtn setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
    unableBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [unableBtn addTarget:self action:@selector(openUnableView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:unableBtn];
    [unableBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(bodyView.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(40);
        make.centerX.equalTo(bodyView.mas_centerX);
        make.top.equalTo(bodyView.mas_bottom);
        
    }];
    
}

#pragma mark - 获取验证码
-(void)registerNum{
    if ([CheckPhoneNum checkTelNumber:[NSString stringWithFormat:@"%@",Username]]) {
        //[self remakeView];
        
        [cutdownBtn startCutdown];
        NSString *md5 = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@",Username]];
        NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@%@%@",[NSString stringWithFormat:@"%@",Username],@"removephone",@"ios",IMEI]];
        NSString *body = [NSString stringWithFormat:@"mobile=%@&send_code=%@&send_type=%@&type=%@&imei=%@&sign=%@&signtype=%@",[NSString stringWithFormat:@"%@",Username],md5,@"removephone",@"ios",IMEI,sign,signtype];
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
                    phone_code = [resultDic valueForKey:@"mobile_code"];
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

-(void)openBindNewphoneView{
    MakeTA;
    NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,CheckRegNumURL];
    NSString *body = [NSString stringWithFormat:@"userid=%@&mobile=%@&mobile_code=%@",UserID,Username,phone_code];
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    [GZNetwork requesetWithData:url bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
        HideTA;
        if (dict != NULL) {
            NSDictionary *resultDic = [dict valueForKey:@"result"];
            int code = [[resultDic valueForKey:@"code"] intValue];
            if (code == 200) {
                BindNewPhoneView *view = [[BindNewPhoneView alloc] init];
                [self.superview addSubview:view];
                [view layoutBindNewPhoneViewWithSuperView:self.superview];
            }
        }else{
            
        }
    }];
    
    
}

-(void)openUnableView{
    UnableGetSMSView *view = [[UnableGetSMSView alloc] init];
    [self.superview addSubview:view];
    [view layoutUnableGetSMSViewWithSuperView:self.superview];
}

-(void)closeView{
    [self.superview removeFromSuperview];
}

-(void)backView{
    [self removeFromSuperview];
}

@end

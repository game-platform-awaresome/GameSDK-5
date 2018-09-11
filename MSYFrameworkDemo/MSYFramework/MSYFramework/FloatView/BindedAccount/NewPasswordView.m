//
//  NewPasswordView.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/27.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "NewPasswordView.h"
#import "Masonry.h"
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
static UIButton *eyeBtn;
static UITextField *passwordTxt;
@implementation NewPasswordView

-(void)layoutNewPasswordViewWithSuperView:(UIView *)superView{
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
        make.height.equalTo(self.mas_height).multipliedBy(0.25);
        make.width.equalTo(self.mas_width);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    //titleLabel
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"请输入密码";
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
        make.left.equalTo(self.mas_left).with.offset(30);
        make.right.equalTo(self.mas_right).with.offset(-30);
        make.top.equalTo(topView.mas_bottom).with.offset(0);
    }];
    //bodyView顶部label
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    NSString *phone = [Username stringByReplacingCharactersInRange:NSMakeRange(3, 6)  withString:@"*******"];
    NSString *string = [NSString stringWithFormat:@"正在设置账号 %@ 的密码",phone];
    
    NSMutableAttributedString *attstring = [[NSMutableAttributedString alloc] initWithString:string];
    [attstring addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1] range:NSMakeRange(7,12)];
    phoneLabel.attributedText = attstring;
    [phoneLabel sizeToFit];
    phoneLabel.font = [UIFont boldSystemFontOfSize:16];
    [bodyView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(bodyView.mas_width);
        make.left.equalTo(bodyView.mas_left).with.offset(0);
        make.top.equalTo(bodyView.mas_top).with.offset(0);
    }];
    //输入密码view
    UIView *passwordView = [[UIView alloc] init];
    [bodyView addSubview:passwordView];
    
    passwordView.layer.borderColor = [[UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1] CGColor];
    passwordView.layer.borderWidth = 1;
    
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(bodyView.mas_height).multipliedBy(0.35);
        make.width.equalTo(bodyView.mas_width);
        make.centerX.equalTo(bodyView.mas_centerX);
        make.centerY.equalTo(bodyView.mas_centerY);
    }];
    [bodyView layoutIfNeeded];
    passwordView.layer.masksToBounds = YES;
    passwordView.layer.cornerRadius = passwordView.frame.size.height/2;
    
    //输入密码框
    passwordTxt = [[UITextField alloc] init];
    passwordTxt.secureTextEntry = YES;
    passwordTxt.placeholder = @"设置新密码";
    passwordTxt.borderStyle = UITextBorderStyleNone;
    [passwordView addSubview:passwordTxt];
    [passwordTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(passwordView.mas_height);
        make.left.equalTo(passwordView.mas_left).with.offset(30);
        make.right.equalTo(passwordView.mas_right).with.offset(-30);
        make.centerY.equalTo(passwordView.mas_centerY);
    }];
    
    //查看密码按钮
    eyeBtn = [[UIButton alloc] init];
    eyeBtn.selected = NO;
    [eyeBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/eye_close"] forState:UIControlStateNormal];
    [eyeBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/eye_open"] forState:UIControlStateSelected];
    [eyeBtn addTarget:self action:@selector(openPassword) forControlEvents:UIControlEventTouchUpInside];
    
    [passwordView addSubview:eyeBtn];
    [eyeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(10);
        make.width.mas_equalTo(20);
        make.centerY.equalTo(passwordTxt.mas_centerY);
        make.right.equalTo(passwordTxt.mas_right);
    }];
    
    //底部label
    UILabel *bottomLabel = [[UILabel alloc] init];
    bottomLabel.text = @"（6到20个字符，区分大小写，不含特殊字符）";
    bottomLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    bottomLabel.font = [UIFont boldSystemFontOfSize:13];
    [bottomLabel sizeToFit];
    bottomLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
    [bodyView addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(passwordView.mas_width);
        make.centerX.equalTo(bodyView.mas_centerX);
        make.bottom.equalTo(bodyView.mas_bottom);
    }];
    
    //底部view
    UIView *bottomView = [[UIView alloc] init];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(passwordView.mas_width);
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(bodyView.mas_bottom).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
    }];
    
    //修改按钮
    UIButton *changeBtn = [[UIButton alloc] init];
    [changeBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    [changeBtn setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1]];
    [changeBtn addTarget:self action:@selector(changePassword) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:changeBtn];
    [changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(bottomView.mas_width);
        make.height.equalTo(bottomView.mas_height).multipliedBy(0.5);
        make.centerX.equalTo(bottomView.mas_centerX);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    [bottomView layoutIfNeeded];
    changeBtn.layer.masksToBounds = YES;
    changeBtn.layer.cornerRadius = changeBtn.frame.size.height/2;
}


#pragma mark - 修改密码
-(void)changePassword{
    [TYProgressHUD showMessage:@"请稍等"];
    NSString *body = [NSString stringWithFormat:@"mobile=%@&password=%@&mobile_code=%@",Username,passwordTxt.text,_phone_code];
    
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,FindPassWordURL];
    [GZNetwork requesetWithData:url bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
        [TYProgressHUD hide];
        if (dict != NULL) {
            NSDictionary *resultDic = [dict valueForKey:@"result"];
            int code = [[resultDic valueForKey:@"code"] intValue];
            if (code == 200) {
                MakeToast([resultDic valueForKey:@"msg"]);
                
                NSArray *arr = [TYUserdefaults getUserMsgArr];
                NSMutableDictionary *userDic = [NSMutableDictionary dictionaryWithDictionary:[ChangeJsonOrString dictionaryWithJsonString:[TYUserdefaults getFirstUserMsg]]];
                
                
                [userDic setObject:passwordTxt.text forKey:@"password"];
                
                [TYUserdefaults setUserMsgForArr:[ChangeJsonOrString DataTOjsonString:userDic]];
                [TYUserdefaults setFirstUserMsgForArr:[ChangeJsonOrString DataTOjsonString:userDic]];
                [self.superview removeFromSuperview];
            }else{
                MakeToast([resultDic valueForKey:@"msg"]);
            }
        }else{
            MakeToast(@"网络不给力");
        }
    }];
}


-(void)openPassword{
    eyeBtn.selected = !eyeBtn.selected;
    if (eyeBtn.selected == YES) {
        passwordTxt.secureTextEntry = NO;
    }else{
        passwordTxt.secureTextEntry = YES;
    }
}

-(void)closeView{
    [self.superview removeFromSuperview];
}

-(void)backView{
    [self removeFromSuperview];
}

@end

//
//  FirstLoginView.m
//  MSYFramework
//
//  Created by 郭臻 on 2017/12/28.
//  Copyright © 2017年 郭臻. All rights reserved.
//

#import "FirstLoginView.h"
#import "Masonry.h"
#import "UIView+Extension.h"
#import "OptionForDevice.h"
#import "PhoneLoginView.h"
#import "AccountLoginView.h"
#import "GetCurrentViewController.h"
#import "QQLoginView.h"
#import "OptionForDevice.h"
#import "GZNetwork.h"
#import "GZMd5.h"
#import "GetUserip.h"
#import "GetAppleIFA.h"
#import "ChangeJsonOrString.h"
#import "UIView+Toast.h"
#import "TYProgressHUD.h"
#import "TYUserdefaults.h"
#import "myBlock.h"
#import "LoadingView.h"
#import "UIView+LayoutWithDevice.h"
#import "LoginedView.h"
static NSMutableArray *switchArr;
static CGSize View_Size;
static BOOL issaveQuick;
@implementation FirstLoginView



-(instancetype)init{
    self = [super init];
    if (self) {
        NSArray *userArr = [TYUserdefaults getUserMsgArr];
        
        for (int i=0; i<userArr.count; i++) {
            NSDictionary *dic = [ChangeJsonOrString dictionaryWithJsonString:userArr[i]];
            if ([[dic valueForKey:@"registertype"] isEqualToString:@"quick"]) {
                issaveQuick = YES;
            }
        }
    }
    
    return self;
}

#pragma mark 界面布局
-(void)layoutViewWithSuperView:(UIView *)superview{
    
   
    
    
    switchArr = [NSMutableArray array];
    NSDictionary *switchDic = @{@"qq":@"1",@"weixin":@"0"};
    for (NSString *str in switchDic) {
        if ([[switchDic valueForKey:str] isEqualToString:@"1"]) {
            [switchArr addObject:str];
        }
    }
    
    View_Size = [self GZLayoutWithDevice:superview AndPad_land_width:0.4 AndPad_land_height:0.4 AndPad_portrait_width:0.5 AndPad_portrait_height:0.3 AndPhone_land_width:0.55 AndPhone_land_height:0.75 AndPhone_portrait_width:0.9 AndPhone_portrait_height:0.35 AndX_land_width:0.5 AndX_land_height:0.75 AndX_portrait_width:0.9 AndX_portrait_height:0.3];
    
    self.frame = CGRectMake(superview.centerX - View_Size.width/2, superview.centerY - View_Size.height/2, View_Size.width, View_Size.height);
        /**
         *各控件布局
         */
        //顶部view
        UIView *TopView = [[UIView alloc] init];
        [self addSubview:TopView];
        [TopView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.mas_height).multipliedBy(0.3);
            make.width.equalTo(self.mas_width);
            make.top.equalTo(self.mas_top).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(0);
        }];
        TopView.backgroundColor = [UIColor whiteColor];
    
    //后退按钮
    NSArray *msgArr = [TYUserdefaults getUserMsgArr];
    if (msgArr.count != 0) {
        UIButton *backBtn = [[UIButton alloc] init];
        [backBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/backp"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backLoginedView) forControlEvents:UIControlEventTouchUpInside];
        [TopView addSubview:backBtn];
        [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.left.equalTo(TopView.mas_left).with.offset(10);
            make.centerY.equalTo(TopView.mas_centerY);
        }];
    }
    
    
    //TitleView
    UIView *titleView = [[UIView alloc] init];
    [TopView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120);
        make.height.equalTo(TopView.mas_height).multipliedBy(0.8);
        make.centerY.equalTo(TopView.mas_centerY);
        make.centerX.equalTo(TopView.mas_centerX);
    }];
    //logo
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/logo"]];
    [titleView addSubview:logo];
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.left.equalTo(titleView.mas_left).with.offset(0);
        make.centerY.equalTo(titleView.mas_centerY);
    }];
        //顶部title
        UILabel *TitleLabel = [[UILabel alloc] init];
    TitleLabel.text = @"简单游戏";
    
        [titleView addSubview:TitleLabel];
        [TitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.top.equalTo(titleView.mas_top).with.offset(0);
            make.width.mas_equalTo(85);
            make.right.equalTo(titleView.mas_right).with.offset(0);
            //make.bottom.equalTo(titleView.mas_bottom).with.offset(0);
            make.centerY.equalTo(logo.mas_centerY);
            
        }];
    
    
    
        
        TitleLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        TitleLabel.font = [UIFont boldSystemFontOfSize:20];
        //TitleLabel.font = [UIFont systemFontOfSize:20];
        TitleLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
    
    
        /**
         *中部BunttonView
         */
        UIView *BunttonView = [[UIView alloc] init];
        [self addSubview:BunttonView];
        [BunttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(self.mas_height).multipliedBy(0.35);
            make.width.equalTo(self.mas_width).multipliedBy(0.8);
            make.centerX.equalTo(self.mas_centerX);
            make.top.equalTo(TopView.mas_bottom).with.offset(0);
            
        }];
    
    //快速登录按钮
    UILabel *quickLabel;
    if (!issaveQuick) {
        UIButton *quickBtn = [[UIButton alloc] init];
        [BunttonView addSubview:quickBtn];
        [quickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(BunttonView.mas_height).multipliedBy(0.65);
            make.width.equalTo(quickBtn.mas_height);
            make.left.equalTo(BunttonView.mas_left).with.offset(0);
            make.top.equalTo(BunttonView.mas_top).with.offset(0);
        }];
        [quickBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/login_quick"] forState:UIControlStateNormal];
        [quickBtn addTarget:self action:@selector(quickLogin) forControlEvents:UIControlEventTouchUpInside];
        //快速登录label
        quickLabel = [[UILabel alloc] init];
        [BunttonView addSubview:quickLabel];
        [quickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(BunttonView.mas_width).multipliedBy(0.3);
            make.top.equalTo(quickBtn.mas_bottom).with.offset(5);
            make.centerX.equalTo(quickBtn.mas_centerX);
        }];
        
        quickLabel.text = @"快速体验";
        quickLabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1];
        quickLabel.font = [UIFont systemFontOfSize:15];
        quickLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
        quickLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    
    
        //手机登录按钮
        UIButton *phoneBtn = [[UIButton alloc] init];
        [phoneBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/login_phone"] forState:UIControlStateNormal];
        [phoneBtn addTarget:self action:@selector(phoneLogin) forControlEvents:UIControlEventTouchUpInside];
        [BunttonView addSubview:phoneBtn];
        [phoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(BunttonView.mas_height).multipliedBy(0.65);
            make.width.equalTo(phoneBtn.mas_height).multipliedBy(1.25);
            if (!issaveQuick) {
                make.centerX.equalTo(BunttonView.mas_centerX).with.offset(5);
            }else{
                make.right.equalTo(BunttonView.mas_centerX).with.offset(-30);
            }
            
            make.top.equalTo(BunttonView.mas_top).with.offset(0);
        }];
        //手机登录Label
        UILabel *phoneLabel = [[UILabel alloc] init];
        [BunttonView addSubview:phoneLabel];
        [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.width.equalTo(BunttonView.mas_width).multipliedBy(0.3);
            make.top.equalTo(phoneBtn.mas_bottom).with.offset(5);
            make.centerX.equalTo(phoneBtn.mas_centerX).with.offset(-5);
                    }];
        phoneLabel.text = @"手机账号";
        phoneLabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1];
        phoneLabel.font = [UIFont systemFontOfSize:15];
        phoneLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
        phoneLabel.font = [UIFont boldSystemFontOfSize:15];
    
    
    //简单账号登录按钮
    UIButton *jdBtn = [[UIButton alloc] init];
    [BunttonView addSubview:jdBtn];
    [jdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(BunttonView.mas_height).multipliedBy(0.65);
        make.width.equalTo(jdBtn.mas_height);
        if (!issaveQuick) {
            make.right.equalTo(BunttonView.mas_right).with.offset(0);
        }else{
            make.left.equalTo(BunttonView.mas_centerX).with.offset(30);
        }
        
        make.top.equalTo(BunttonView.mas_top).with.offset(0);
    }];
    [jdBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/login_jd"] forState:UIControlStateNormal];
    [jdBtn addTarget:self action:@selector(openAccountView) forControlEvents:UIControlEventTouchUpInside];
    //简单账号label
    UILabel *jdLabel = [[UILabel alloc] init];
    [BunttonView addSubview:jdLabel];
    [jdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(BunttonView.mas_width).multipliedBy(0.3);
        make.top.equalTo(jdBtn.mas_bottom).with.offset(5);
        make.centerX.equalTo(jdBtn.mas_centerX);
    }];
    jdLabel.text = @"简单账号";
    jdLabel.textColor = [UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1];
    jdLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
    jdLabel.font = [UIFont boldSystemFontOfSize:15];
    
        //QQ登录按钮
//        UIButton *qqBtn = [[UIButton alloc] init];
//        [qqBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/login_qq"] forState:UIControlStateNormal];
//        [BunttonView addSubview:qqBtn];
//        [qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.equalTo(BunttonView.mas_height).multipliedBy(0.75);
//            make.width.equalTo(qqBtn.mas_height);
//            make.right.equalTo(BunttonView.mas_right).with.offset(0);
//            make.top.equalTo(BunttonView.mas_top).with.offset(0);
//        }];
//    [qqBtn addTarget:self action:@selector(qqLogin) forControlEvents:UIControlEventTouchUpInside];
    
    
        //底部
        UIView *bottomView = [[UIView alloc] init];
        [self addSubview:bottomView];
        
        [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(BunttonView.mas_bottom).with.offset(0);
            make.bottom.equalTo(self.mas_bottom).with.offset(0);
            make.width.equalTo(self.mas_width);
            make.left.equalTo(self.mas_left).with.offset(0);
        }];
        //分割区view
    UIView *segView = [[UIView alloc] init];
    [bottomView addSubview:segView];
    [segView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(BunttonView.mas_width);
        make.centerX.equalTo(self.mas_centerX);
        make.height.equalTo(bottomView.mas_height).multipliedBy(0.3);
        make.top.equalTo(bottomView.mas_top).with.offset(0);
    }];
    //中label
    UILabel *centerLabel = [[UILabel alloc] init];
    [segView addSubview:centerLabel];
    [centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(145);
        make.height.equalTo(segView.mas_height);
        make.centerX.equalTo(segView.mas_centerX);
        make.centerY.equalTo(segView.mas_centerY);
    }];
    
    centerLabel.text = @"或通过以下方式登录";
    centerLabel.font = [UIFont boldSystemFontOfSize:15];
    centerLabel.textColor = [UIColor colorWithRed:167.0f/255.0f green:167.0f/255.0f blue:167.0f/255.0f alpha:1];
    centerLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
    //左label
    UILabel *leftLable = [[UILabel alloc] init];
    leftLable.backgroundColor = [UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1];
    [segView addSubview:leftLable];
    [leftLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.equalTo(segView.mas_left).with.offset(0);
        make.right.equalTo(centerLabel.mas_left).with.offset(0);
        make.centerY.equalTo(centerLabel.mas_centerY);
    }];
    
    //右label
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.backgroundColor = [UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1];
    [segView addSubview:rightLabel];
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.left.equalTo(centerLabel.mas_right).with.offset(0);
        make.right.equalTo(segView.mas_right).with.offset(0);
        make.centerY.equalTo(centerLabel.mas_centerY);
    }];
    
    
    //}
    //包含底部登录按钮view
    UIView *conView = [[UIView alloc] init];
    [bottomView addSubview:conView];
    [conView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(segView.mas_width);
        make.top.equalTo(segView.mas_bottom).with.offset(0);
        make.bottom.equalTo(bottomView.mas_bottom).with.offset(0);
        make.centerX.equalTo(bottomView.mas_centerX);
    }];
    
    //快捷登录按钮view
    UIView *bottomBtnView = [[UIView alloc] init];
    [conView addSubview:bottomBtnView];
    [bottomBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (switchArr.count > 1) {
            make.width.equalTo(segView.mas_width);
        }else{
            make.width.equalTo(segView.mas_width).multipliedBy(0.43);
        }
        make.height.equalTo(bottomView.mas_height).multipliedBy(0.4);
        make.centerY.equalTo(conView.mas_centerY).with.offset(-5);
        make.centerX.equalTo(conView.mas_centerX);
    }];
    
    for (int i = 0; i < switchArr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [bottomBtnView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(segView.mas_width).multipliedBy(0.43);
            make.height.equalTo(bottomBtnView.mas_height);
            if (i == 0) {
                make.left.equalTo(bottomBtnView.mas_left).with.offset(0);
            }else{
                make.right.equalTo(bottomBtnView.mas_right).with.offset(0);
            }
            make.centerY.equalTo(bottomBtnView.mas_centerY);
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


#pragma mark - 游客登录
-(void)quickLogin{
    NSString *body = [NSString stringWithFormat:@"imei=%@&appid=%@&ip=%@&channel=304,01&type=ios",IMEI,APPID,[GetUserip getIPAddress]];
    NSLog(@"%@",body);
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,QuickLoginURL];
    MakeTA;
    [GZNetwork requesetWithData:url bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
        HideTA;
        if (dict != NULL) {
            NSLog(@"%@",dict);
            NSDictionary *resultDic = [dict valueForKey:@"result"];
            int code = [[resultDic valueForKey:@"code"] intValue];
            if (code == 200) {
                NSString *result = [ChangeJsonOrString DataTOjsonString:resultDic];
                [TYUserdefaults setUserMsgForArr:result];
                [TYUserdefaults setFirstUserMsgForArr:result];
                [LoadingView loadingViewWithSuperView:self.superview AndMessage:[resultDic valueForKey:@"username"] AndUserType:@"游客账号"];
                [myBlock loginWith:[NSString stringWithFormat:@"%@",[resultDic valueForKey:@"username"]] Anduserid:[NSString stringWithFormat:@"%@",[resultDic valueForKey:@"userid"]] And:[NSString stringWithFormat:@"%@",[resultDic valueForKey:@"token"]]];
                [self removeFromSuperview];
            }else{
                MakeToast([resultDic valueForKey:@"msg"]);
            }
        }else{
            MakeToast(@"网络不给力");
        }
    }];
    
    [LoadingView loadingSuperViewHide];
}

#pragma mark - 返回LoginedView
-(void)backLoginedView{
    issaveQuick = NO;
     CGSize size = [self GZLayoutWithDevice:self.superview AndPad_land_width:0.4 AndPad_land_height:0.47 AndPad_portrait_width:0.5 AndPad_portrait_height:0.35 AndPhone_land_width:0.55 AndPhone_land_height:0.75 AndPhone_portrait_width:0.9 AndPhone_portrait_height:0.45 AndX_land_width:0.5 AndX_land_height:0.5 AndX_portrait_width:0.9 AndX_portrait_height:0.43];
    LoginedView *view = [[LoginedView alloc] init];
    [self.superview addSubview:view];
    [view layoutLoginedViewWithSuperView:self.superview];
    
     view.frame = CGRectMake(-self.superview.width, self.superview.centerY - size.height/2, size.width, size.height);
    [UIView animateWithDuration:0.2 animations:^{
        view.frame = CGRectMake(self.superview.centerX - size.width/2, self.superview.centerY - size.height/2, size.width, size.height);
        self.frame = CGRectMake(self.superview.width, self.superview.centerY - View_Size.height/2, View_Size.width, View_Size.height);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.21 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
}


#pragma mark - 手机登录
-(void)phoneLogin{
    PhoneLoginView *phoneView = [[PhoneLoginView alloc] init];
    [self.superview addSubview:phoneView];
    [phoneView layoutPhoneViewWithSuperView:self.superview];
    
    [self removeFromSuperview];
}

#pragma mark - QQ登录
-(void)qqLogin{
    QQLoginView *view = [[QQLoginView alloc] init];
    
    [self.superview addSubview:view];
    [view layoutQQLoginViewWithSuperView:view.superview];
}

#pragma mark 已有账号登录
-(void)openAccountView{
    
    
    
    AccountLoginView *view = [[AccountLoginView alloc] init];
    
    [self.superview addSubview:view];
    [view layoutAccountLoginViewWithSuperView:self.superview];
    CGSize size = [view GZLayoutWithDevice:self.superview AndPad_land_width:0.4 AndPad_land_height:0.47 AndPad_portrait_width:0.5 AndPad_portrait_height:0.35 AndPhone_land_width:0.55 AndPhone_land_height:0.85 AndPhone_portrait_width:0.9 AndPhone_portrait_height:0.55 AndX_land_width:0.5 AndX_land_height:0.5 AndX_portrait_width:0.9 AndX_portrait_height:0.43];
    view.frame = CGRectMake(self.superview.width, self.superview.centerY - size.height/2, size.width, size.height);
    [UIView animateWithDuration:0.2 animations:^{
        view.frame = CGRectMake(self.superview.centerX - size.width/2, self.superview.centerY - size.height/2, size.width, size.height);
        self.frame = CGRectMake(-View_Size.width, self.superview.centerY - View_Size.height/2, View_Size.width, View_Size.height);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.21 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    
}

@end

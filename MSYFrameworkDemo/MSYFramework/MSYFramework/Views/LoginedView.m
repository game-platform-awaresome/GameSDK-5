//
//  LoginedView.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/4/17.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "LoginedView.h"
#import "Masonry.h"
#import "UIView+LayoutWithDevice.h"
#import "UIView+Extension.h"
#import "LoginedListView.h"
#import "TYUserdefaults.h"
#import "ChangeJsonOrString.h"
#import "GZNetwork.h"
#import "GetUserip.h"
#import "GetAppleIFA.h"
#import "TYProgressHUD.h"
#import "GZMd5.h"
#import "UIView+Toast.h"
#import "myBlock.h"
#import "LoadingView.h"
#import "FirstLoginView.h"
static CGSize View_Size;
static LoginedListView *list;
static UIView *accountView;
static UIImageView *dropImg;

@interface LoginedView()<LoginedListDelegate>



@end

@implementation LoginedView

-(void)layoutLoginedViewWithSuperView:(UIView *)superView{
    View_Size = [self GZLayoutWithDevice:superView AndPad_land_width:0.4 AndPad_land_height:0.47 AndPad_portrait_width:0.5 AndPad_portrait_height:0.35 AndPhone_land_width:0.55 AndPhone_land_height:0.75 AndPhone_portrait_width:0.9 AndPhone_portrait_height:0.45 AndX_land_width:0.5 AndX_land_height:0.5 AndX_portrait_width:0.9 AndX_portrait_height:0.43];
    self.frame = CGRectMake(superView.centerX - View_Size.width/2, superView.centerY - View_Size.height/2, View_Size.width, View_Size.height);
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = CornerSizeView;
    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(hideList) name:@"thehidelist" object:nil];
    
    
    [self creatUI:superView];
    
}

-(void)hideList{
    [list logined_hideListview:self];
    list = nil;
    dropImg.image = [UIImage imageNamed:@"MSYBundle.bundle/login_drop"];
}

-(void)creatUI:(UIView *)superView{
    UIView *topview = [[UIView alloc] init];
    [self addSubview:topview];
    [topview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height).multipliedBy(0.154);
        make.left.equalTo(self.mas_left);
        make.top.equalTo(self.mas_top);
    }];
    UITapGestureRecognizer *hidetap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideList)];
    [topview addGestureRecognizer:hidetap1];
    //logo区
    UIView *logoView = [[UIView alloc] init];
    [topview addSubview:logoView];
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(topview.mas_height).multipliedBy(0.625);
        make.width.equalTo(topview).multipliedBy(0.33);
        make.centerX.equalTo(topview.mas_centerX);
        make.bottom.equalTo(topview.mas_bottom);
    }];
    //logo
    UIImageView *logoImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/logo"]];
    [logoView addSubview:logoImg];
    [logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(logoView.mas_height);
        make.width.equalTo(logoImg.mas_height);
        make.left.equalTo(logoView.mas_left);
        make.top.equalTo(logoView.mas_top);
    }];
    
    //顶部title
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"简单游戏";
    titleLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [logoView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(logoImg.mas_right).offset(2);
        make.right.equalTo(logoView.mas_right).offset(10);
        make.centerY.equalTo(logoImg.mas_centerY);
    }];
    
    //中部body
    UIView *bodyView = [[UIView alloc] init];
    [self addSubview:bodyView];
    [bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self.mas_height).multipliedBy(0.6);
        make.top.equalTo(topview.mas_bottom);
        make.left.equalTo(self.mas_left);
    }];
    UITapGestureRecognizer *hidetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideList)];
    [bodyView addGestureRecognizer:hidetap];
    //登录按钮
    UIButton *loginBtn = [[UIButton alloc] init];
    [bodyView addSubview:loginBtn];
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn setBackgroundColor:[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1]];
    
    [loginBtn addTarget:self action:@selector(LoginGame) forControlEvents:UIControlEventTouchUpInside];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(bodyView.mas_width).multipliedBy(0.87);
        make.height.equalTo(bodyView.mas_height).multipliedBy(0.24);
        make.centerX.equalTo(bodyView.mas_centerX);
        make.bottom.equalTo(bodyView.mas_bottom);
        
    }];
    [bodyView layoutIfNeeded];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = loginBtn.height/2;
    
    
    
    
    //底部view
    UIView *bottomView = [[UIView alloc] init];
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.top.equalTo(bodyView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    //其他登录按钮
    UIButton *otherBtn = [[UIButton alloc] init];
    [otherBtn setTitle:@"使用其他账号登录" forState:UIControlStateNormal];
    [otherBtn setTitleColor:[[UIColor blackColor] colorWithAlphaComponent:0.5] forState:UIControlStateNormal];
    [otherBtn addTarget:self action:@selector(otherStyleLogin) forControlEvents:UIControlEventTouchUpInside];
    otherBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:otherBtn];
    [otherBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(bottomView.mas_width).multipliedBy(0.6);
        make.centerX.equalTo(bottomView.mas_centerX);
        make.centerY.equalTo(bottomView.mas_centerY);
    }];
    
    //账号view
    accountView = [[UIView alloc] init];
    accountView.backgroundColor = [UIColor whiteColor];
    [self addSubview:accountView];
    [accountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(loginBtn.mas_width);
        make.height.equalTo(loginBtn.mas_height);
        make.centerX.equalTo(loginBtn.mas_centerX);
        make.bottom.equalTo(self.mas_centerY);
    }];
    
    [self layoutIfNeeded];
    accountView.layer.masksToBounds = YES;
    accountView.layer.cornerRadius = accountView.height/2;
    accountView.layer.borderColor = [[UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1] CGColor];
    accountView.layer.borderWidth = 1;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAccount:)];
    [accountView addGestureRecognizer:tap];
    
    //账号img
    UIImageView *accImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/welcome_img"]];
    [accountView addSubview:accImg];
    [accImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(accountView.mas_width).multipliedBy(0.087);
        make.height.equalTo(accImg.mas_width);
        make.left.equalTo(accountView.mas_left).mas_offset(accountView.width * 0.055);
        make.centerY.equalTo(accountView.mas_centerY);
    }];
    
    
    //下拉Img
    dropImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/login_drop"]];
    [accountView addSubview:dropImg];
    [dropImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(accountView.mas_width).multipliedBy(0.09);
        make.height.equalTo(dropImg.mas_width).multipliedBy(0.8);
        make.centerY.equalTo(accountView.mas_centerY);
        make.right.equalTo(accountView.mas_right).mas_offset(-accountView.width * 0.055);
    }];
    //账号label
    _accLabel = [[UILabel alloc] init];
    _accLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
    _accLabel.font = [UIFont boldSystemFontOfSize:14];
    _accLabel.text = [[ChangeJsonOrString dictionaryWithJsonString:[TYUserdefaults getFirstUserMsg]] valueForKey:@"username"];
    _PSW = [[ChangeJsonOrString dictionaryWithJsonString:[TYUserdefaults getFirstUserMsg]] valueForKey:@"password"];
    _userType = [self userRegisterType:[[ChangeJsonOrString dictionaryWithJsonString:[TYUserdefaults getFirstUserMsg]] valueForKey:@"registertype"]];
    [accountView addSubview:_accLabel];
    [_accLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accImg.mas_left);
        make.right.equalTo(dropImg.mas_right);
        make.centerY.equalTo(accountView.mas_centerY);
    }];
}


-(NSString *)userRegisterType:(NSString *)type{
   
    if ([type isEqualToString:@"phone"]) {
        type = @"手机账号";
    }else if ([type isEqualToString:@"quick"]){
        type = @"游客账号";
    }else if ([type isEqualToString:@"qq"]){
        type = @"QQ账号";
    }
    return type;
}



#pragma mark 登录
-(void)LoginGame{
    
    [LoadingView loadingViewWithSuperView:self.superview AndMessage:_accLabel.text AndUserType:_userType];
    self.hidden = YES;
    
    NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@%@%@",_accLabel.text,_PSW,APPID,TOKEN]];
    NSString *body = [NSString stringWithFormat:@"username=%@&password=%@&appid=%@&token=%@&channel=%@&type=%@&imei=%@&sign=%@&signtype=%@",_accLabel.text,_PSW,APPID,TOKEN,@"304,01",@"ios",IMEI,sign,signtype];
    NSLog(@"%@",body);
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,LoginURL];
    [GZNetwork requesetWithData:url bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
        if (dict != NULL) {
            
            NSDictionary *resultDic = [dict valueForKey:@"result"];
            
            int code = [[resultDic valueForKey:@"code"] intValue];
            if (code == 200) {
                
                NSString *userMessage = [ChangeJsonOrString DataTOjsonString:resultDic];
                [TYUserdefaults setUserMsgForArr:userMessage];
                [TYUserdefaults setFirstUserMsgForArr:userMessage];
                [myBlock loginWith:[NSString stringWithFormat:@"%@",[resultDic valueForKey:@"username"]] Anduserid:[NSString stringWithFormat:@"%@",[resultDic valueForKey:@"userid"]] And:[NSString stringWithFormat:@"%@",[resultDic valueForKey:@"token"]]];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [[NSNotificationCenter defaultCenter] removeObserver:self];
                    [self.superview removeFromSuperview];
                });
                
                
            }else{
                MakeToast([resultDic valueForKey:@"msg"]);
                [LoadingView loadingViewHide];
                self.hidden = NO;
            }
            
        }else{
            
            MakeToast(@"网络不给力");
            [LoadingView loadingViewHide];
            self.hidden = NO;
        }
    }];
    
}

-(void)otherStyleLogin{
    CGSize size = [self GZLayoutWithDevice:self.superview AndPad_land_width:0.4 AndPad_land_height:0.4 AndPad_portrait_width:0.5 AndPad_portrait_height:0.3 AndPhone_land_width:0.55 AndPhone_land_height:0.75 AndPhone_portrait_width:0.9 AndPhone_portrait_height:0.35 AndX_land_width:0.5 AndX_land_height:0.75 AndX_portrait_width:0.9 AndX_portrait_height:0.3];
    FirstLoginView *view = [[FirstLoginView alloc] init];
    [self.superview addSubview:view];
    [view layoutViewWithSuperView:self.superview];
    view.frame = CGRectMake(self.superview.width, self.superview.centerY - size.height/2, size.width, size.height);
    
    [UIView animateWithDuration:0.2 animations:^{
        view.frame = CGRectMake(self.superview.centerX - size.width/2, self.superview.centerY - size.height/2, size.width, size.height);
        self.frame = CGRectMake(-self.superview.width, self.superview.centerY - View_Size.height/2, View_Size.width, View_Size.height);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.21 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)tapAccount:(UIPanGestureRecognizer *)sender{
    if (list) {
        [list logined_hideListview:self];
        list = nil;
        dropImg.image = [UIImage imageNamed:@"MSYBundle.bundle/login_drop"];
    }else{
        __weak LoginedView *weakself = self;
        list = [[LoginedListView alloc] initWithView:accountView DataArray:[TYUserdefaults getUserMsgArr] AndOriginalView:weakself];
        dropImg.image = [UIImage imageNamed:@"MSYBundle.bundle/pull"];
        list.delegate = self;
    }
    
    
}

-(void)LoginedFindUsername:(NSString *)username AndPassword:(NSString *)password AnduserType:(NSString *)type
{
    _accLabel.text = username;
    _PSW = password;
    _userType = [self userRegisterType:type];
    [list logined_hideListview:self];
    list = nil;
}

@end

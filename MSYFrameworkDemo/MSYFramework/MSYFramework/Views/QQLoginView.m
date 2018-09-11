//
//  QQLoginView.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/17.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "QQLoginView.h"
#import "UIView+Extension.h"
#import "TianyouKeyChain.h"
#import "GetUserip.h"
#import "GetAppleIFA.h"
#import "GZNetwork.h"
#import "ChangeJsonOrString.h"
#import "UIView+Toast.h"
#import "GZMd5.h"
#import "TYUserdefaults.h"
#import "TYProgressHUD.h"
#import "myBlock.h"
#import "OptionForDevice.h"
#import "QQAccountUpdate.h"
#import "FloatViewController.h"
static NSString *loadUrl;
static UILabel *QQLoginTitleLabel;
static NSDictionary *userDic;
static FloatViewController *controller;
NSString *qqOpenid = NULL;
NSString *asstoken = NULL;
@implementation QQLoginView

-(void)layoutQQLoginViewWithSuperView:(UIView *)superView
{
    self.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    CGFloat header_h;
    if ([[OptionForDevice getDeviceName] isEqualToString:@"iphonex"]) {
        header_h = 85;
    }else{
        header_h = 65;
    }
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, header_h)];
    headerView.backgroundColor = [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1];
    [self addSubview:headerView];
    QQLoginTitleLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 200, headerView.height)];
    QQLoginTitleLabel.centerX = headerView.centerX;
    QQLoginTitleLabel.text = @"QQ帐号登录";
    QQLoginTitleLabel.textAlignment = NSTextAlignmentCenter;
    QQLoginTitleLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:QQLoginTitleLabel];
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 25, 40, 40)];
    backBtn.centerY = headerView.centerY;
    [backBtn setBackgroundImage:[UIImage imageNamed:@"MSYBundle.bundle/backp"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:backBtn];
    CGFloat webViewY = CGRectGetMaxY(headerView.frame);
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, webViewY,self.width, self.height-headerView.height)];
    
    webView.delegate = self;
    webView.scalesPageToFit = YES;
    NSString *str = @"https://xui.ptlogin2.qq.com/cgi-bin/xlogin?appid=716027609&pt_3rd_aid=101446604&daid=383&pt_skey_valid=1&style=35&s_url=http%3A%2F%2Fconnect.qq.com&refer_cgi=authorize&which=&auth_time=1470121319621&client_id=101446604&src=1&state=&response_type=token&scope=add_share%2Cadd_topic%2Clist_album%2Cupload_pic%2Cget_simple_userinfo&redirect_uri=auth%3A%2F%2Ftauth.qq.com%2F";
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    MakeTA;
    [webView loadRequest:request];
    
    [self addSubview:webView];
}

#pragma mark  WebViewDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    HideTA;
    if (webView.isLoading) {
        return;
    }
    NSString *hrefStr = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    NSArray *paramArr = [hrefStr componentsSeparatedByString:@"&"];
    
    //    BOOL hasToken;
    //    BOOL hasOpenid;
    for (NSString *string in paramArr) {
        
        if ([string hasPrefix:@"openid"] == YES) {
            qqOpenid = string;
        }else if ([string hasPrefix:@"access_token"] == YES)
        {
            asstoken = string;
        }
        
    }
    if (qqOpenid != nil && asstoken != nil) {
        NSLog(@"%@   %@",asstoken,qqOpenid);
        MakeTA;
        
            [self creatQQUser];
       
        
        
    }
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"---%@",[request URL].absoluteString);
    loadUrl = [request URL].absoluteString;
    return YES;
}
//QQ登录创建账号
-(void)creatQQUser
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,QQLoginURL];
    NSString *body = [NSString stringWithFormat:@"%@&%@&imei=%@&appid=%@&ip=%@&channel=%@&type=%@",qqOpenid,asstoken,IMEI,APPID,[GetUserip getIPAddress],@"304,01",@"ios"];
    
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    [GZNetwork requesetWithData:url bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
        HideTA;
        if (dict != NULL) {
            NSLog(@"%@",dict);
            NSDictionary *resultDic = [dict valueForKey:@"result"];
            int code = [[resultDic valueForKey:@"code"] intValue];
            if (code == 200) {
                if ([[resultDic valueForKey:@"isphone"] intValue] == 1) {
                    userDic = resultDic;
                    [self login];
                   
                }else{
                    [self.superview removeFromSuperview];
                    QQAccountUpdate *view = [[QQAccountUpdate alloc] init];
                    view.userid = [resultDic valueForKey:@"userid"];
                    
                    controller = [[FloatViewController alloc] init];
                    
                    [Window addSubview:controller.view];
                    [controller.view addSubview:view];
                    [view layoutQQAccountUpdateWithSuperView:controller.view];
                    
                    
                    
                }
                
                
            }else{
                MakeToast([resultDic valueForKey:@"msg"]);
            }
        }else{
            MakeToast(@"网络不给力");
        }
    }];
    
   // [[UIDevice currentDevice] setValue:[NSNumber numberWithInteger:UIDeviceOrientationPortrait] forKey:@"orientation"];
}

-(void)login{
    //[TYProgressHUD showMessage:@"正在登录，请稍等"];
    NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@%@%@",[userDic valueForKey:@"username"],[userDic valueForKey:@"password"],APPID,TOKEN]];
    NSString *body = [NSString stringWithFormat:@"username=%@&password=%@&appid=%@&token=%@&channel=%@&type=%@&imei=%@&sign=%@&signtype=%@",[userDic valueForKey:@"username"],[userDic valueForKey:@"password"],APPID,TOKEN,@"304,01",@"ios",IMEI,sign,signtype];
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

- (void)backBtnClick{
    
    [self removeFromSuperview];
}

@end

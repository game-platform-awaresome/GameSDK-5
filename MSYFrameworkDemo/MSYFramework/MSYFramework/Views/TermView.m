//
//  TermView.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/22.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "TermView.h"
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
#import "OptionForDevice.h"
static UILabel *QQLoginTitleLabel;
@implementation TermView

-(void)layoutTermViewWithSuperView:(UIView *)superView{
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
    QQLoginTitleLabel.text = @"简单游戏用户服务协议";
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
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"MSYBundle.bundle/term.html" withExtension:nil];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    [self addSubview:webView];
}


- (void)backBtnClick{
    
    [self removeFromSuperview];
}

@end

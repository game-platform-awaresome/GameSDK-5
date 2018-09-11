//
//  ViewController.m
//  MSYFrameworkDemo
//
//  Created by 郭臻 on 2017/12/27.
//  Copyright © 2017年 郭臻. All rights reserved.
//

#import "ViewController.h"
#import <MSYFramework/MSYFramework.h>
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController () <UIWebViewDelegate>
@property(nonatomic,strong) UIWebView *webview;
@end

@implementation ViewController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    _webview = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
//    _webview.delegate = self;
//    [_webview setScalesPageToFit:YES];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://h5cqllyx.jiulingwan.com/webserver/meishengyuanTai/index.php?from=youxitai&userId=3&userid=3&ts=1516328990&gameId=1030&appid=1030&sign_type=md5&sign=e35f4c404ccd52ebbfb09a3e69092440"]];
//    [_webview loadRequest:request];
//    [self.view addSubview:_webview];
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            [[MSYPlatform getInstance]loginWith:self.view andBlock:^(int code, NSDictionary *result) {
//                NSLog(@"--登录返回值%@",result);
//                NSString *userid = [result valueForKey:@"userid"];
//                NSString *gameurl = @"http://m.yxitai.com/channel/gameplay/game/1030/channelinfo/yxitai/uid/";
//                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",gameurl,userid]]];
//                [_webview loadRequest:request];
//            }];
//        });
//    });
    
    
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSLog(@"-------%@",[[request URL] absoluteString]);
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    imageView.image = [UIImage imageNamed:@"bj.jpg"];
    [self.view addSubview:imageView];
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *titleArr = @[@"登录",@"选择服务器",@"支付",@"用户中心",@"创建角色",@"上传游戏数据",@"切换账户",@"登出",@"退出游戏"];
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor grayColor]];
        [button setTitle:[NSString stringWithFormat:@"%@",titleArr[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = 1000 + i;
        button.frame = CGRectMake((self.view.frame.size.width - 200)/2, 40 + i * 40, 200, 30);
        [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

-(void)onClick:(UIButton *)btn
{
    if (btn.tag == 1000) {
        
        [[MSYPlatform getInstance]loginWith:self.view andBlock:^(int code, NSDictionary *result) {
            NSLog(@"--登录返回值%@",result);
        }];
    }else if (btn.tag == 1001)
    {
        NSLog(@"1111111");
        
        
    }else if (btn.tag == 1002)
    {
        NSError *error = nil;
        NSDictionary *jsonDic = @{@"userid":@"2356656",@"appid":@"1021",@"roleid":@"100420",@"serverid":@"15004",@"servername":@"\u6d4b\u8bd5\u4e00\u4e0b",@"productid":@"com.msy.wsw.60",@"productname":@"60元宝",@"Way":@"APP_PAY",@"moNey":@"6",@"customInfo":@"111111111"};
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        [[MSYPlatform getInstance] pay:@"6" AndCustomInfo:@"test" AndProductName:@"60元宝" AndProductID:@"com.msy.wsw.60" AndExt:json AndPayFinishCallback:^(int code, NSDictionary *result) {
            NSLog(@"支付结果----%@",result);
        }];
        
        
        
       
    }else if (btn.tag == 1003)
    {
        //[[TYSDK getInstance]splashViewShow];
        
    }else if (btn.tag == 1004)
    {
        NSDictionary *roleDic =@{@"Profession":@"战士",
                                 @"roleID":@"45",
                                 @"roleName":@"国服第一AD",
                                 @"serverID":@"15004",
                                 @"serverName":@"艾欧尼亚",
                                 @"userID":@"12345",
                                 @"vipLevel":@"1",//@"vip等级默认值“1”",
                                 @"level":@"2",//@"等级默认值“1”",
                                 @"sociaty":@"公会帮派",
                                 @"balance":@"0",//@"账户余额（充值元宝）默认值“0”",
                                 @"amount":@"0"};//@"总充值金额（充值元宝）默认值“0”"};
        [[MSYPlatform getInstance] updateRole:roleDic AndBlock:^(int code, NSDictionary *result) {
            
        }];
        
    }else if (btn.tag == 1005)
    {
        
    }else if (btn.tag == 1006)
    {
        NSDictionary *roleDic =@{@"Profession":@"战士",
                                 @"roleID":@"45",
                                 @"roleName":@"国服第一AD",
                                 @"serverID":@"15004",
                                 @"serverName":@"\u6d4b\u8bd5\u4e00\u4e0b",
                                 @"userID":@"123456",
                                 @"sociaty":@"公会帮派",
                                 @"level":@"等级"};
        
       
        
        
    }else if (btn.tag == 1007)
    {
        [[MSYPlatform getInstance] logout:^(int code, NSDictionary *result) {
            NSLog(@"注销结果----%@",result);
        }];
    }else if (btn.tag == 1008)
    {
        NSDictionary *roleDic =@{@"Profession":@"战士",
                                 @"roleID":@"45",
                                 @"roleName":@"国服第一AD",
                                 @"serverID":@"15004",
                                 @"serverName":@"艾欧尼亚",
                                 @"userID":@"12345",
                                 @"vipLevel":@"1",//@"vip等级默认值“1”",
                                 @"level":@"1",//@"等级默认值“1”",
                                 @"sociaty":@"公会帮派",
                                 @"balance":@"0",//@"账户余额（充值元宝）默认值“0”",
                                 @"amount":@"0"};//@"总充值金额（充值元宝）默认值“0”"};
        [[MSYPlatform getInstance] creatRole:roleDic AndBlock:^(int code, NSDictionary *result) {
            
        }];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

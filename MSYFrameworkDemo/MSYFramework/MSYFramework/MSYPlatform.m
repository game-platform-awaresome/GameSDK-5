//
//  MSYPlatform.m
//  MSYFramework
//
//  Created by 郭臻 on 2017/12/27.
//  Copyright © 2017年 郭臻. All rights reserved.
//

#import "MSYPlatform.h"
#import "LoginViewController.h"
#import "FloatBallView.h"
#import "TYIAP.h"
#import "myBlock.h"
#import "GZNetwork.h"
#import "GetAppleIFA.h"
#import "ChangeJsonOrString.h"
#import "GZMd5.h"
#import "TYProgressHUD.h"
#import "WelcomeView.h"
static MSYPlatform *instance = NULL;
static LoginViewController *loginVC;
static MSYResponseBlock payResultBlock;
static FloatBallView *floatView;
static int floatStatus;
static NSDictionary *floatSwitchDic;
@implementation MSYPlatform

+(MSYPlatform *)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [MSYPlatform new];
    });
    return instance;
}

#pragma mark - 初始化
-(void)initWithAppid:(NSString *)appid AndToken:(NSString *)token AndCallBackBlock:(MSYResponseBlock)block
{
    
    GetAPPID(appid);
    GetToken(token);
    [myBlock logoutBlock:^(int code, NSDictionary *result) {
        
        block(code,result);
        [floatView floatViewHide];
        
    }];
    [self getFloatStutas];
    [self getServiceMessage];
    
}

#pragma mark - 获取悬浮球信息
-(void)getFloatStutas{
    NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,GetFloatStatus];
    NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@",APPID,TOKEN]];
    
    NSString *body = [NSString stringWithFormat:@"appid=%@&token=%@&type=%@&imei=%@&sign=%@&signtype=%@",APPID,TOKEN,@"ios",IMEI,sign,@"md5"];
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    [GZNetwork requesetWithData:url bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
        if (dict != NULL) {
            NSDictionary *resultDic = [dict valueForKey:@"result"];
            floatStatus = [[resultDic valueForKey:@"status"] intValue];
            floatSwitchDic = [resultDic valueForKey:@"frameinfo"];
            NSLog(@"%@",floatSwitchDic);
        }else{
            
        }
    }];
}

#pragma mark - 获取客服信息
-(void)getServiceMessage{
    NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,GetServiceURL];
    NSString *body = [NSString stringWithFormat:@"appid=%@&usertoken=%@",APPID,TOKEN];
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    [GZNetwork requesetWithData:url bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
        if (dict != NULL) {
            NSDictionary *resultDic = [dict valueForKey:@"result"];
            int code = [[resultDic valueForKey:@"code"] intValue];
            if (code == 200) {
                NSDictionary *custominfoDic = [resultDic valueForKey:@"custominfo"];
                
                Getphone([custominfoDic valueForKey:@"phone"]);
                Getqq([custominfoDic valueForKey:@"qqnumber"]);
                Getqun([custominfoDic valueForKey:@"qunnumber"]);
            }
        }else{
            
        }
    }];
}


#pragma mark - 登录
-(void)loginWith:(UIView *)superview andBlock:(MSYResponseBlock)block{
    
    loginVC = [[LoginViewController alloc] init];
    
    [Window addSubview:loginVC.view];
    
    [myBlock loginBlock:^(int code, NSDictionary *result) {
        block(code,result);
        NSString *userid = [result valueForKey:@"userid"];
        GetUserID(userid);
        GetUsername([result valueForKey:@"username"]);
        WelcomeView *view = [[WelcomeView alloc] init];
        [Window addSubview:view];
        [view layoutWelcomeViewWithSuperView:Window];
        if (floatStatus == 1) {
            floatView = [[FloatBallView alloc] init];
            [floatView layoutFloatViewWithDic:floatSwitchDic];
        }
        
    }];
}


#pragma mark - 注销
-(void)logout:(MSYResponseBlock)block{
    
    block(200,@{@"status":@"注销成功"});
    
    
    [floatView floatViewHide];
    
}

#pragma mark - 创建角色
-(void)creatRole:(NSDictionary *)parameters AndBlock:(MSYResponseBlock)block{
    NSString *roleID = [parameters valueForKey:@"roleid"];
    NSString *roleName = [parameters valueForKey:@"rolename"];
    NSString *serverID = [parameters valueForKey:@"serverid"];
    NSString *serverName = [parameters valueForKey:@"servername"];
    NSString *userID = [parameters valueForKey:@"userid"];
    NSString *vipLevel = [parameters valueForKey:@"viplevel"];
    NSString *profession = [parameters valueForKey:@"profession"];
    NSString *level = [parameters valueForKey:@"level"];
    NSString *sociaty = [parameters valueForKey:@"sociaty"];
    NSString *balance = [parameters valueForKey:@"balance"];
    NSString *amount = [parameters valueForKey:@"amount"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,CreatRoleURL];
    NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@%@%@%@",APPID,TOKEN,userID,serverID,roleID]];
    NSString *body = [NSString stringWithFormat:@"appid=%@&token=%@&userid=%@&serverid=%@&servername=%@&roleid=%@&rolename=%@&profession=%@&level=%@&viplevel=%@&sociaty=%@&balance=%@&amount=%@&sign=%@&signtype=%@",APPID,TOKEN,UserID,serverID,serverName,roleID,roleName,profession,level,vipLevel,sociaty,balance,amount,sign,@"md5"];
    
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    [GZNetwork requesetWithData:url bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
        
        NSDictionary *result = [dict valueForKey:@"result"];
        NSString *msg = [result valueForKey:@"msg"];
        NSLog(@"---%@",msg);
    }];
}

#pragma mark - 角色升级
-(void)updateRole:(NSDictionary *)parameters AndBlock:(MSYResponseBlock)block{
    NSString *roleID = [parameters valueForKey:@"roleid"];
    NSString *roleName = [parameters valueForKey:@"rolename"];
    NSString *serverID = [parameters valueForKey:@"serverid"];
    NSString *serverName = [parameters valueForKey:@"servername"];
    NSString *userID = [parameters valueForKey:@"userid"];
    NSString *vipLevel = [parameters valueForKey:@"viplevel"];
    NSString *profession = [parameters valueForKey:@"profession"];
    NSString *level = [parameters valueForKey:@"level"];
    NSString *sociaty = [parameters valueForKey:@"sociaty"];
    NSString *balance = [parameters valueForKey:@"balance"];
    NSString *amount = [parameters valueForKey:@"amount"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",UNIFYURL,UpdateRoleURL];
    NSString *sign = [GZMd5 md5_32bit:[NSString stringWithFormat:@"%@%@%@%@%@",APPID,TOKEN,userID,serverID,roleID]];
    NSString *body = [NSString stringWithFormat:@"appid=%@&token=%@&userid=%@&serverid=%@&servername=%@&roleid=%@&rolename=%@&profession=%@&level=%@&viplevel=%@&sociaty=%@&balance=%@&amount=%@&sign=%@&signtype=%@",APPID,TOKEN,UserID,serverID,serverName,roleID,roleName,profession,level,vipLevel,sociaty,balance,amount,sign,@"md5"];
    
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    [GZNetwork requesetWithData:url bodyData:data completeBlock:^(NSDictionary *dict, NSURLResponse *response, NSError *error) {
        
    }];
}


-(void)pay:(NSString *)money AndCustomInfo:(NSString *)customInfo AndProductName:(NSString *)productName AndProductID:(NSString *)productID AndExt:(NSString *)ext AndPayFinishCallback:(MSYResponseBlock)block{
    
                        [TYIAP startApplePay:money AndCustomInfo:customInfo AndProductName:productName AndProductID:productID AndExt:ext AndPayFinishCallback:^(int code, NSDictionary *result) {
                            [TYIAP removeObser];
                            
                                block(code,result);
                            
                        }];
    
    

    
}




@end

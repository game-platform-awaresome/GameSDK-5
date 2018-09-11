//
//  TYUserdefaults.m
//  TYSDK
//
//  Created by iOS on 2017/5/10.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import "TYUserdefaults.h"
#import "ChangeJsonOrString.h"


@implementation TYUserdefaults

+(void)setUserMsgForArr:(NSString *)msg
{
    NSDictionary *dic = [ChangeJsonOrString dictionaryWithJsonString:msg];
    NSString *userName = dic[@"username"];
    NSString *userId = dic[@"userid"];
    GetUserID(userId);
    GetUsername(userName);
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *userMsgArr = [userdefaults mutableArrayValueForKey:@"quickusermsg"];
    NSLog(@"数组个数%ld",userMsgArr.count);
    if (userMsgArr.count == 0) {
        userMsgArr = [NSMutableArray array];
        [userMsgArr addObject:msg];
        [userdefaults setObject:userMsgArr forKey:@"quickusermsg"];
    }else
    {
        for (NSString *msgstr in userMsgArr) {
            
            NSString *str = [[ChangeJsonOrString dictionaryWithJsonString:msgstr] valueForKey:@"userid"];
            if ([str isEqualToString:[[ChangeJsonOrString dictionaryWithJsonString:msg] valueForKey:@"userid"]]) {
                [userMsgArr removeObject:msgstr];
                
            }
        }
        [userMsgArr insertObject:msg atIndex:0];
        
    }
    
}

+(NSMutableArray *)getUserMsgArr
{
    NSMutableArray *userMsgArr = [NSMutableArray array];
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    userMsgArr = [userdefaults mutableArrayValueForKey:@"quickusermsg"];
    return userMsgArr;
}


+(void)setFirstUserMsgForArr:(NSString *)msg
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *firstuserMsgArr = [userdefaults mutableArrayValueForKey:@"firstusermsg"];
    firstuserMsgArr = [[NSMutableArray alloc]init];
    [firstuserMsgArr addObject:msg];
    [userdefaults setValue:firstuserMsgArr forKey:@"firstusermsg"];
}

+(NSString *)getFirstUserMsg
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *firstuserMsgArr = [userdefaults mutableArrayValueForKey:@"firstusermsg"];
    NSString *string = [firstuserMsgArr firstObject];
    return string;
}

+ (NSString *)getSecretPhone{
    NSString *userMsg = [self getFirstUserMsg];
    NSDictionary *userDic = [ChangeJsonOrString dictionaryWithJsonString:userMsg];
    NSString *phoneNum = userDic[@"mobile"];
    
    return phoneNum;
}

+(NSString *)getShowPhone{
    NSString *phoneNum = [self getSecretPhone];
    phoneNum = [phoneNum stringByReplacingCharactersInRange:NSMakeRange(3, 4)  withString:@"****"];
    return phoneNum;
}

+(void)setNowMobile:(NSString *)mobile
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:mobile forKey:@"nowmobile"];
}

+(NSString *)getNowMonile
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults objectForKey:@"nowmobile"];
}



+(void)setLoginSwitchForArr:(NSString *)msg
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *firstuserMsgArr = [userdefaults mutableArrayValueForKey:@"loginswitch"];
    firstuserMsgArr = [[NSMutableArray alloc]init];
    [firstuserMsgArr addObject:msg];
    [userdefaults setValue:firstuserMsgArr forKey:@"loginswitch"];
}

+(NSString *)getLoginSwitch
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *firstuserMsgArr = [userdefaults mutableArrayValueForKey:@"loginswitch"];
    NSString *string = [firstuserMsgArr firstObject];
    return string;
}

+(void)setpswMsgWithPassword:(NSString *)msg
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:msg forKey:@"fpwp"];
}

+(NSMutableDictionary *)getpswMsgWithPassword
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    NSString *msg = [userdefaults objectForKey:@"fpwp"];
    NSMutableDictionary *msgDic = [NSMutableDictionary dictionaryWithDictionary:[ChangeJsonOrString dictionaryWithJsonString:msg]];
    return msgDic;
}

+(void)setCurrentCode:(NSString *)code
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    [userdefaults setObject:code forKey:@"nowcode"];
}

+(NSString *)getCurrentCode
{
    NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
    return [userdefaults objectForKey:@"nowcode"];
}

@end

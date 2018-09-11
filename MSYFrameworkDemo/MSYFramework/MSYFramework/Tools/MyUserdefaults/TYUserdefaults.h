//
//  TYUserdefaults.h
//  TYSDK
//
//  Created by iOS on 2017/5/10.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TYUserdefaults : NSObject

+(void)setUserMsgForArr:(NSString *)msg;

+(NSMutableArray *)getUserMsgArr;


+(void)setFirstUserMsgForArr:(NSString *)msg;

+(NSString *)getFirstUserMsg;

+(void)setLoginSwitchForArr:(NSString *)msg;

+(NSString *)getLoginSwitch;


+ (NSString *)getSecretPhone;

+(NSString *)getShowPhone;


+(void)setNowMobile:(NSString *)mobile;

+(NSString *)getNowMonile;
+(void)setCurrentCode:(NSString *)code;

+(NSString *)getCurrentCode;

#pragma mark 修改密码信息存储

+(void)setpswMsgWithPassword:(NSString *)msg;

+(NSMutableDictionary *)getpswMsgWithPassword;

@end

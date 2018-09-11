//
//  myBlock.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/16.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "myBlock.h"
static MSYResponseBlock loginblock;
static MSYResponseBlock logoutblock;
@implementation myBlock

+(void)loginBlock:(MSYResponseBlock)block{
    loginblock = block;
}

+(void)loginWith:(NSString *)username Anduserid:(NSString *)userid And:(NSString *)usertoken{
    if (loginblock != NULL) {
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:username,@"username",userid,@"userid",usertoken,@"usertoken", nil];
        loginblock(200,dic);
    }
}

+(void)logoutBlock:(MSYResponseBlock)block{
    logoutblock = block;
}

+(void)logout{
    if (logoutblock != NULL) {
        logoutblock(200,@{@"status":@"注销成功"});
    }
    
}

@end

//
//  myBlock.h
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/16.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^MSYResponseBlock)(int code,NSDictionary *result);



@interface myBlock : NSObject
@property(nonatomic,copy)NSString *username;
@property(nonatomic,copy)NSString *userid;
@property(nonatomic,copy)NSString *usertoken;

+(void)loginBlock:(MSYResponseBlock)block;
+(void)loginWith:(NSString *)username Anduserid:(NSString *)userid And:(NSString *)usertoken;
+(void)logoutBlock:(MSYResponseBlock)block;
+(void)logout;
@end

//
//  MSYPlatform.h
//  MSYFramework
//
//  Created by 郭臻 on 2017/12/27.
//  Copyright © 2017年 郭臻. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^MSYResponseBlock)(int code,NSDictionary *result);

@interface MSYPlatform : NSObject
//单例
+(MSYPlatform *)getInstance;

/**
 *初始化SDK
 * @param appid APPID
 * @param token Token
 * @param block 悬浮球注销回调
 */
-(void)initWithAppid:(NSString *)appid AndToken:(NSString *)token AndCallBackBlock:(MSYResponseBlock)block;

/**
 *SDK登录接口
 * @param block 登录回调（包含用户信息）
 */
-(void)loginWith:(UIView *)superview andBlock:(MSYResponseBlock)block;


/**
 *SDK注销接口
 * @param block 注销回调
 */
-(void)logout:(MSYResponseBlock)block;

/**
*SDK创建角色接口
*/
-(void)creatRole:(NSDictionary *)parameters AndBlock:(MSYResponseBlock)block;

/**
 *SDK角色升级接口
 */
-(void)updateRole:(NSDictionary *)parameters AndBlock:(MSYResponseBlock)block;


/**
 *SDK下单接口
 * @param money 金额（单位：元）
 * @param customInfo 透传参数
 * @param productName 商品名称
 * @param productID 商品ID
 * @param ext 用户信息json串
 * @param block 回调
 */
- (void)pay:(NSString*)money
AndCustomInfo:(NSString*)customInfo
AndProductName:(NSString*)productName
AndProductID:(NSString*)productID
     AndExt:(NSString*)ext
AndPayFinishCallback:(MSYResponseBlock) block;



@end

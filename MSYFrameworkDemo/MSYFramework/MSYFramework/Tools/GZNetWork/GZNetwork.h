//
//  GZNetwork.h
//  TianYouXiLogin
//
//  Created by iOS on 16/6/27.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CompletioBlock)(NSDictionary *dict, NSURLResponse *response, NSError *error);
@interface GZNetwork : NSObject


/**
 *POST请求方法
 */
+(void)requesetWithData:(NSString *)url bodyData:(NSData *)data completeBlock:(CompletioBlock)block;

/**
 *GET请求方法
 */
+(void)requesetWithUrl:(NSString *)url completeBlock:(CompletioBlock)block;
@end

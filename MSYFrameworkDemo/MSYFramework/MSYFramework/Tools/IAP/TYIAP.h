//
//  TYIAP.h
//  TYSDK
//
//  Created by iOS on 2016/12/19.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
typedef void(^MSYResponseBlock)(int code,NSDictionary *result);
@interface TYIAP : NSObject 

+(void)startApplePay:(NSString *)money AndCustomInfo:(NSString *)customInfo AndProductName:(NSString *)productName AndProductID:(NSString *)productID AndExt:(NSString *)ext AndPayFinishCallback:(MSYResponseBlock)block;

+(void)removeObser;

@end

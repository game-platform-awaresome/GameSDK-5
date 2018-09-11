//
//  TianyouKeyChain.h
//  TianYouXiLogin
//
//  Created by iOS on 16/6/27.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>


@interface TianyouKeyChain : NSObject


+(void)save:(NSString *)service data:(id)data;

+(id)getData:(NSString *)service;




@end

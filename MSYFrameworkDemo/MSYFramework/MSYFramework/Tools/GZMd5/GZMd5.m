//
//  GZMd5.m
//  TianYouXiLogin
//
//  Created by iOS on 16/6/28.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import "GZMd5.h"
#import <CommonCrypto/CommonDigest.h>
@implementation GZMd5
+ (NSString *)md5_32bit:(NSString *)phoneNum {
    const char *cStr = [phoneNum UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)phoneNum.length, digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}
@end

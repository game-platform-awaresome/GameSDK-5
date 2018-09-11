
//
//  CheckPhoneNum.m
//  TYSDK
//
//  Created by iOS on 2016/11/23.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import "CheckPhoneNum.h"

@implementation CheckPhoneNum

+(BOOL)checkTelNumber:(NSString *)telNumber
{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}

@end

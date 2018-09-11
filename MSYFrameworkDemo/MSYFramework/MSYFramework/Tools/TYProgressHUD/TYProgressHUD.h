//
//  TYProgressHUD.h
//  TYSDK
//
//  Created by iOS on 2017/1/17.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface TYProgressHUD : NSObject


+(void)showMessage:(NSString *)msg;

+(void)hide;

@end

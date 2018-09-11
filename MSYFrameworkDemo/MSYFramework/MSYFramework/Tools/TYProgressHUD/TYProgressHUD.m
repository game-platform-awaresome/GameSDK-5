//
//  TYProgressHUD.m
//  TYSDK
//
//  Created by iOS on 2017/1/17.
//  Copyright © 2017年 iOS. All rights reserved.
//

#import "TYProgressHUD.h"
static UIView *bgView = NULL;
static MBProgressHUD *hud = NULL;
@implementation TYProgressHUD

+(void)showMessage:(NSString *)msg
{
    bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bgView.backgroundColor = [UIColor clearColor];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:bgView];
    
    hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.labelText = msg;
    hud.removeFromSuperViewOnHide = YES;
    //hud.dimBackground = YES;
    
}

+(void)hide
{
    //[hud setRemoveFromSuperViewOnHide:YES];
    [hud hide:YES];
    [bgView removeFromSuperview];
}

@end

//
//  GetCurrentViewController.m
//  TYSDK
//
//  Created by iOS on 2016/11/21.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import "GetCurrentViewController.h"

@implementation GetCurrentViewController

+(UIViewController *)getCurrentViewController:(UIView *)currentView
{
    for (UIView* next = [currentView superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


@end

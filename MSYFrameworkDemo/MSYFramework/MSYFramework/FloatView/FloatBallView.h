//
//  FloatBallView.h
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/10.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FloatBallView : UIView <UIGestureRecognizerDelegate>
@property(assign, nonatomic) CGPoint point;
@property(strong, nonatomic) NSTimer *timer;
-(void)layoutFloatViewWithDic:(NSDictionary *)dic;

-(void)floatViewHide;

@end

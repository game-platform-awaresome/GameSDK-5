//
//  FloatBallView.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/10.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "FloatBallView.h"
#import "Masonry.h"
#import "myBlock.h"
#import "FloatViewController.h"
#import "AccountUpdate.h"
#import "TYUserdefaults.h"
#import "ChangeJsonOrString.h"
#import "BindedAccountView.h"
#import "serviceView.h"
static FloatViewController *controller;
static FloatBallView *floatView;
static UIImageView *extendView;
static UIImageView *iconView;
static BOOL isOpen;
static UIView *btnView;
static NSMutableArray *btnArr;
static CGFloat extentWidth;
static CGFloat btnViewWidth;
static NSArray *arr;
@implementation FloatBallView

-(void)layoutFloatViewWithDic:(NSDictionary *)dic{
    btnArr = [NSMutableArray array];
    
    if ([[dic valueForKey:@"logout"] intValue] == 1) {
        [btnArr addObject:@"logout"];
    }
    
    if ([[dic valueForKey:@"account"] intValue] == 1) {
        [btnArr addObject:@"account"];
    }
    
    if ([[dic valueForKey:@"service"] intValue] == 1) {
        [btnArr addObject:@"service"];
    }
    
    NSLog(@"%@",btnArr);
    extentWidth = btnArr.count * (25 + 25.5) + 75;
    btnViewWidth = btnArr.count * 25 + (btnArr.count - 1) * 25.5 + 10;
    
    
    floatView = [[FloatBallView alloc] initWithFrame:CGRectMake(-FloatViewSize/2, (SCREENHEIGHT - FloatViewSize)/2, FloatViewSize, FloatViewSize)];
    floatView.layer.masksToBounds = YES;
    floatView.layer.cornerRadius = floatView.frame.size.width / 2;
    floatView.userInteractionEnabled = YES;
    
    extendView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/float_bgimg"]];
    
    extendView.frame = CGRectMake(floatView.frame.origin.x, floatView.frame.origin.y, 0, FloatViewSize);
    extendView.layer.masksToBounds = YES;
    extendView.layer.cornerRadius = floatView.frame.size.width / 2;
    extendView.userInteractionEnabled = YES;
    [Window addSubview:extendView];
    iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/float_half"]];
    iconView.frame = CGRectMake(FloatViewSize/2, 0, FloatViewSize/2, FloatViewSize);
    iconView.userInteractionEnabled = YES;
    [floatView addSubview:iconView];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:floatView action:@selector(panofview:)];
    
    [floatView addGestureRecognizer:panGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:floatView action:@selector(tap:)];
    [floatView addGestureRecognizer:tapGesture];
    [Window addSubview:floatView];
    
}

#pragma mark - 拖动悬浮球
-(void)panofview:(UIPanGestureRecognizer *)sender
{
    
    if (isOpen == NO) {
        [_timer invalidate];
        _point = [sender translationInView:floatView];
        
        floatView.center = CGPointMake(floatView.center.x + _point.x, floatView.center.y + _point.y);
        iconView.frame = CGRectMake(0, 0, FloatViewSize, FloatViewSize);
        iconView.image = [UIImage imageNamed:@"MSYBundle.bundle/float_all"];
        [sender setTranslation:CGPointZero inView:floatView];
        if (sender.state == UIGestureRecognizerStateEnded) {
            [UIView animateWithDuration:0.3 animations:^{
                if (floatView.center.x <= SCREENWIDTH/2) {//当悬浮球的x在屏幕中心左边
                    if (floatView.center.y <= SCREENHEIGHT - FloatViewSize && floatView.center.y >= FloatViewSize) {//当悬浮球未超出屏幕上方和下方
                        floatView.center = CGPointMake(FloatViewSize/2, floatView.center.y);
                        
                        
                    }else if (floatView.center.y > SCREENHEIGHT - FloatViewSize){//当悬浮球超出屏幕下方
                        
                        floatView.center = CGPointMake(FloatViewSize/2,SCREENHEIGHT - FloatViewSize/2);
                        
                        
                    }else if (floatView.center.y < FloatViewSize){//当悬浮球超出屏幕上方
                        floatView.center = CGPointMake(FloatViewSize/2,FloatViewSize/2);
                    }
                    
                    extendView.center = CGPointMake(0, floatView.center.y);
                    
                }else if (floatView.center.x > SCREENWIDTH/2){//当悬浮球的x在屏幕中心右边
                    if (floatView.center.y <= SCREENHEIGHT - FloatViewSize && floatView.center.y >= FloatViewSize) {//当悬浮球未超出屏幕上方和下方
                        floatView.center = CGPointMake(SCREENWIDTH - FloatViewSize/2, floatView.center.y + _point.y);
                    }else if (floatView.center.y > SCREENHEIGHT - FloatViewSize){//当悬浮球超出屏幕下方
                        
                        floatView.center = CGPointMake(SCREENWIDTH - FloatViewSize/2, SCREENHEIGHT - FloatViewSize/2);
                        
                    }else if (floatView.center.y < FloatViewSize){//当悬浮球超出屏幕上方
                        floatView.center = CGPointMake(SCREENWIDTH - FloatViewSize/2,FloatViewSize/2);
                    }
                    extendView.center = CGPointMake(SCREENWIDTH, floatView.center.y);
                }
            }];
        }
        _point = floatView.frame.origin;
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(backImage) userInfo:nil repeats:NO];
    }
}

#pragma mark - 点击悬浮球
-(void)tap:(UIPanGestureRecognizer *)sender
{
    
    [_timer invalidate];
    if (isOpen == NO) {
        _point = floatView.frame.origin;
        [UIView animateWithDuration:0.2 animations:^{
            
            
            if (_point.x <= SCREENWIDTH/2) {
                floatView.frame = CGRectMake(0, floatView.frame.origin.y, FloatViewSize, FloatViewSize);
                iconView.frame = CGRectMake(0, 0, FloatViewSize, FloatViewSize);
                iconView.image = [UIImage imageNamed:@"MSYBundle.bundle/float_all"];
                extendView.frame = CGRectMake(floatView.frame.origin.x, floatView.frame.origin.y, extentWidth, FloatViewSize);
                
            }else{
                floatView.frame = CGRectMake(SCREENWIDTH - FloatViewSize, floatView.frame.origin.y, FloatViewSize, FloatViewSize);
                iconView.frame = CGRectMake(0, 0, FloatViewSize, FloatViewSize);
                iconView.image = [UIImage imageNamed:@"MSYBundle.bundle/float_all"];
                extendView.frame = CGRectMake(SCREENWIDTH - extentWidth, floatView.frame.origin.y, extentWidth, FloatViewSize);
            }
            
            
            
        }];
        
        [self openBtn];
        
        
    }else{
        
        [UIView animateWithDuration:0.2 animations:^{
            if (_point.x <= SCREENWIDTH/2) {
                
                extendView.frame = CGRectMake(floatView.frame.origin.x, floatView.frame.origin.y, 0, FloatViewSize);
                //[btnView removeFromSuperview];
            }else{
                extendView.frame = CGRectMake(SCREENWIDTH, floatView.frame.origin.y, 0, FloatViewSize);
                //[btnView removeFromSuperview];
            }
            
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [btnView removeFromSuperview];
        });
        
        isOpen = NO;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(closeBtn) userInfo:nil repeats:NO];
}

#pragma mark - 添加按钮
-(void)openBtn{
    
    NSMutableArray *rightArr = (NSMutableArray *)[[btnArr reverseObjectEnumerator] allObjects];
    
    isOpen = YES;
    
    //按钮View
    btnView = [[UIView alloc] init];
    [extendView addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(btnViewWidth);
        make.height.equalTo(@40);
        make.centerY.equalTo(extendView.mas_centerY);
        if (_point.x <= SCREENWIDTH/2) {
            arr = btnArr;
            make.left.equalTo(extendView.mas_left).with.offset(70);
        }else{
            arr = rightArr;
            //make.right.equalTo(extendView.mas_right).with.offset(-30);
            make.left.equalTo(extendView.mas_left).with.offset(35);
            
        }
        
    }];
    //NSLog(@"%@",arr);
    for (int i = 0; i < arr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        UILabel *seglabel = [[UILabel alloc] init];
        seglabel.backgroundColor = [UIColor colorWithRed:199.0f/255.0f green:199.0f/255.0f blue:199.0f/255.0f alpha:1];
        if (i == 0) {
           btn.frame = CGRectMake(0, 0, 20, 20);
        }else{
           btn.frame = CGRectMake(i * 25.5 + i*25, 0, 20, 20);
            
        }
        
        if (i == 1) {
            seglabel.frame = CGRectMake(33.25, 2.5, 1, 25);
        }else if (i == 2){
            seglabel.frame = CGRectMake(83.55, 2.5, 1, 25);
        }
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btnView addSubview:btn];
        [btnView addSubview:seglabel];
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:10];
        label.textAlignment = UIBaselineAdjustmentAlignCenters;
        label.textColor = [UIColor colorWithRed:170.0f/255.0f green:170.0f/255.0f blue:170.0f/255.0f alpha:1];
        [btnView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@50);
            make.centerX.equalTo(btn.mas_centerX);
            make.bottom.equalTo(btnView.mas_bottom).with.offset(0);
        }];
        if ([arr[i] isEqualToString:@"account"]) {
            [btn setImage:[UIImage imageNamed:@"MSYBundle.bundle/float_update"] forState:UIControlStateNormal];
            btn.tag = 100;
            label.text = @"账号升级";
        }else if ([arr[i] isEqualToString:@"service"]){
            [btn setImage:[UIImage imageNamed:@"MSYBundle.bundle/float_service"] forState:UIControlStateNormal];
            btn.tag = 101;
            label.text = @"客服中心";
        }else if ([arr[i] isEqualToString:@"logout"]){
            [btn setImage:[UIImage imageNamed:@"MSYBundle.bundle/float_logout"] forState:UIControlStateNormal];
            label.text = @"注销账号";
            btn.tag = 102;
        }
    }
    
    
    
}
#pragma mark - 返回半圆状态
-(void)backImage{
    if (floatView.center.x < SCREENWIDTH / 2) {
        
        floatView.frame = CGRectMake(-FloatViewSize/2, _point.y, FloatViewSize, FloatViewSize);
        iconView.frame = CGRectMake(FloatViewSize/2, 0, FloatViewSize/2, FloatViewSize);
        iconView.image = [UIImage imageNamed:@"MSYBundle.bundle/float_half"];
    }else
    {
        
        floatView.frame = CGRectMake(SCREENWIDTH-FloatViewSize/2, _point.y, FloatViewSize, FloatViewSize);
        iconView.frame = CGRectMake(0, 0, FloatViewSize/2, FloatViewSize);
        iconView.image = [UIImage imageNamed:@"MSYBundle.bundle/half_right"];
    }
    [btnView removeFromSuperview];
}

#pragma mark - 关闭按钮
-(void)closeBtn{
    [UIView animateWithDuration:0.2 animations:^{
        if (_point.x <= SCREENWIDTH/2) {
            
            extendView.frame = CGRectMake(floatView.frame.origin.x, floatView.frame.origin.y, 0, FloatViewSize);
            //[btnView removeFromSuperview];
        }else{
            extendView.frame = CGRectMake(SCREENWIDTH, floatView.frame.origin.y, 0, FloatViewSize);
            //[btnView removeFromSuperview];
        }
        
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [btnView removeFromSuperview];
    });
    isOpen = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(backImage) userInfo:nil repeats:NO];
}

#pragma mark - 悬浮球消失
-(void)floatViewHide{
    [floatView removeFromSuperview];
}

#pragma mark - 悬浮球注销功能
-(void)logout{
    [myBlock logout];
    [self closeBtn];
}

-(void)btnClick:(UIButton *)btn{
    controller = [[FloatViewController alloc] init];
    [Window addSubview:controller.view];
    [self closeBtn];
    if (btn.tag == 100) {//礼包
        
        
    
        NSArray *arr = [TYUserdefaults getUserMsgArr];
        NSDictionary *dic = [ChangeJsonOrString dictionaryWithJsonString:[TYUserdefaults getFirstUserMsg]];
        int isphone = [[dic valueForKey:@"isphone"] intValue];
        if (isphone == 1) {
            BindedAccountView *view = [[BindedAccountView alloc] init];
            [controller.view addSubview:view];
            [view layoutBindedAccountViewWithSuperView:controller.view];
        }else{
            AccountUpdate *view = [[AccountUpdate alloc] init];
            [controller.view addSubview:view];
            [view layoutAccountUpdateWithSuperView:controller.view];
        }
        
        
        
        
        
        
    }else if (btn.tag == 101){//客服
        serviceView *view = [[serviceView alloc] init];
        [controller.view addSubview:view];
        [view layoutserviceViewWithSuperView:controller.view];
    }else if (btn.tag == 102){//注销
        [self logout];
        [controller.view removeFromSuperview];
    }
}


@end

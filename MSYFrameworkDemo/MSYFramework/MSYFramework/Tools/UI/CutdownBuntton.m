//
//  CutdownBuntton.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/3.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "CutdownBuntton.h"
#import <UIKit/UIKit.h>
int bindingSendTime;
NSTimer *bindingTimer;
@implementation CutdownBuntton

-(instancetype)init{
    if (self =[super init]) {
        self.layer.borderColor = [[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1] CGColor];
        self.layer.borderWidth = 1.0f;
        self.layer.cornerRadius = 4.0f;
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor colorWithRed:234.0f/255.0f green:85.0f/255.0f blue:40.0f/255.0f alpha:1] forState:UIControlStateNormal];
        [self setBackgroundColor:[UIColor whiteColor]];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

-(void)startCutdown{
    bindingSendTime = 60;
    self.enabled = NO;
    
    bindingTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(bindingTimeCountDown) userInfo:nil repeats:YES];
    
}

-(void)bindingTimeCountDown
{
    
    [self setTitle:[NSString stringWithFormat:@"%d 秒",bindingSendTime - 1] forState:UIControlStateNormal];
    
    bindingSendTime -- ;
    if (bindingSendTime == 0) {
        [bindingTimer invalidate];
        self.enabled = YES;
        [self setTitle:@"重发" forState:UIControlStateNormal];
        
    }
    
    
}

@end

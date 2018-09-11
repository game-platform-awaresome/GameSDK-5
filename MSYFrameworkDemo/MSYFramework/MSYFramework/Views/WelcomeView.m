//
//  WelcomeView.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/28.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "WelcomeView.h"
#import "Masonry.h"
@implementation WelcomeView

-(void)layoutWelcomeViewWithSuperView:(UIView *)superView{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 15;
    CGFloat super_width = superView.frame.size.width;
    CGFloat wel_width;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        wel_width = superView.frame.size.width * 0.5;
    }else{
        if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
            wel_width = superView.frame.size.width * 0.5;
        }else{
            wel_width = superView.frame.size.width * 0.9;
        }
        
    }
    self.frame = CGRectMake((super_width - wel_width)/2, -60, wel_width, 60);
    
    //contentView
    UIView *contentView = [[UIView alloc] init];
    [self addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width).multipliedBy(0.6);
        make.height.equalTo(self.mas_height);
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
    //image
    UIImageView *welcomeImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/welcome_img"]];
    [contentView addSubview:welcomeImg];
    [welcomeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.left.equalTo(contentView.mas_left);
        make.centerY.equalTo(contentView.mas_centerY);
    }];
    
    UILabel *welcomeLabel = [[UILabel alloc] init];
    welcomeLabel.text = [NSString stringWithFormat:@"欢迎您 %@",Username];
    welcomeLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    welcomeLabel.font = [UIFont boldSystemFontOfSize:15];
    [contentView addSubview:welcomeLabel];
    
    [welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(welcomeImg.mas_right).with.offset(5);
        make.centerY.equalTo(welcomeImg.mas_centerY);
        make.right.equalTo(contentView.mas_right);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.frame = CGRectMake((super_width - wel_width)/2, 30, wel_width, 60);
    
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.5 animations:^{
            
            self.frame = CGRectMake((super_width - wel_width)/2, -60, wel_width, 60);
            
        }];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    
}


@end

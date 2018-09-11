//
//  LoadingView.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/25.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "LoadingView.h"
#import "Masonry.h"
static LoadingView *view;
@implementation LoadingView

+(void)loadingViewWithSuperView:(UIView *)superview AndMessage:(NSString *)msg AndUserType:(NSString *)type{
    view = [[LoadingView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = CornerSizeView;
    [superview addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
            make.width.equalTo(superview.mas_width).multipliedBy(0.45);
            make.height.equalTo(superview.mas_height).multipliedBy(0.25);
        }else{
            make.width.equalTo(superview.mas_width).multipliedBy(0.8);
            make.height.equalTo(superview.mas_height).multipliedBy(0.15);
        }
        
        make.centerY.equalTo(superview.mas_centerY);
        make.centerX.equalTo(superview.mas_centerX);
    }];
    
    //中部view
    UIView *bodyView = [[UIView alloc] init];
    [view addSubview:bodyView];
    [bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(view.mas_height).multipliedBy(0.63);
        make.width.equalTo(view.mas_width).multipliedBy(0.6);
        make.centerX.equalTo(view.mas_centerX);
        make.centerY.equalTo(view.mas_centerY);
    }];
    
    //用户类型label
    UILabel *userTypeLabel = [[UILabel alloc] init];
    [bodyView addSubview:userTypeLabel];
    [userTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(70);
        make.height.equalTo(bodyView.mas_height).multipliedBy(0.45);
        make.left.equalTo(bodyView.mas_left).with.offset(0);
        make.top.equalTo(bodyView.mas_top).with.offset(0);
    }];
    userTypeLabel.text = type;
    userTypeLabel.textColor = [UIColor colorWithRed:124.0f/255.0f green:124.0f/255.0f blue:124.0f/255.0f alpha:1];
    userTypeLabel.font = [UIFont boldSystemFontOfSize:16];
    
    //账号label
    UILabel *accountLabel = [[UILabel alloc] init];
    accountLabel.text = msg;
    accountLabel.textColor = [UIColor colorWithRed:234.0f/255.0f green:133.0f/255.0f blue:95.0f/255.0f alpha:1];
    accountLabel.font = [UIFont systemFontOfSize:16];
    [bodyView addSubview:accountLabel];
    [accountLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(userTypeLabel.mas_height);
        make.left.equalTo(userTypeLabel.mas_right).with.offset(5);
        make.centerY.equalTo(userTypeLabel.mas_centerY);
    }];
    
    //底部嵌套view
    UIView *nestView = [[UIView alloc] init];
    [bodyView addSubview:nestView];
    [nestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.equalTo(bodyView.mas_height).multipliedBy(0.45);
        make.bottom.equalTo(bodyView.mas_bottom).with.offset(0);
        make.centerX.equalTo(bodyView.mas_centerX);
    }];
    
    
    //旋转图片
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/rotate"]];
    [nestView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.left.equalTo(nestView.mas_left).with.offset(0);
        make.top.equalTo(nestView.mas_top).with.offset(0);
    }];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                                   //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue = [NSNumber numberWithFloat:M_PI * 2];
    animation.duration = 0.2;
    animation.autoreverses = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [imageView.layer addAnimation:animation forKey:nil];
    
    //正在登录label
    UILabel *loginLabel = [[UILabel alloc] init];
    loginLabel.text = @"正在登录...";
    loginLabel.font = [UIFont boldSystemFontOfSize:17];
    [nestView addSubview:loginLabel];
    [loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(90);
        make.height.equalTo(nestView.mas_height);
        make.left.equalTo(imageView.mas_right).with.offset(5);
        make.centerY.equalTo(imageView.mas_centerY);
    }];
    
    
}

+(void)loadingViewHide{
    [view removeFromSuperview];
}

+(void)loadingSuperViewHide{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view.superview removeFromSuperview];
    });
}

@end

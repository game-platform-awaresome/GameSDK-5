//
//  serviceView.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/1/28.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "serviceView.h"
#import "Masonry.h"
#import "OptionForDevice.h"
@implementation serviceView

-(void)layoutserviceViewWithSuperView:(UIView *)superView{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(superView.mas_width).multipliedBy(0.9);
//        make.height.equalTo(superView.mas_height).multipliedBy(0.35);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
                make.height.equalTo(superView.mas_height).multipliedBy(0.4);
                make.width.equalTo(superView.mas_width).multipliedBy(0.4);
            }else{
                make.height.equalTo(superView.mas_height).multipliedBy(0.35);
                make.width.equalTo(superView.mas_width).multipliedBy(0.5);
            }
            
        }else{
            if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
                if ([[OptionForDevice getDeviceName] isEqualToString:@"iphonex"]) {
                    make.width.equalTo(superView.mas_width).multipliedBy(0.5);
                }else{
                    
                    make.width.equalTo(superView.mas_width).multipliedBy(0.55);
                }
                make.height.equalTo(superView.mas_height).multipliedBy(0.65);
                
            }else{
                if ([[OptionForDevice getDeviceName] isEqualToString:@"iphonex"]) {
                    make.height.equalTo(superView.mas_height).multipliedBy(0.3);
                }else{
                    make.height.equalTo(superView.mas_height).multipliedBy(0.35);
                }
                make.width.equalTo(superView.mas_width).multipliedBy(0.9);
            }
            
            
        }
        make.centerY.equalTo(superView.mas_centerY);
        make.centerX.equalTo(superView.mas_centerX);
    }];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = CornerSizeView;
    //顶部view
    UIView *topView = [[UIView alloc] init];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height).multipliedBy(0.35);
        make.width.equalTo(self.mas_width);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    //titleLabel
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"客服中心";
    titleLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
    [topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(topView.mas_width).multipliedBy(0.5);
        make.height.equalTo(topView.mas_height).multipliedBy(0.8);
        make.centerX.equalTo(topView.mas_centerX);
        make.centerY.equalTo(topView.mas_centerY);
    }];
    
    
    //关闭按钮
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/login_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.right.equalTo(topView.mas_right).with.offset(-15);
        make.centerY.equalTo(titleLabel.mas_centerY);
    }];
    
    //bodyView
    UIView *bodyView = [[UIView alloc] init];
    [self addSubview:bodyView];
    [bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height).multipliedBy(0.43);
        make.left.equalTo(self.mas_left).with.offset(30);
        make.right.equalTo(self.mas_right).with.offset(-30);
        make.top.equalTo(topView.mas_bottom).with.offset(0);
    }];
    
    //顶部label
    UILabel *topLabel = [[UILabel alloc] init];
    topLabel.text = @"遇见问题，请联系客服";
    topLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    topLabel.font = [UIFont boldSystemFontOfSize:16];
    [bodyView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(bodyView.mas_width);
        make.top.equalTo(bodyView.mas_top);
        make.left.equalTo(bodyView.mas_left);
    }];
    
    //客服信息view
    UIView *servicemsgView = [[UIView alloc] init];
    [bodyView addSubview:servicemsgView];
    [servicemsgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(bodyView.mas_height).multipliedBy(0.64);
        make.width.equalTo(bodyView.mas_width);
        make.bottom.equalTo(bodyView.mas_bottom);
        make.centerX.equalTo(bodyView.mas_centerX);
    }];
    
    //客服QQView
    UIView *serviceqqView = [[UIView alloc] init];
    [servicemsgView addSubview:serviceqqView];
    [serviceqqView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(servicemsgView.mas_width);
        make.height.equalTo(servicemsgView.mas_height).multipliedBy(0.4);
        make.centerX.equalTo(servicemsgView.mas_centerX);
        make.top.equalTo(servicemsgView.mas_top);
    }];
    
    //qqimage
    UIImageView *qqimageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/service_qq"]];
    [serviceqqView addSubview:qqimageView];
    [qqimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(25);
        make.left.equalTo(serviceqqView.mas_left);
        make.centerY.equalTo(serviceqqView.mas_centerY);
    }];
    
    //qq左label
    UILabel *qqleftLabel = [[UILabel alloc] init];
    qqleftLabel.text = @"客服QQ";
    qqleftLabel.font = [UIFont boldSystemFontOfSize:20];
    [serviceqqView addSubview:qqleftLabel];
    [qqleftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(75);
        make.left.equalTo(qqimageView.mas_right).with.offset(5);
        make.centerY.equalTo(qqimageView.mas_centerY);
    }];
    
    //qq号
    UILabel *qqlabel = [[UILabel alloc] init];
    qqlabel.text = QQ;
    qqlabel.font = [UIFont boldSystemFontOfSize:20];
    qqlabel.textColor = [UIColor colorWithRed:237.0f/255.0f green:118.0f/255.0f blue:51.0f/255.0f alpha:1];
    [serviceqqView addSubview:qqlabel];
    [qqlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(serviceqqView.mas_width).multipliedBy(0.6);
        make.left.equalTo(qqleftLabel.mas_right).with.offset(10);
        make.centerY.equalTo(qqleftLabel.mas_centerY);
    }];
    
    //客服QQqunView
    UIView *serviceqqgroView = [[UIView alloc] init];
    [servicemsgView addSubview:serviceqqgroView];
    [serviceqqgroView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(servicemsgView.mas_width);
        make.height.equalTo(servicemsgView.mas_height).multipliedBy(0.4);
        make.centerX.equalTo(servicemsgView.mas_centerX);
        make.bottom.equalTo(servicemsgView.mas_bottom);
    }];
    
    //qqimage
    UIImageView *qqgroimageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/service_qqgroup"]];
    [serviceqqgroView addSubview:qqgroimageView];
    [qqgroimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(25);
        make.left.equalTo(serviceqqgroView.mas_left);
        make.centerY.equalTo(serviceqqgroView.mas_centerY);
    }];
    
    //qq左label
    UILabel *qqgroleftLabel = [[UILabel alloc] init];
    qqgroleftLabel.text = @"客服Q群";
    qqgroleftLabel.font = [UIFont boldSystemFontOfSize:20];
    [serviceqqgroView addSubview:qqgroleftLabel];
    [qqgroleftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(77);
        make.left.equalTo(qqgroimageView.mas_right).with.offset(5);
        make.centerY.equalTo(qqgroimageView.mas_centerY);
    }];
    
    //qq号
    UILabel *qqgrolabel = [[UILabel alloc] init];
    qqgrolabel.text = Group;
    qqgrolabel.font = [UIFont boldSystemFontOfSize:20];
    qqgrolabel.textColor = [UIColor colorWithRed:237.0f/255.0f green:118.0f/255.0f blue:51.0f/255.0f alpha:1];
    [serviceqqgroView addSubview:qqgrolabel];
    [qqgrolabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(serviceqqgroView.mas_width).multipliedBy(0.5);
        make.left.equalTo(qqgroleftLabel.mas_right).with.offset(10);
        make.centerY.equalTo(qqgroleftLabel.mas_centerY);
    }];
}

-(void)closeView{
    [self.superview removeFromSuperview];
}

-(void)backView{
    [self removeFromSuperview];
}

@end

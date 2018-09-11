//
//  QQAccountUpdate.h
//  MSYFramework
//
//  Created by 郭臻 on 2018/3/16.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QQAccountUpdate : UIView
@property(nonatomic,copy)NSString *userid;
-(void)layoutQQAccountUpdateWithSuperView:(UIView *)superView;
@end

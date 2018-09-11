//
//  LoginedCell.h
//  MSYFramework
//
//  Created by 郭臻 on 2018/4/18.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginedCellDelegate <NSObject>

-(void)deluserMsg:(NSInteger)row;

@end


@interface LoginedCell : UITableViewCell

@property(nonatomic,strong)UILabel *accountLabel;
@property(nonatomic,strong)UIImageView *accountImg;
@property(nonatomic,strong)UIButton *delBtn;
@property(nonatomic,assign)NSInteger row;
@property(nonatomic,weak)id <LoginedCellDelegate> delegate;

@end

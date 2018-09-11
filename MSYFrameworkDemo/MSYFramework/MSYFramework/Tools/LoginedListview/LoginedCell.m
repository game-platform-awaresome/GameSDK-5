//
//  LoginedCell.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/4/18.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "LoginedCell.h"
#import "Masonry.h"
#import "UIView+Extension.h"
@implementation LoginedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}


-(void)creatUI{
    //账号Img
    _accountImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MSYBundle.bundle/welcome_img"]];
    [self.contentView addSubview:_accountImg];
    [_accountImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.087);
        make.height.equalTo(_accountImg.mas_width);
        make.left.equalTo(self.contentView.mas_left).mas_offset(self.contentView.width * 0.055);
        make.centerY.equalTo(self.contentView.mas_centerY);
        
    }];
    
    //删除按钮
    _delBtn = [[UIButton alloc] init];
    [_delBtn setImage:[UIImage imageNamed:@"MSYBundle.bundle/login_close"] forState:UIControlStateNormal];
    [_delBtn addTarget:self action:@selector(delUsermsg) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_delBtn];
    [_delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.08);
        make.height.equalTo(_delBtn.mas_width);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).mas_offset(-self.contentView.width * 0.055);
    }];
    
    
    //label
    _accountLabel = [[UILabel alloc] init];
    _accountLabel.textAlignment = UIBaselineAdjustmentAlignCenters;
    _accountLabel.textColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    _accountLabel.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:_accountLabel];
    [_accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_accountImg.mas_left);
        make.right.equalTo(_delBtn.mas_right);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
}

-(void)delUsermsg{
    [_delegate deluserMsg:_row];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

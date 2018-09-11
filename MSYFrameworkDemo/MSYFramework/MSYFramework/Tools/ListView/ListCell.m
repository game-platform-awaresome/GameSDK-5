//
//  ListCell.m
//  TYSDK
//
//  Created by iOS on 2016/11/24.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import "ListCell.h"
#import "Masonry.h"
#import "UIView+Extension.h"
//#import "FirstLoginView.h"
#import "AccountLoginView.h"

@interface ListCell ()

@property(nonatomic,weak)UIButton *btn;


@end
@implementation ListCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatUI];
    }
    
    return self;
}


-(void)creatUI
{

    UIView *leftView = [[UIView alloc] init];
    [self.contentView addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height).multipliedBy(0.35);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).with.offset(20);
        make.width.equalTo(leftView.mas_height).multipliedBy(1.5);
    }];
    UILabel *usernameLabel = [[UILabel alloc] init];
    self.usernameLabel = usernameLabel;
    self.usernameLabel.textColor = [UIColor colorWithRed:105.0f/255.0f green:105.0f/255.0f blue:105.0f/255.0f alpha:1];
    //self.usernameLabel.userInteractionEnabled = YES;
    
    [self.contentView addSubview:self.usernameLabel];
    [_usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.contentView.mas_height);
        make.left.equalTo(leftView.mas_left).with.offset(40);
        make.right.equalTo(self.contentView.mas_right).with.offset(-30);
    }];


    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.btnX, 0, 30, 30)];
    btn.centerY = self.centerY;
    self.btn = btn;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:@"MSYBundle.bundle/login_close"] forState:UIControlStateNormal];
    [self.contentView addSubview:btn];

//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        self.usernameLabel.font = [UIFont systemFontOfSize:20];
//        self.severLabel.font = [UIFont systemFontOfSize:20];
//    }else{
//        self.usernameLabel.font = [UIFont systemFontOfSize:16];
//        self.severLabel.font = [UIFont systemFontOfSize:16];
//    }

}

- (void)btnClick{
    
    [_delegate deletPhoneNumWithRow:self.row];
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    self.firstImg.centerY = self.centerY;
//    CGFloat usernameLabelX = CGRectGetMaxX(_firstImg.frame)+10;
//    CGFloat usernameLabelH = self.height/2;
//    self.usernameLabel.frame = CGRectMake(usernameLabelX, 0, self.width-60, usernameLabelH);
//    CGFloat severLabelY = CGRectGetMaxY(_usernameLabel.frame);
//    self.severLabel.frame = CGRectMake(usernameLabelX, severLabelY, self.width-60, usernameLabelH);
   //self.btn.centerY = self.centerY;
    self.usernameLabel.text = self.phoneNum;
    self.btn.x = self.btnX;
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end

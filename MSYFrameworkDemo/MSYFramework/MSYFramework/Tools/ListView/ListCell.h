//
//  ListCell.h
//  TYSDK
//
//  Created by iOS on 2016/11/24.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DeletPhoneNumDelegate <NSObject>

- (void)deletPhoneNumWithRow:(int)row;

@end



@interface ListCell : UITableViewCell

@property(nonatomic,weak)UIImageView *firstImg;
@property(nonatomic,weak)UILabel *usernameLabel;
@property(nonatomic,weak)UILabel *severLabel;
//@property(nonatomic,strong)UIImageView *delImg;
@property (nonatomic, copy) NSString *phoneNum;
@property (nonatomic, weak) id<DeletPhoneNumDelegate>delegate;
@property (nonatomic, assign) int row;
@property (nonatomic,assign) int btnX;
@end

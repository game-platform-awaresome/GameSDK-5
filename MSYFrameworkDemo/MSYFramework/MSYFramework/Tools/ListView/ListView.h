//
//  ListView.h
//  TYSDK
//
//  Created by iOS on 2016/11/24.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListCell.h"

@protocol ListViewDelegate <NSObject>

-(void)findPassWord:(NSString *)psw;
- (void)changeUserLogin:(int)row;
- (void)removeListView;

@end


@interface ListView : UIView<DeletPhoneNumDelegate>

@property(nonatomic,weak)id <ListViewDelegate> delegate;
//@property (nonatomic, assign)BOOL isPhone;

-(id)initWithTextfield:(UITextField *)textfield DataArray:(NSArray *)arr;

- (void)hideListview:(UITextField *)text;

@end

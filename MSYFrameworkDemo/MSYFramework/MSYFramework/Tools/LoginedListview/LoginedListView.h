//
//  LoginedListView.h
//  MSYFramework
//
//  Created by 郭臻 on 2018/4/18.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginedView.h"
@protocol LoginedListDelegate <NSObject>

-(void)LoginedFindUsername:(NSString *)username AndPassword:(NSString *)password AnduserType:(NSString *)type;


@end


@interface LoginedListView : UIView

@property(nonatomic,weak)id <LoginedListDelegate> delegate;

-(id)initWithView:(UIView *)accountView DataArray:(NSArray *)arr AndOriginalView:(LoginedView *)originalView;

- (void)logined_hideListview:(UIView *)accountView;

-(void)reloadUI;
@end

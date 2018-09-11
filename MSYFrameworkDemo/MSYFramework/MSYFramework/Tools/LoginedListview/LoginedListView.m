//
//  LoginedListView.m
//  MSYFramework
//
//  Created by 郭臻 on 2018/4/18.
//  Copyright © 2018年 郭臻. All rights reserved.
//

#import "LoginedListView.h"
#import "Masonry.h"
#import "UIView+Extension.h"
#import "LoginedCell.h"
#import "ChangeJsonOrString.h"
#import "TYUserdefaults.h"
@interface LoginedListView()<UITableViewDelegate,UITableViewDataSource,LoginedCellDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSMutableArray *dataArr;
@property(nonatomic,strong)UIView *currentView;
@property(nonatomic,assign)NSInteger row;
@property(nonatomic,strong)LoginedView *originalView;
@end
@implementation LoginedListView

-(id)initWithView:(UIView *)accountView DataArray:(NSArray *)arr AndOriginalView:(LoginedView *)originalView
{
    _dataArr = [NSMutableArray arrayWithArray:arr];
    _currentView = accountView;
    _originalView = originalView;
    if (self = [super init]) {
        [accountView.superview insertSubview:self atIndex:3];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(accountView);
            if (arr.count >= 3) {
                make.height.equalTo(accountView.mas_height).multipliedBy(3.5);
            }else{
                make.height.mas_equalTo(accountView.height * (arr.count + 0.5));
            }
            make.top.equalTo(accountView.mas_centerY);
            make.centerX.equalTo(accountView.mas_centerX);
        }];
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1] CGColor];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.layer.cornerRadius = 4;
        //self.tableView.backgroundColor = [UIColor orangeColor];
        //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //self.tableView.bounces = NO;
        self.tableView.showsVerticalScrollIndicator = NO;
        //self.tableView.userInteractionEnabled = NO;
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (arr.count >= 3) {
                make.height.equalTo(accountView.mas_height).multipliedBy(3);
            }else{
                make.height.mas_equalTo(accountView.height * arr.count);
            }
            make.width.equalTo(self.mas_width);
            make.bottom.equalTo(self.mas_bottom);
            make.centerX.equalTo(self.mas_centerX);
        }];
        
    }
    
    
    return self;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _currentView.height;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* indentifier = @"loginedcell";
    LoginedCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[LoginedCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
        
        cell.backgroundColor = [UIColor whiteColor];
        
    }
    
    NSDictionary *dic = [ChangeJsonOrString dictionaryWithJsonString:_dataArr[indexPath.row]];
    cell.accountLabel.text = [dic valueForKey:@"username"];
    cell.delegate = self;
    cell.row = [indexPath row];
    
    return cell;
}

-(void)deluserMsg:(NSInteger)row{
    NSString *dicStr = self.dataArr[row];
    
    
    
    
    NSString *userid = [[ChangeJsonOrString dictionaryWithJsonString:dicStr] valueForKey:@"userid"];
    [self.dataArr removeObjectAtIndex:row];
    
    NSMutableArray *arr = [TYUserdefaults getUserMsgArr];
    for (NSString *string in arr) {
        if ([userid isEqualToString:[[ChangeJsonOrString dictionaryWithJsonString:string] valueForKey:@"userid"]]) {
            [arr removeObject:string];
        }
    }
    if (arr.count == 0) {
        [TYUserdefaults setFirstUserMsgForArr:@""];
        [_originalView otherStyleLogin];
    }else
    {
        [TYUserdefaults setFirstUserMsgForArr:[arr firstObject]];
        if ([_originalView.accLabel.text isEqualToString:[[ChangeJsonOrString dictionaryWithJsonString:dicStr] valueForKey:@"username"]]) {
            NSDictionary *firstDic = [ChangeJsonOrString dictionaryWithJsonString:[TYUserdefaults getFirstUserMsg]];
            _originalView.accLabel.text = [firstDic valueForKey:@"username"];
            _originalView.PSW = [firstDic valueForKey:@"password"];
            _originalView.userType = [firstDic valueForKey:@"registertype"];
            
        }
    }
    
    
    
    
    
    
    
    
    
    [self.tableView reloadData];
    [self reloadUI];
}

-(void)reloadUI
{
    [self mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_currentView);
        if (_dataArr.count >= 3) {
            make.height.equalTo(_currentView.mas_height).multipliedBy(3.5);
        }else{
            make.height.mas_equalTo(_currentView.height * (_dataArr.count + 0.5));
        }
        make.top.equalTo(_currentView.mas_centerY);
        make.centerX.equalTo(_currentView.mas_centerX);
    }];
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (_dataArr.count >= 3) {
            make.height.equalTo(_currentView.mas_height).multipliedBy(3);
        }else{
            make.height.mas_equalTo(_currentView.height * _dataArr.count);
        }
        make.width.equalTo(self.mas_width);
        make.bottom.equalTo(self.mas_bottom);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LoginedCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSArray *userArr = [TYUserdefaults getUserMsgArr];
    for (int i = 0; i < userArr.count; i++) {
        NSDictionary *dic = [ChangeJsonOrString dictionaryWithJsonString:userArr[i]];
        if ([cell.accountLabel.text isEqualToString:[dic valueForKey:@"username"]]) {
            [_delegate LoginedFindUsername:cell.accountLabel.text AndPassword:[dic valueForKey:@"password"]  AnduserType:[dic valueForKey:@"registertype"]];
        }
    }
    
}


-(void)logined_hideListview:(UIView *)accountView{
    [self removeFromSuperview];
}


@end

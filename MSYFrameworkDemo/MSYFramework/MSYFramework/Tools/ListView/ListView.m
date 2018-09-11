//
//  ListView.m
//  TYSDK
//
//  Created by iOS on 2016/11/24.
//  Copyright © 2016年 iOS. All rights reserved.
//

#import "ListView.h"
#import "ListCell.h"
#import "ChangeJsonOrString.h"
#import "UIView+Extension.h"
#import "GetCurrentViewController.h"
#import "Masonry.h"
#import "TYUserdefaults.h"

@interface ListView() <UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,weak) UITextField *textField;
@property(nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic, assign) int row;
@end


@implementation ListView

-(id)initWithTextfield:(UITextField *)textfield DataArray:(NSArray *)arr
{
    
    

    self.textField = textfield;
    self.dataArr = [arr mutableCopy];
    
    if (self = [super init]) {

        
        [textfield.superview.superview.superview.superview addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(textfield.superview.mas_width);
            if (arr.count >= 3) {
                make.height.equalTo(textfield.mas_height).multipliedBy(3);
            }else
            {
                make.height.equalTo(textfield.mas_height).multipliedBy(arr.count);
            }
            
            make.top.equalTo(textfield.mas_bottom).with.offset(0);
            make.centerX.equalTo(textfield.superview.mas_centerX);
        }];
        
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        
        
        self.tableView.height = self.frame.size.height;
        
        
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.layer.cornerRadius = 4;
        self.tableView.backgroundColor = [UIColor orangeColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.bounces = NO;
        self.tableView.showsVerticalScrollIndicator = NO;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor colorWithRed:197.0f/255.0f green:197.0f/255.0f blue:197.0f/255.0f alpha:1] CGColor];
        
        
        
        [self addSubview:self.tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.mas_width);
            make.height.equalTo(self.mas_height);
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.textField.height;
    //return 44;
    //return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* indentifier = @"listcell";
    ListCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[ListCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:indentifier];
        cell.backgroundColor = [UIColor whiteColor];
    }
    if (indexPath.row == 0) {
        cell.firstImg.image = [UIImage imageNamed:@"TYBundle.bundle/first"];
        cell.firstImg.hidden = NO;
    }else{
        cell.firstImg.hidden = YES;
    }
    NSLog(@"数据源%@",_dataArr[indexPath.row]);
    
    NSDictionary *dic = [ChangeJsonOrString dictionaryWithJsonString:_dataArr[indexPath.row]];
    cell.phoneNum = dic[@"username"];
    cell.delegate = self;
    cell.row = indexPath.row;
    cell.btnX = self.tableView.width-40;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self hideListview:self.textField];
    
    ListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.textField.text = cell.usernameLabel.text;
    NSString *psw1 = [[ChangeJsonOrString dictionaryWithJsonString:_dataArr[indexPath.row]] valueForKey:@"password"];
    NSString *psw2 = [[ChangeJsonOrString dictionaryWithJsonString:_dataArr[indexPath.row]] valueForKey:@"verification"];
    NSString *password;
    if (psw1 == nil || psw1 == NULL) {
        password = psw2;
    }else
    {
        password = psw1;
    }
    
    [self.delegate findPassWord:password];
    
}




- (void)deletPhoneNumWithRow:(int)row{
    
    self.row = row;
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"确定要删除账号" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        
        
    }else{
        

        NSString *dicStr = self.dataArr[self.row];
        
        
        
        
        NSString *userid = [[ChangeJsonOrString dictionaryWithJsonString:dicStr] valueForKey:@"userid"];
        [self.dataArr removeObjectAtIndex:self.row];
        
        NSMutableArray *arr = [TYUserdefaults getUserMsgArr];
        for (NSString *string in arr) {
            if ([userid isEqualToString:[[ChangeJsonOrString dictionaryWithJsonString:string] valueForKey:@"userid"]]) {
                [arr removeObject:string];
            }
        }
        
        if (arr.count == 0) {
            [TYUserdefaults setFirstUserMsgForArr:@""];
            
        }else
        {
            [TYUserdefaults setFirstUserMsgForArr:[arr firstObject]];
            
        }
        
             

        
        

        
       
        [self.tableView reloadData];
        [self.delegate removeListView];
        
    }
}

-(void)hideListview:(UITextField *)text
{
    CGRect t = text.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.frame = CGRectMake(t.origin.x, text.superview.origin.y + t.size.height + 10, t.size.width, 0);
    
    self.tableView.frame = CGRectMake(0, 0, t.size.width, 0);
    
    
    [UIView commitAnimations];
}



@end

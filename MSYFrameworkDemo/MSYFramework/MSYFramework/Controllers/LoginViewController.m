//
//  LoginViewController.m
//  MSYFramework
//
//  Created by 郭臻 on 2017/12/28.
//  Copyright © 2017年 郭臻. All rights reserved.
//

#import "LoginViewController.h"
#import "FirstLoginView.h"
#import "AccountLoginView.h"
#import "TYUserdefaults.h"
#import "LoadingView.h"
#import "WelcomeView.h"
#import "LoginedView.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self regNotification];
    
    NSArray *userArr = [TYUserdefaults getUserMsgArr];
    if (userArr.count == 0) {
        FirstLoginView *firstview = [[FirstLoginView alloc] init];
        [self.view addSubview:firstview];
        [firstview layoutViewWithSuperView:self.view];
    }else{
//        AccountLoginView *accView = [[AccountLoginView alloc] init];
//        [self.view addSubview:accView];
//        [accView layoutAccountLoginViewWithSuperView:self.view];
        LoginedView *view = [[LoginedView alloc] init];
        [self.view addSubview:view];
        [view layoutLoginedViewWithSuperView:self.view];
    }
    
    
}

-(void)addGuestAndView{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapEndEdit2)];
    
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    bgView.backgroundColor = [UIColor clearColor];
    [bgView addGestureRecognizer:tap];
    [self.view addSubview:bgView];
}
- (void)viewTapEndEdit2{
    [self.view endEditing:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"thehidelist" object:nil];
}

- (void)regNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)unregNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - notification handler

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect beginKeyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat yOffset = endKeyboardRect.origin.y - beginKeyboardRect.origin.y;
    yOffset = yOffset*0.3;
    CGRect inputFieldRect = self.view.frame;
    
    
    inputFieldRect.origin.y += yOffset;
    
    
    [UIView animateWithDuration:duration animations:^{
        self.view.frame = inputFieldRect;
        
    }];
}



- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self unregNotification];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGuestAndView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

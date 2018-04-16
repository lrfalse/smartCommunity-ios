//
//  LoginDetailVC.m
//  LL_Community
//
//  Created by ox Ho on 2018/3/28.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "LoginDetailVC.h"
#import "LLoginDetailView.h"
#import "AppDelegate.h"
#import "LLoginForQQVC.h"
#import <ShareSDK/ShareSDK.h>
@interface LoginDetailVC ()

@property (nonatomic,strong)UIView *navView;//导航栏

@property (nonatomic, strong)UIView *homeView;

@property (nonatomic,strong)LLoginDetailView *loginDetailView;

@end

@implementation LoginDetailVC
//懒加载
- (LLoginDetailView *)loginDetailView
{
    if (!_loginDetailView) {
        _loginDetailView = [LLoginDetailView loadFromNib];
        
    }
    return _loginDetailView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingNav];
    [self initializationHomeView];
        [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
        [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
}

//设置自定义导航栏
- (void)settingNav
{
    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectW(self.view), 64)];
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.navBar];
    self.navBar.titleLB.text = @"忘记密码";
    [self.navBar setingNavSize:self.navView];
    
//    self.navBar.backBtn.hidden = ;
    
}

//初始化界面
- (void)initializationHomeView {
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.homeView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, CGRectW(self.view), CGRectH(self.view) - 64)];
    self.homeView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.homeView];
    
    [self.homeView addSubview:self.loginDetailView];
    [self.loginDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.homeView);
        make.left.mas_equalTo(self.homeView);
        make.size.mas_equalTo(self.homeView);
    }];
    
    [self.loginDetailView.loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];//登陆按钮点击事件
    [self.loginDetailView.WeChatBtn addTarget:self action:@selector(WeChatBtnClick:) forControlEvents:UIControlEventTouchUpInside];//微信按钮点击事件
    [self.loginDetailView.qqBtn addTarget:self action:@selector(qqBtnClick:) forControlEvents:UIControlEventTouchUpInside];//QQ按钮点击事件
}

#pragma mark - 登陆按钮点击事件
- (void)loginBtnClick:(UIButton *)sender
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.loginDetailView.phoneNumTF.text forKey:@"phoneNum"];
    [dic setObject:self.loginDetailView.PasswordTF.text forKey:@"password"];

    NSData *loginData = [NSKeyedArchiver archivedDataWithRootObject:dic];
    
    NSUserDefaults *userdata = [NSUserDefaults standardUserDefaults];
    [userdata setObject:loginData forKey:@"KeyUserInfo"];
    AppDelegate * delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate jump];
}

#pragma mark - 微信按钮点击事件
- (void)WeChatBtnClick:(UIButton *)sender
{
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}

#pragma mark - QQ按钮点击事件
- (void)qqBtnClick:(UIButton *)sender
{
//    LLoginForQQVC *vc = [[LLoginForQQVC alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];

    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];

}
@end

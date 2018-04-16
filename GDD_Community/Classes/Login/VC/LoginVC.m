//
//  LoginVC.m
//  GDD_Community
//
//  Created by HYIT on 2018/3/14.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "LoginVC.h"
#import "LLoginView.h"
#import "LoginDetailVC.h"
#import "LLRegisteredVC.h"
@interface LoginVC ()

@property (nonatomic,strong)UIView *navView;//导航栏

@property (nonatomic, strong)UIView *homeView;
@property (nonatomic,strong)LLoginView *loginView;
@end

@implementation LoginVC
//懒加载
- (LLoginView *)loginView
{
    if (!_loginView) {
        _loginView = [LLoginView loadFromNib];
        
    }
    return _loginView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    
    [self settingNav];
    [self initializationHomeView];
    
    
    
    // 是否安装微信
    BOOL wechat = [[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"mqqapi://"]];
    // 是否安装QQ
    BOOL qq = [[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"weixin://"]];
    NSLog(@"~~~");
}
//设置自定义导航栏
- (void)settingNav
{
    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectW(self.view), 64)];
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.navBar];
    self.navBar.titleLB.text = @"去逛逛";
    [self.navBar setingNavSize:self.navView];
    self.navBar.backBtn.hidden = YES;
    
}

//初始化界面
- (void)initializationHomeView {
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.homeView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, CGRectW(self.view), CGRectH(self.view) - 64)];
    self.homeView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.homeView];
    
    [self.homeView addSubview:self.loginView];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.homeView);
        make.left.mas_equalTo(self.homeView);
        make.size.mas_equalTo(self.homeView);
    }];
    
    [self.loginView.loginBtn addTarget:self action:@selector(loginBtnClick:) forControlEvents:UIControlEventTouchUpInside];//登陆按钮点击事件
    [self.loginView.registeredBtn addTarget:self action:@selector(registeredBtnClick:) forControlEvents:UIControlEventTouchUpInside];//注册点击事件
    
    //    [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
}

#pragma mark - 登录按钮点击事件
- (void)loginBtnClick:(UIButton *)sender
{
    LoginDetailVC *vc = [LoginDetailVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 注册按钮点击事件
- (void)registeredBtnClick:(UIButton *)sender
{
    LLRegisteredVC *vc = [LLRegisteredVC new];
    [self.navigationController pushViewController:vc animated:YES];
}
@end

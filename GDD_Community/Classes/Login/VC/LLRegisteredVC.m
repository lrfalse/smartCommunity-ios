//
//  LLRegisteredVC.m
//  LL_Community
//
//  Created by ox Ho on 2018/3/28.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "LLRegisteredVC.h"
#import "LLRegisteredView.h"
#import "LLCreatePasswordVC.h"
#import <SMS_SDK/SMSSDK.h>
@interface LLRegisteredVC ()

@property (nonatomic,strong)UIView *navView;//导航栏

@property (nonatomic, strong)UIView *homeView;

@property (nonatomic,strong)LLRegisteredView *registeredView;

@property (nonatomic,assign)NSInteger count;//倒计时
@property (nonatomic,strong)NSTimer *timer;//计时器
@end

@implementation LLRegisteredVC
//懒加载
- (LLRegisteredView *)registeredView
{
    if (!_registeredView) {
        _registeredView = [LLRegisteredView loadFromNib];
//        [_registeredView.sendCodeBtn addTarget:self action:@selector(sendCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _registeredView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingNav];
    [self initializationHomeView];
}

//设置自定义导航栏
- (void)settingNav
{
    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectW(self.view), 64)];
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.navBar];
//    self.navBar.titleLB.text = @"忘记密码";
    [self.navBar setingNavSize:self.navView];
    self.navBar.titleLB.hidden = YES;
    //    self.navBar.backBtn.hidden = ;
    
}
//初始化界面
- (void)initializationHomeView {
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.homeView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, CGRectW(self.view), CGRectH(self.view) - 64)];
    self.homeView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.homeView];
    
    [self.homeView addSubview:self.registeredView];
    [self.registeredView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.homeView);
        make.left.mas_equalTo(self.homeView);
        make.size.mas_equalTo(self.homeView);
    }];
    
    [self.registeredView.sendCodeBtn addTarget:self action:@selector(sendCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];//发送验证码按钮点击事件
    
    [self.registeredView.nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];//下一步按钮点击事件
}

#pragma mark - 发送验证码按钮点击事件
- (void)sendCodeBtnClick:(UIButton *)sender
{
    if (![LLRegex validateMobile:self.registeredView.phoneNumTF.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号"];
        
        return;
    }
    
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.registeredView.phoneNumTF.text zone:@"86"  result:^(NSError *error) {
        
        if (!error)
        {
            // 请求成功
            self.count = 60;
            self.registeredView.sendCodeBtn.enabled = NO;
            
            // 加1个计时器
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
        }
        else
        {
            // error
            NSLog(@"error == %@",error);
        }
    }];
    
}
#pragma mark - 下一步按钮点击事件
- (void)nextBtnClick:(UIButton *)sender
{
    LLCreatePasswordVC *vc = [LLCreatePasswordVC new];
    [self.navigationController pushViewController:vc animated:YES];
}


//计时器方法
- (void)timerFired {
    if (self.count != 1) {
        self.count -= 1;
        self.registeredView.sendCodeBtn.enabled = NO;
        [self.registeredView.sendCodeBtn setTitle:[NSString stringWithFormat:@"%lds", self.count] forState:UIControlStateNormal];
        [self.registeredView.sendCodeBtn setBackgroundColor:[UIColor grayColor]];
        //       [self setTitle:[NSString stringWithFormat:@"剩余%ld秒", self.count] forState:UIControlStateDisabled];
    } else {
        //        [self.forgetPasswordView.VerifyBtn setBackgroundColor:[UIColor colorWithRed:232/255.f green:185/255.f blue:95/255.f alpha:1.f]];
        [self.registeredView.sendCodeBtn setBackgroundColor:RGBACOLOR(234, 100, 123, 1)];
        self.registeredView.sendCodeBtn.enabled = YES;
        [self.registeredView.sendCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        // 停掉定时器
        [self.timer invalidate];
        self.timer = nil;
    }
}
@end

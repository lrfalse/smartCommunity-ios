//
//  LLCreatePasswordVC.m
//  LL_Community
//
//  Created by ox Ho on 2018/3/28.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "LLCreatePasswordVC.h"
#import "LLCreatePasswordView.h"
#import "LLSelectCommunity.h"
@interface LLCreatePasswordVC ()

@property (nonatomic,strong)UIView *navView;//导航栏

@property (nonatomic, strong)UIView *homeView;

@property (nonatomic,strong)LLCreatePasswordView *createPasswordView;

@end

@implementation LLCreatePasswordVC
//懒加载
- (LLCreatePasswordView *)createPasswordView
{
    if (!_createPasswordView) {
        _createPasswordView = [LLCreatePasswordView loadFromNib];
        
    }
    return _createPasswordView;
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
    
    [self.homeView addSubview:self.createPasswordView];
    [self.createPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.homeView);
        make.left.mas_equalTo(self.homeView);
        make.size.mas_equalTo(self.homeView);
    }];
    
    [self.createPasswordView.nextBtn addTarget:self action:@selector(nextBtnClick:) forControlEvents:UIControlEventTouchUpInside];//下一步按钮点击事件

}

#pragma mark - 下一步按钮点击事件
- (void)nextBtnClick:(UIButton *)sender
{
    LLSelectCommunity *vc = [LLSelectCommunity new];
    [self.navigationController pushViewController:vc animated:YES];
}
@end

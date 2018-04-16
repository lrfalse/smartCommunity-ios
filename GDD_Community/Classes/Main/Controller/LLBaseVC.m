//
//  LLBaseVC.m
//  LL_Community
//
//  Created by ox Ho on 2018/3/28.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "LLBaseVC.h"
#import "LLEnvelopeView.h"
#import "PlusAnimate.h"
#import "LLQrCodeView.h"
#import "LLPassWordView.h"
#import "LLShakeView.h"
#import "LLRemoteView.h"
@interface LLBaseVC ()<PublishAnimateDelegate>

@property (nonatomic, strong)UIView *showView;
@property (nonatomic,strong)LLEnvelopeView *envelopeView;

@property (nonatomic,strong)UITapGestureRecognizer *recognizer;

@property (nonatomic,strong)LLQrCodeView *qrCodeView;

@property (nonatomic,strong)LLPassWordView *passWordView;

@property (nonatomic,strong)LLShakeView *shakeView;

@property (nonatomic,strong)LLRemoteView *remoteView;
@end

@implementation LLBaseVC
//懒加载
- (LLRemoteView *)remoteView
{
    if (!_remoteView) {
        
        _remoteView = [LLRemoteView loadFromNib];
    }
    return _remoteView;
}
- (LLShakeView *)shakeView
{
    if (!_shakeView) {
        
        _shakeView = [LLShakeView loadFromNib];
    }
    return _shakeView;
}
//懒加载
- (LLPassWordView *)passWordView
{
    if (!_passWordView) {
        
        _passWordView = [LLPassWordView loadFromNib];
    }
    return _passWordView;
}
- (LLQrCodeView *)qrCodeView
{
    if (!_qrCodeView) {
        
        _qrCodeView = [LLQrCodeView loadFromNib];
    }
    return _qrCodeView;
}
- (LLEnvelopeView *)envelopeView
{
    if (!_envelopeView) {
        
        _envelopeView = [LLEnvelopeView loadFromNib];
    }
    return _envelopeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    self.navBar = [LLNavView loadFromNib];
    
    [self.navBar.backBtn addTarget:self action:@selector(backBtnMehtod:) forControlEvents:UIControlEventTouchUpInside];
//    [self.navBar.backBtn addTarget:self action:@selector(backBtnMehtod:) forControlEvents:UIControlEventTouchUpInside];
    
    //注册通知
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSelectView:)name:@"clickTag" object:nil];
}

- (void)backBtnMehtod:(UIButton*)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showEnvelope{
    
    [self initializationHomeVieww];
    
}
//初始化界面
- (void)initializationHomeVieww{
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    self.view.backgroundColor = RGBACOLOR(233, 233, 233, 0.5f);
    self.showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,305.5f, 390.f)];
    self.showView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    self.showView.backgroundColor = [UIColor orangeColor];
    self.showView.clipsToBounds = YES;
    [self.view addSubview:self.showView];

    
    [self.showView addSubview:self.envelopeView];
    [self.envelopeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.showView);
        make.left.mas_equalTo(self.showView);
        make.size.mas_equalTo(self.showView);
    }];
    
    //点击手势
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTapChange:)];
    recognizer.numberOfTapsRequired = 1;
    [self.showView addGestureRecognizer:recognizer];
}
//点击
-(void)doTapChange:(UITapGestureRecognizer *)sender{
    
    [self.showView removeFromSuperview];
    self.envelopeView.openBtn.alpha = 1;
}
- (void)showSelectView:(NSNotification *)text{
    
    NSLog(@"%@",text.object[@"tag"]);
    NSString *taag = text.object[@"tag"];
    if ([taag isEqualToString:@"0"]) {
        [self initializationQrCodeView];
    }else if ([taag isEqualToString:@"1"]){
        [self initializationPassWordView];
    }else if ([taag isEqualToString:@"2"]){
        [self initializationShakeView];
    }else if ([taag isEqualToString:@"3"]){
        [self initializationRemoteView];
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:text name:nil object:self];
}
//二维码
- (void)initializationQrCodeView{
    NSLog(@"二维码开门");
    
//    self.view.backgroundColor = RGBACOLOR(233, 233, 233, 0.5f);
    self.showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,305.5f, 390.f)];
//    self.showView.backgroundColor = RGBACOLOR(233, 233, 233, 0.1f);
    self.showView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
//    self.showView.backgroundColor = [UIColor orangeColor];
    self.showView.clipsToBounds = YES;
    [self.view addSubview:self.showView];
    
    
    [self.showView addSubview:self.qrCodeView];
    self.qrCodeView.backgroundColor = RGBACOLOR(233, 233, 233, 1);
    [self.qrCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.showView);
        make.left.mas_equalTo(self.showView);
        make.size.mas_equalTo(self.showView);
    }];
    
    //点击手势
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTapChange:)];
    recognizer.numberOfTapsRequired = 1;
    [self.showView addGestureRecognizer:recognizer];
}
//密码passWordView
- (void)initializationPassWordView{
    NSLog(@"密码开门");
    
    //    self.view.backgroundColor = RGBACOLOR(233, 233, 233, 0.5f);
    self.showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,305.5f, 390.f)];
    //    self.showView.backgroundColor = RGBACOLOR(233, 233, 233, 0.1f);
    self.showView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    //    self.showView.backgroundColor = [UIColor orangeColor];
    self.showView.clipsToBounds = YES;
    [self.view addSubview:self.showView];
    
    
    [self.showView addSubview:self.passWordView];
    self.passWordView.backgroundColor = RGBACOLOR(233, 233, 233, 1);
    [self.passWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.showView);
        make.left.mas_equalTo(self.showView);
        make.size.mas_equalTo(self.showView);
    }];
    
    //点击手势
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTapChange:)];
    recognizer.numberOfTapsRequired = 1;
    [self.showView addGestureRecognizer:recognizer];
}
//摇一摇
- (void)initializationShakeView{
    NSLog(@"摇一摇开门");
    //    self.view.backgroundColor = RGBACOLOR(233, 233, 233, 0.5f);
    self.showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,305.5f, 390.f)];
    //    self.showView.backgroundColor = RGBACOLOR(233, 233, 233, 0.1f);
    self.showView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    //    self.showView.backgroundColor = [UIColor orangeColor];
    self.showView.clipsToBounds = YES;
    [self.view addSubview:self.showView];
    
    
    [self.showView addSubview:self.shakeView];
    self.shakeView.backgroundColor = RGBACOLOR(233, 233, 233, 1);
    [self.shakeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.showView);
        make.left.mas_equalTo(self.showView);
        make.size.mas_equalTo(self.showView);
    }];
    
    //点击手势
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTapChange:)];
    recognizer.numberOfTapsRequired = 1;
    [self.showView addGestureRecognizer:recognizer];
}

//远程
- (void)initializationRemoteView{
    NSLog(@"远程开门");
    self.showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,305.5f, 390.f)];
    //    self.showView.backgroundColor = RGBACOLOR(233, 233, 233, 0.1f);
    self.showView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame));
    //    self.showView.backgroundColor = [UIColor orangeColor];
    self.showView.clipsToBounds = YES;
    [self.view addSubview:self.showView];
    
    
    [self.showView addSubview:self.remoteView];
    self.remoteView.backgroundColor = RGBACOLOR(233, 233, 233, 1);
    [self.remoteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.showView);
        make.left.mas_equalTo(self.showView);
        make.size.mas_equalTo(self.showView);
    }];
    
    //点击手势
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTapChange:)];
    recognizer.numberOfTapsRequired = 1;
    [self.showView addGestureRecognizer:recognizer];
}
@end

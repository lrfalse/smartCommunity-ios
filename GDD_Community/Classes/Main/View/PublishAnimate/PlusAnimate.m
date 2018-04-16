//
//  PublishAnimate.m
//  ZCYTabBar
//
//  Created by 张春雨 on 16/8/17.
//  Copyright © 2016年 张春雨. All rights reserved.
//

#import "PlusAnimate.h"
#import "LLQrCodeView.h"
#import "LLPassWordView.h"
#import "LLShakeView.h"
#import "LLRemoteView.h"
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#define CenterPoint CGPointMake(W/2 ,H-38.347785)
#define bl [[UIScreen mainScreen]bounds].size.width/375
#define Color(r, g, b , a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface PlusAnimate()
//center button
@property (strong , nonatomic) UIButton* CenterBtn;
//other function button
@property (strong , nonatomic) NSMutableArray* BtnItem;
@property (strong , nonatomic) NSMutableArray* BtnItemTitle;
/** rect */
@property (nonatomic,assign) CGRect rect;

@property (nonatomic, strong)UIView *showView;

@property (nonatomic,strong)LLQrCodeView *qrCodeView;

@property (nonatomic,strong)LLPassWordView *passWordView;

@property (nonatomic,strong)LLShakeView *shakeView;

@property (nonatomic,strong)LLRemoteView *remoteView;
@end

@implementation PlusAnimate
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
//- (LLEnvelopeView *)envelopeView
//{
//    if (!_envelopeView) {
//
//        _envelopeView = [LLEnvelopeView loadFromNib];
//    }
//    return _envelopeView;
//}
/**
 *  show view
 */
- (void)standardPublishAnimateWithView:(UIView *)view plusanimate:(PlusAnimate *)animateView{
//    PlusAnimate * animateView = [[PlusAnimate alloc]init];
    CGFloat h = ((UIView *)[view valueForKeyPath:@"imageView"]).frame.size.height;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:animateView];
    CGRect rect = [animateView convertRect:view.frame fromView:view.superview];
    rect.origin.y += 5;
    rect.size.height = 40;
    rect.origin.x += (rect.size.width-rect.size.height)/2;
    rect.size.width = 40;
    animateView.rect = rect;
    
//    animateView.delegate = self;
    //Add button
    [animateView CrentBtnImageName:@"erweima" Title:@"" tag:0];
    [animateView CrentBtnImageName:@"mimam" Title:@"" tag:1];
    [animateView CrentBtnImageName:@"yaoyiyao" Title:@"" tag:2];
    [animateView CrentBtnImageName:@"yuancheng" Title:@"" tag:3];
    //Add center button
    [animateView CrentCenterBtnImageName:@"yaoshi" tag:4];
    //Do animation
    [animateView AnimateBegin];
//    return animateView;
}

- (instancetype)init{
    self = [super init];
    if (self)
    {
        self.frame = [[UIScreen mainScreen]bounds];
        self.backgroundColor =[[UIColor lightGrayColor]colorWithAlphaComponent:0.8f];
        
//        UIBlurEffect *blurEffect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//        UIVisualEffectView *visualEffectView=[[UIVisualEffectView alloc]initWithEffect:blurEffect];
//        [visualEffectView setFrame:self.bounds];
//        [self addSubview:visualEffectView];
        
    }
    return self;
}

/**
 *  creat button
 */
- (void)CrentBtnImageName:(NSString *)ImageName Title:(NSString *)Title tag:(int)tag{
    if (_BtnItem.count >= 4)  return;
    CGRect rect = self.rect;
    rect.size = CGSizeMake(rect.size.width-10, rect.size.height-10);
    rect.origin = CGPointMake(rect.origin.x+5, rect.origin.y+5);
    UIButton * btn = [[UIButton alloc]initWithFrame:rect];
    btn.tag = tag;
    [btn setImage:[UIImage imageNamed:ImageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:btn];
    [self.BtnItem addObject:btn];
    [self.BtnItemTitle addObject:[self CrenterBtnTitle:Title]];
}

/**
 *  creat center button
 */
- (void)CrentCenterBtnImageName:(NSString *)ImageName tag:(int)tag{
    _CenterBtn = [[UIButton alloc]initWithFrame:self.rect];
    _CenterBtn.frame = CGRectMake(self.rect.origin.x - 7, self.rect.origin.y + 1 , 55, 55);
    
    [_CenterBtn setImage:[UIImage imageNamed:ImageName] forState:UIControlStateNormal];
    [_CenterBtn addTarget:self action:@selector(cancelAnimation) forControlEvents:UIControlEventTouchUpInside];
    _CenterBtn.tag = tag;
    [self addSubview:_CenterBtn];
}

/**
 *  getter
 */
- (NSMutableArray *)BtnItem{
    if (!_BtnItem) {
        _BtnItem = [NSMutableArray array];
    }
    return _BtnItem;
}
- (NSMutableArray *)BtnItemTitle{
    if (!_BtnItemTitle) {
        _BtnItemTitle = [NSMutableArray array];
    }
    return _BtnItemTitle;
}
- (UILabel *)CrenterBtnTitle:(NSString *)Title{
    UILabel * lab = [[UILabel alloc]init];
    lab.textColor = Color(240, 240, 240,1);
    lab.font = [UIFont italicSystemFontOfSize:13.5*bl];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = Title;
    [self addSubview:lab];
    return lab;
}

/**
 *  remove view and notice the selectIndex
 */
- (void)removeView:(UIButton*)btn{
    [self removeFromSuperview];
    [self.delegate didSelectBtnWithBtnTag:btn.tag];
}

/**
 *  click other space to cancle
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelAnimation];
}

/**
 *  button click
 */
- (void)BtnClick:(UIButton*)btn{
//    [self.delegate didSelectBtnWithBtnTag:btn.tag];
   
    
    if( [self.delegate respondsToSelector:@selector(didSelectBtnWithBtnTag:)] ){
        [self.delegate didSelectBtnWithBtnTag:btn.tag];
    }
    [self initializationHomeViewWithtag:btn.tag];
    #pragma mark - menu点击
    [UIView animateWithDuration:0.1 animations:^{
        _CenterBtn.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        //move
        int n = (int)_BtnItem.count;
        for (int i = n-1; i>=0; i--){
            UIButton *btn = _BtnItem[i];
            [btn removeFromSuperview];
            if (i==0) {
//                    [self removeFromSuperview];
            }
        }
    }];
}


/**
 *  Do animation
 */
- (void)AnimateBegin{
    //centet button rotation
    [_CenterBtn setImage:[UIImage imageNamed:@"chaa"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.2 animations:^{
        _CenterBtn.transform = CGAffineTransformMakeRotation(-M_PI_4-M_LOG10E);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            _CenterBtn.transform = CGAffineTransformMakeRotation(-M_PI_4+M_LOG10E);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                _CenterBtn.transform = CGAffineTransformMakeRotation(0);
            }];
        }];
    }];
    
    
    __block int  i = 0 , k = 0;
    for (UIView *  btn in _BtnItem) {
        //rotation
        [UIView animateWithDuration:0.7 delay:i*0.14 usingSpringWithDamping:0.46 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            btn.transform = CGAffineTransformScale(btn.transform, 1.2734*bl, 1.2734*bl);//缩放
//            btn.center = CGPointMake((74+i*113)*bl, self.frame.size.height-165*bl);
            if (i == 0) {
                btn.center = CGPointMake(120, self.frame.size.height - 80*bl);
            }else if(i == 1){
                btn.center = CGPointMake(170, self.frame.size.height - 110*bl);
            }else if(i == 2){
                btn.center = CGPointMake(230, self.frame.size.height - 110*bl);
            }else if(i == 3){
                btn.center = CGPointMake(280, self.frame.size.height - 80*bl);
            }
            i ++;
        } completion:nil];

        //move
        [UIView animateWithDuration:0.2 delay:i*0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            btn.transform = CGAffineTransformRotate (btn.transform, -M_2_PI);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                btn.transform = CGAffineTransformRotate (btn.transform, M_2_PI+M_LOG10E);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
                    btn.transform = CGAffineTransformRotate (btn.transform, -M_LOG10E);
                } completion:^(BOOL finished) {
//                    UILabel * lab = (UILabel *)_BtnItemTitle[k++];
//                    lab.frame = CGRectMake(0, 0, W/3-30, 30);
//                    lab.center = CGPointMake(btn.center.x, CGRectGetMaxY(btn.frame)+10);
                }];
            }];
        }];
    }
    

}


/**
 *  Cancle animation
 */
- (void)cancelAnimation{
    //rotation
    [UIView animateWithDuration:0.1 animations:^{
        _CenterBtn.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        //move
        int n = (int)_BtnItem.count;
        for (int i = n-1; i>=0; i--){
            UIButton *btn = _BtnItem[i];
            [UIButton animateWithDuration:0.2 delay:0.1*(n-i) options:UIViewAnimationOptionTransitionCurlDown animations:^{
                btn.center = self.CenterBtn.center;
                btn.transform = CGAffineTransformMakeScale(1, 1);
                btn.transform = CGAffineTransformRotate(btn.transform, -M_PI_4);
                
                UILabel * lab = (UILabel *)_BtnItemTitle[i];
                [lab removeFromSuperview];
            } completion:^(BOOL finished) {
                [btn removeFromSuperview];
                if (i==0) {
                    [self removeFromSuperview];
                }
            }];
        }
    }];
    
}
//初始化界面
- (void)initializationHomeViewWithtag:(NSInteger)tag{
    //    [self.navigationController setNavigationBarHidden:YES animated:YES];
    //    self.view.backgroundColor = RGBACOLOR(233, 233, 233, 0.5f);
    self.showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,305.5f, 390.f)];
    self.showView.center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    self.showView.backgroundColor = [UIColor whiteColor];
    self.showView.clipsToBounds = YES;
    [self addSubview:self.showView];
    switch (tag) {
        case 1:
        {
                [self initializationQrCodeView];
        }
            break;
        case 2:
        {
                [self initializationPassWordView];
        }
            break;
        case 3:
        {
                [self initializationShakeView];
        }
            break;
        case 4:
        {
                [self initializationRemoteView];
        }
            break;
        default:
            break;
    }
    
}
//二维码
- (void)initializationQrCodeView{
    NSLog(@"二维码开门");
    
    [self.showView addSubview:self.qrCodeView];
    self.qrCodeView.backgroundColor = RGBACOLOR(233, 233, 233, 1);
    [self.qrCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.showView);
        make.left.mas_equalTo(self.showView);
        make.size.mas_equalTo(self.showView);
    }];
    
}
//密码passWordView
- (void)initializationPassWordView{
    NSLog(@"密码开门");
    [self.showView addSubview:self.passWordView];
    self.passWordView.backgroundColor = RGBACOLOR(233, 233, 233, 1);
    [self.passWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.showView);
        make.left.mas_equalTo(self.showView);
        make.size.mas_equalTo(self.showView);
    }];
}
//摇一摇
- (void)initializationShakeView{
    NSLog(@"摇一摇开门");
    
    [self.showView addSubview:self.shakeView];
    self.shakeView.backgroundColor = RGBACOLOR(233, 233, 233, 1);
    [self.shakeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.showView);
        make.left.mas_equalTo(self.showView);
        make.size.mas_equalTo(self.showView);
    }];
}

//远程
- (void)initializationRemoteView{
    NSLog(@"远程开门");
    [self.showView addSubview:self.remoteView];
    self.remoteView.backgroundColor = RGBACOLOR(233, 233, 233, 1);
    [self.remoteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.showView);
        make.left.mas_equalTo(self.showView);
        make.size.mas_equalTo(self.showView);
    }];
}
@end

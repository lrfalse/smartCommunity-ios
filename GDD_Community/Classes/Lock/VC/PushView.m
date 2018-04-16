//
//  PushView.m
//  GDD_Community
//
//  Created by HYIT on 2018/3/15.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "PushView.h"
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#define CenterPoint CGPointMake(W/2 ,H-38.347785)
#define bl [[UIScreen mainScreen]bounds].size.width/375
#define Color(r, g, b , a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
@interface PushView()
{
    NSMutableDictionary *PointsDic;
    NSMutableArray *PointsAry;
}
//center button
@property (strong , nonatomic) UIButton* CenterBtn;
//other function button
@property (strong , nonatomic) NSMutableArray* BtnItem;
@property (strong , nonatomic) NSMutableArray* BtnItemTitle;


@property (nonatomic,strong) UIView *backHomeView;//幕布
/** rect */
//@property (nonatomic,assign) CGRect rect;

@end
@implementation PushView

/**
 *  show view
 */
+ (PushView *)standardPublishAnimateWithView:(UIView *)view{
    PushView * animateView = [[PushView alloc]init];
//    animateView.backgroundColor = [UIColor lightGrayColor];
//    animateView.alpha = 0.3f;
    CGFloat h = 44.f;
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:animateView];
    CGRect rect = [animateView convertRect:view.frame fromView:view.superview];
    rect.origin.y += 5;
    rect.size.height = h;
    rect.origin.x += (rect.size.width-rect.size.height)/2;
    rect.size.width = h;
    animateView.rect = rect;
    
    //Add button
    [animateView CrentBtnImageName:@"erweima" Title:@"" tag:0];
    [animateView CrentBtnImageName:@"mimam" Title:@"" tag:1];
    [animateView CrentBtnImageName:@"yaoyiyao" Title:@"" tag:2];
    [animateView CrentBtnImageName:@"yuancheng" Title:@"" tag:3];
    //Add center button
    [animateView CrentCenterBtnImageName:@"post_animate_add" tag:4];
    //Do animation
    [animateView AnimateBegin];
    return animateView;
}

- (instancetype)init{
    self = [super init];
    if (self)
    {
        self.frame = [[UIScreen mainScreen]bounds];
        self.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0.3f];
        PointsDic = [NSMutableDictionary dictionary];
        PointsAry = [NSMutableArray array];
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
    
    
//    for (int i = 0; i < _BtnItem.count; i++) {
//        NSLog(@"~~~~~~!!!!!!~~~");
//    }
    rect.size = CGSizeMake(rect.size.width-10, rect.size.height-10);
    rect.origin = CGPointMake(rect.origin.x+5, rect.origin.y+5);
    UIButton * btn = [[UIButton alloc]initWithFrame:rect];
    btn.tag = tag;
    [btn setImage:[UIImage imageNamed:ImageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    for (int i = 0; i < _BtnItem.count; i++) {
//        NSLog(@"~~~~~~!!!!!!~~~");
        CGPoint center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
//        [PointsAry addObject:center];
        NSLog(@"centers:%@", NSStringFromCGPoint(center));
        [PointsDic setObject:[NSValue valueWithCGPoint:center]
                      forKey:[NSString stringWithFormat:@"center%d", i + 1]];
        NSLog(@"PointsDic:%@", PointsDic);
    }
    [self addSubview:btn];
    [self.BtnItem addObject:btn];
    if (Title.length > 0) {
      [self.BtnItemTitle addObject:[self CrenterBtnTitle:Title]];
    }
    
}

/**
 *  creat center button
 */
- (void)CrentCenterBtnImageName:(NSString *)ImageName tag:(int)tag{
    _CenterBtn = [[UIButton alloc]initWithFrame:self.rect];
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
    switch (btn.tag) {
        case 0:
            {
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = @"摇一摇开门";
                [hud hide:YES afterDelay:2.f];
                [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0f];
            }
            break;
        case 1:
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"远程开门";
            [hud hide:YES afterDelay:2.f];
            [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0f];
        }
            break;
        case 2:
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"人脸识别开门";
            [hud hide:YES afterDelay:2.f];
            [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0f];
        }
            break;
        case 3:
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"扫码开门";
            [hud hide:YES afterDelay:2.f];
            [self performSelector:@selector(delayMethod) withObject:nil afterDelay:1.0f];
        }
            break;
        default:
            break;
    }
    
}


/**
 *  Do animation
 */
- (void)AnimateBegin{
    //centet button rotation
    [UIView animateWithDuration:0.2 animations:^{
        _CenterBtn.transform = CGAffineTransformMakeRotation(-M_PI_4-M_LOG10E);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            _CenterBtn.transform = CGAffineTransformMakeRotation(-M_PI_4+M_LOG10E);
        }completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                _CenterBtn.transform = CGAffineTransformMakeRotation(-M_PI_4);
            }];
        }];
    }];
    int j = 0;
    for (UIView *btnn in _BtnItem) {
        if (j == 0) {
            CGPoint cc = btnn.center;
            cc.x = CGRectGetMidX(self.frame) - 70;
            cc.y = CGRectGetMaxY(self.frame) - 80;
            j ++;
            btnn.center = cc;
            NSLog(@"=== %d",j);
        }else if (j == 1){
            CGPoint cc = btnn.center;
            cc.x = CGRectGetMidX(self.frame) - 30;
            cc.y = CGRectGetMaxY(self.frame) - 120;
            j ++;
            btnn.center = cc;
            NSLog(@"=== %d",j);
        }else if (j == 2){
            CGPoint cc = btnn.center;
            cc.x = CGRectGetMidX(self.frame) + 30;
            cc.y = CGRectGetMaxY(self.frame) - 120;
            j ++;
            btnn.center = cc;
            NSLog(@"=== %d",j);
        }else if (j == 3){
            CGPoint cc = btnn.center;
            cc.x = CGRectGetMidX(self.frame) + 70;
            cc.y = CGRectGetMaxY(self.frame) - 80;
            j ++;
            btnn.center = cc;
            NSLog(@"=== %d",j);
        }
        
    }
    
    __block int  i = 0 , k = 0, x1 = 0,x2 = 0 ,x3 =0 ;
    for (UIView *  btn in _BtnItem) {
        //rotation
        [UIView animateWithDuration:0.7 delay:i*0.14 usingSpringWithDamping:0.46 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            btn.transform = CGAffineTransformScale(btn.transform, 1.2734*bl, 1.2734*bl);//缩放
//            btn.center = CGPointMake((CGRectGetMidX(self.frame) - btn.frame.size.width * 2 - 20+i++*70)*bl, CGRectGetMaxY(self.frame)-120*bl);
//            btn.center = CGPointMake(100, 100);
            
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
- (void)delayMethod
{
[self removeFromSuperview];
}
@end

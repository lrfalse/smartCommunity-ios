//
//  LLEnvelopeView.m
//  LL_Community
//
//  Created by ox Ho on 2018/4/8.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "LLEnvelopeView.h"
@interface LLEnvelopeView()

@property (nonatomic,strong) UIImageView *dingView;
@property (nonatomic,strong) UIImageView *diView;
@property (assign ,nonatomic) CGRect screen;
@end


@implementation LLEnvelopeView
- (IBAction)openBtnClick:(UIButton *)sender {
    
    
    [UIView animateWithDuration:0.9 animations:^{
        CGRect rectBootom = self.bottomView.frame;
        rectBootom.origin.y += 60;
        self.bottomView.frame = rectBootom;
        
        CGRect rectTop = self.topView.frame;
        rectTop.origin.y -= 121;
        self.topView.frame = rectTop;
        
//        CGRect rectTop = self.topView.frame;
//        rectTop.origin.y -= 121;
//        self.topView.frame = rectTop;
        
        CGRect rectTopp = self.headView.frame;
        rectTopp.origin.y += 60;
        self.headView.frame = rectTopp;
        
        CGRect rectToppp = self.shopName.frame;
        rectToppp.origin.y += 60;
        self.shopName.frame = rectToppp;
        
        self.openBtn.alpha = 0;
    } completion:^(BOOL finished) {
        
    }];
    
}

//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
//        
//        self.dingView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 300, 100)];
////        self.dingView.center = CGPointMake(CGRectGetMidX(self.window.frame), CGRectGetMidY(self.window.frame));
//        self.dingView.image = [UIImage imageNamed:@"hongbaoding"];
//        [self addSubview:self.dingView];
//
//
//    }
//    return self;
//}

@end

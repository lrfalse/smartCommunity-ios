//
//  GDDTabBar.m
//  GDD_Community
//
//  Created by HYIT on 2018/3/14.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "GDDTabBar.h"
#import "UIView+Extension.h"
#import "KYGooeyMenu.h"
#import "Menu.h"
#import "LockBtn.h"
@interface GDDTabBar()
@property (nonatomic, weak) UIButton *plusBtn;
@end
@implementation GDDTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
       

        
        // 添加一个按钮到tabbar中
        UIButton *plusBtn = [[UIButton alloc] init];
        
        
        [plusBtn setImage:[UIImage imageNamed:@"yaoshi"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"yaoshi"] forState:UIControlStateHighlighted];
//        plusBtn.backgroundColor = [UIColor cyanColor];
//        plusBtn.size = plusBtn.currentBackgroundImage.size;
        plusBtn.size = CGSizeMake(60, 60);
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        self.userInteractionEnabled = YES;
        plusBtn.clipsToBounds = NO;
        plusBtn.alpha = 1;
//        self.clipsToBounds = NO;
        [self addSubview:plusBtn];
        self.plusBtn = plusBtn;
    }
    return self;
}

/**
 *  加号按钮点击
 */
- (void)plusClick
{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

- (void)layoutSubviews
{
#warning [super layoutSubviews] 一定要调用
    [super layoutSubviews];
    
    // 1.设置加号按钮的位置
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5 - 20;
    
    // 2.设置其他tabbarButton的位置和尺寸
    CGFloat tabbarButtonW = self.width / 5;
    CGFloat tabbarButtonIndex = 0;
    
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
//            child.alpha = 1;
//            child.backgroundColor = [UIColor orangeColor];
            // 设置宽度
            child.width = tabbarButtonW;
            // 设置x
            child.x = tabbarButtonIndex * tabbarButtonW;
            
            // 增加索引
            tabbarButtonIndex++;
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex++;
            }
        }
    }
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *result = [super hitTest:point withEvent:event];
    CGPoint buttonPoint = [self.plusBtn convertPoint:point fromView:self];
    if ([self.plusBtn pointInside:buttonPoint withEvent:event]) {
        return self.plusBtn;
    }
    return result;
}


@end

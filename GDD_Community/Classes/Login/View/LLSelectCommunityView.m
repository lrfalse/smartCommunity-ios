//
//  LLSelectCommunityView.m
//  LL_Community
//
//  Created by ox Ho on 2018/3/28.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "LLSelectCommunityView.h"

@implementation LLSelectCommunityView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    [self.citiNameBtn.layer setMasksToBounds:YES];
    [self.citiNameBtn setTitle:@"齐齐哈尔乌鲁木齐" forState:UIControlStateNormal];
    [self.citiNameBtn.layer setCornerRadius:2.0];
    [self.citiNameBtn.layer setBorderWidth:1.0];
    self.citiNameBtn.layer.borderColor= RGBACOLOR(1, 1, 1, 1).CGColor;
}


@end

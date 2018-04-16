//
//  LLoginView.m
//  LL_Community
//
//  Created by ox Ho on 2018/3/28.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "LLoginView.h"

@implementation LLoginView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    
    [self.loginBtn.layer setMasksToBounds:YES];
    [self.loginBtn.layer setCornerRadius:20.0]; 
    [self.loginBtn.layer setBorderWidth:1.0];
    self.loginBtn.layer.borderColor= RGBACOLOR(234, 100, 123, 1).CGColor;
}


@end

//
//  LockView.m
//  GDD_Community
//
//  Created by HYIT on 2018/3/15.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "LockView.h"

@implementation LockView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    
    if (view == nil) {
        for (UIView *subView in self.subviews) {
            CGPoint myPoint = [subView convertPoint:point fromView:self];
            if (CGRectContainsPoint(subView.bounds, myPoint)) {
                
                return subView;
            }
        }
    }
    
    return view;
}
@end

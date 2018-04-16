//
//  UIView+LoadFromNib.m
//  LL_Community
//
//  Created by ox Ho on 2018/3/28.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "UIView+LoadFromNib.h"

@implementation UIView (LoadFromNib)

+ (id)loadFromNib
{
    id view = nil;
    NSString *xibName = NSStringFromClass([self class]);
    UIViewController *temporaryController = [[UIViewController alloc] initWithNibName:xibName bundle:nil];
    if(temporaryController)
    {
        view = temporaryController.view;
    }
    return view;
}

- (void)setingNavSize:(UIView *)superView
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(superView);
        make.size.mas_equalTo(superView);
    }];
    //    return vieww;
}

@end

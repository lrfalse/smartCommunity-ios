//
//  LLoginDetailVC.m
//  LL_Community
//
//  Created by ox Ho on 2018/3/28.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "LLoginDetailView.h"

@implementation LLoginDetailView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self configuration];
}

- (void)configuration
{
    
    
    
}
- (IBAction)showOrHide:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.PasswordTF.secureTextEntry = !self.PasswordTF.secureTextEntry;
}

@end

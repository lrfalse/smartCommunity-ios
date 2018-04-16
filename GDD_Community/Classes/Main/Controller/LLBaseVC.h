//
//  LLBaseVC.h
//  LL_Community
//
//  Created by ox Ho on 2018/3/28.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLNavView.h"
@interface LLBaseVC : UIViewController

@property (nonatomic,strong) LLNavView *navBar;//导航


//返回
- (void)backBtnMehtod:(UIButton*)sender;


- (void)showEnvelope;
@end

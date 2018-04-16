//
//  LLRegisteredView.h
//  LL_Community
//
//  Created by ox Ho on 2018/3/28.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLRegisteredView : UIView
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;//手机号输入框
@property (weak, nonatomic) IBOutlet UITextField *codeTF;//验证码输入框
@property (weak, nonatomic) IBOutlet UIButton *sendCodeBtn;//发送验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;//下一步按钮

@end

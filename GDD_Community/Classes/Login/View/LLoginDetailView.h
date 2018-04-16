//
//  LLoginDetailVC.h
//  LL_Community
//
//  Created by ox Ho on 2018/3/28.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLoginDetailView : UIView
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;//手机号
@property (weak, nonatomic) IBOutlet UITextField *PasswordTF;//密码输入
@property (weak, nonatomic) IBOutlet UIButton *passwordSelectBtn;//密码显示隐藏
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;//登陆按钮
@property (weak, nonatomic) IBOutlet UIButton *WeChatBtn;//微信按钮
@property (weak, nonatomic) IBOutlet UIButton *qqBtn;//qq按钮

@end

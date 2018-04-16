//
//  LLCreatePasswordView.h
//  LL_Community
//
//  Created by ox Ho on 2018/3/28.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLCreatePasswordView : UIView
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;//密码输入框
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;//下一步 
@property (weak, nonatomic) IBOutlet UIButton *passwordSelectBtn;//密码显示隐藏

@end

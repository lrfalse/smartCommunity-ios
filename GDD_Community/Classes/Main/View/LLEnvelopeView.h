//
//  LLEnvelopeView.h
//  LL_Community
//
//  Created by ox Ho on 2018/4/8.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLEnvelopeView : UIView

//@property (nonatomic,weak)UIImageView *headView;//店铺头像

@property (nonatomic,weak)UILabel *shopNameLB;//店铺名称

//@property (nonatomic,weak)UIButton *openBtn;//打开红包

@property (nonatomic,weak)UIImageView *shopShowView;//店铺详情图片
@property (weak, nonatomic) IBOutlet UIImageView *topView;
@property (weak, nonatomic) IBOutlet UIButton *openBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headView;//店铺头像
@property (weak, nonatomic) IBOutlet UILabel *shopName;//店铺名字

@property (weak, nonatomic) IBOutlet UIImageView *bottomView;
@property (nonatomic,assign)CGRect *rect;
@end

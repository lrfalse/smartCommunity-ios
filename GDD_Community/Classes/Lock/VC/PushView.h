//
//  PushView.h
//  GDD_Community
//
//  Created by HYIT on 2018/3/15.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import <UIKit/UIKit.h>
//通知点击按钮协议
@protocol PushViewDelegate <NSObject>
- (void)didSelectBtnWithBtnTag:(NSInteger)tag;
@end
@interface PushView : UIView
//通知点击按钮代理人
@property(weak,nonatomic) id<PushViewDelegate> delegate;

@property (nonatomic,assign) CGRect rect;
//弹出动画view
+(PushView *)standardPublishAnimateWithView:(UIView *)view;

@end

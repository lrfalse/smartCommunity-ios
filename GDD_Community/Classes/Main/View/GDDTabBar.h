//
//  GDDTabBar.h
//  GDD_Community
//
//  Created by HYIT on 2018/3/14.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GDDTabBar;
#warning 因为HWTabBar继承自UITabBar，所以称为HWTabBar的代理，也必须实现UITabBar的代理协议
@protocol GDDTabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidClickPlusButton:(GDDTabBar *)tabBar;
@end
@interface GDDTabBar : UITabBar

@property (nonatomic, weak) id<GDDTabBarDelegate> delegate;

@end

//
//  LLHomeView.h
//  LL_Community
//
//  Created by ox Ho on 2018/4/8.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLHomeView : UIView
@property (weak, nonatomic) IBOutlet UIButton *openEnvelopeBtn;//抢红包
@property (weak, nonatomic) IBOutlet UIView *headAdvertisingView;//顶部轮播广告
@property (weak, nonatomic) IBOutlet UIView *AnnouncementView;//社区公告
@property (weak, nonatomic) IBOutlet UIView *menuView;//菜单
//@property (weak, nonatomic) IBOutlet UIView *runView;
@property (weak, nonatomic) IBOutlet UITableView *listTabView;//榜上有名
@property (weak, nonatomic) IBOutlet UICollectionView *bulkCollecitionView;//团购优惠
@property (weak, nonatomic) IBOutlet UIView *runAdvertisingView;//社区活动轮播

@property (weak, nonatomic) IBOutlet UIView *actionView;

@end

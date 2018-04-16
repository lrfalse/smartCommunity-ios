//
//  LLTabBarController.m
//  LL_Community
//
//  Created by ox Ho on 2018/4/8.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "LLTabBarController.h"
#import "PlusAnimate.h"
@interface LLTabBarController ()<CYTabBarDelegate,PublishAnimateDelegate>

@end

@implementation LLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabbar.delegate = self;
}

#pragma mark - CYTabBarDelegate
//中间按钮点击
- (void)tabbar:(CYTabBar *)tabbar clickForCenterButton:(CYCenterButton *)centerButton{
    PlusAnimate *view = [[PlusAnimate alloc]init];
    view.delegate = self;
    [view standardPublishAnimateWithView:centerButton plusanimate:view];
//    [PlusAnimate standardPublishAnimateWithView:centerButton];
}
//是否允许切换
- (BOOL)tabBar:(CYTabBar *)tabBar willSelectIndex:(NSInteger)index{
    NSLog(@"将要切换到---> %ld",index);
    return YES;
}
//通知切换的下标
- (void)tabBar:(CYTabBar *)tabBar didSelectIndex:(NSInteger)index{
    NSLog(@"切换到---> %ld",index);
}
- (void)didSelectBtnWithBtnTag:(NSInteger)tag{
    
    NSLog(@"~~~~~%ld",(long)tag);
    NSDictionary *dict =[[NSDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)tag],@"tag",nil];
    
    //创建通知
    
    NSNotification *notification =[NSNotification notificationWithName:@"clickTag" object:dict];
    
    //通过通知中心发送通知
    
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    [self.navigationController popViewControllerAnimated:YES];

}
@end

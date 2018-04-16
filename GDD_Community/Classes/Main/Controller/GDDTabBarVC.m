//
//  GDDTabBarVC.m
//  GDD_Community
//
//  Created by HYIT on 2018/3/14.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "GDDTabBarVC.h"
#import "HomeVC.h"
#import "BusinessCircleVC.h"
#import "NeighborVC.h"
#import "MyCenterVC.h"
#import "GDDTabBar.h"
#import "GDDNavigationController.h"
#import "PushVC.h"
#import "PushView.h"
@interface GDDTabBarVC ()


@end

@implementation GDDTabBarVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.初始化子控制器
    HomeVC *home = [[HomeVC alloc] init];
    [self addChildVc:home title:@"首页" image:@"shouye" selectedImage:@"shouyeclick"];
    
    BusinessCircleVC *messageCenter = [[BusinessCircleVC alloc] init];
    [self addChildVc:messageCenter title:@"商圈" image:@"shenghuo" selectedImage:@"shenghuoclick"];
    
    NeighborVC *discover = [[NeighborVC alloc] init];
    [self addChildVc:discover title:@"邻里" image:@"linli" selectedImage:@"linliclick"];
    
    MyCenterVC *profile = [[MyCenterVC alloc] init];
    [self addChildVc:profile title:@"个人中心" image:@"wodeclick" selectedImage:@"wodeclick"];
    
    // 2.更换系统自带的tabbar
    GDDTabBar *tabBar = [[GDDTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    /*
     [self setValue:tabBar forKeyPath:@"tabBar"];相当于self.tabBar = tabBar;
     [self setValue:tabBar forKeyPath:@"tabBar"];这行代码过后，tabBar的delegate就是HWTabBarViewController
     说明，不用再设置tabBar.delegate = self;
     */
    
    /*
     1.如果tabBar设置完delegate后，再执行下面代码修改delegate，就会报错
     tabBar.delegate = self;
     
     2.如果再次修改tabBar的delegate属性，就会报下面的错误
     错误信息：Changing the delegate of a tab bar managed by a tab bar controller is not allowed.
     错误意思：不允许修改TabBar的delegate属性(这个TabBar是被TabBarViewController所管理的)
     */
    
//    CGRect rect = CGRectMake(0, 0, CGRectW(self.view), CGRectH(self.view));
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
//    CGContextFillRect(context, rect);
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self.tabBar setBackgroundImage:img];
//    [self.tabBar setShadowImage:img];
//    self.tabBar = [UITabBar appearance];
//    UIImage *img = [[UIImage alloc]init];

//    [self.tabBar setBackgroundImage:[UIImage new]];
//    [self.tabBar setShadowImage:[UIImage new]];
    
    
    [self setValue:[[GDDTabBar alloc] init] forKeyPath:@"tabBar"];
    //        GDDTabBar appearance
//    [[GDDTabBar appearance]setShadowImage:[[UIImage alloc]init]];
//    [[GDDTabBar appearance]setBackgroundImage:[[UIImage alloc]init]];
    
    [[GDDTabBar appearance] setShadowImage:[[UIImage alloc] init]];
    [[GDDTabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    UIImageView * backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -13,CGRectW(self.view), 62)];
//    backImageView.image = [UIImage imageNamed:@"标签栏背景"];
//    backImageView.backgroundColor = [UIColor whiteColor];
//    [self addSubview:backImageView];
    [self.tabBar addSubview:backImageView];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    childVc.title = title; // 同时设置tabbar和navigationBar的文字
    
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = HWColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    GDDNavigationController *nav = [[GDDNavigationController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}

#pragma mark - HWTabBarDelegate代理方法
- (void)tabBarDidClickPlusButton:(GDDTabBar *)tabBar
{
//    PushVC *vc = [[PushVC alloc] init];
////    vc.view.backgroundColor = [UIColor whiteColor];
//    [self presentViewController:vc animated:YES completion:nil];
//    NSLog(@"~~");
//    [PushView standardPublishAnimateWithView:tabBar];
    [PushView standardPublishAnimateWithView:tabBar];
    
}

@end

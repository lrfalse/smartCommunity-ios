//
//  AppDelegate.m
//  GDD_Community
//
//  Created by HYIT on 2018/3/13.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "AppDelegate.h"
#import "GDDTabBarVC.h"
#import <IQKeyboardManager.h>
#import "LoginVC.h"
#import "HomeVC.h"
#import "BusinessCircleVC.h"
#import "NeighborVC.h"
#import "MyCenterVC.h"
#import "GDDTabBar.h"
#import "GDDNavigationController.h"
#import "PushVC.h"
#import "PushView.h"
#import "LLTabBarController.h"

//#import <TencentOpenAPI/TencentOAuth.h>

#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"

@interface AppDelegate ()<QQApiInterfaceDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //IQKeyboardManager设置
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    keyboardManager.enable = YES; // 控制整个功能是否启用
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
     [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"KeyUserInfo"];
     [self jump];
    
    
    
    
    /**初始化ShareSDK应用
     
     @param activePlatforms
     
     使用的分享平台集合
     
     @param importHandler (onImport)
     
     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     
     @param configurationHandler (onConfiguration)
     
     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     
     */
    
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSMS),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ)
                                        ]
                             onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             default:
                 break;
         }
     }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wxdd72a0171dbec579"
                                       appSecret:@"d32773b93b3a1f351df1f53bafc70eff"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"100371282"
                                      appKey:@"aed9b0303e3ed1e27bae87c33761161d"
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
    return YES;
}
-(void)jump{
    //判定是否有缓存
    NSData* loginData =  [[NSUserDefaults standardUserDefaults] objectForKey:@"KeyUserInfo"];
    NSDictionary* logdic = [NSKeyedUnarchiver unarchiveObjectWithData:loginData];
    
    if (loginData.length < 1 || logdic == nil) {
        [UserInfo sharedInstance].userModel = [UserModel new];
        UINavigationController* nav1 = [[UINavigationController alloc] initWithRootViewController:[[LoginVC alloc] init]];
        self.window.rootViewController = nav1;
    }else{
        // 1.创建窗口
//        self.window = [[UIWindow alloc] init];
//        self.window.frame = [UIScreen mainScreen].bounds;
//        self.window.rootViewController = [[GDDTabBarVC alloc] init];
//        // 3.显示窗口
//        [self.window makeKeyAndVisible];
        // 继承CYTabBar的控制器， 你可以自定定义 或 不继承直接使用
        LLTabBarController * tabbar = [[LLTabBarController alloc]init];
        
        // 配置
        [CYTabBarConfig shared].selectedTextColor = [UIColor blackColor];
        [CYTabBarConfig shared].textColor = [UIColor grayColor];
        [CYTabBarConfig shared].backgroundColor = [UIColor whiteColor];
        [CYTabBarConfig shared].selectIndex = 0;
        [CYTabBarConfig shared].centerBtnIndex = 2;
        [CYTabBarConfig shared].HidesBottomBarWhenPushedOption = HidesBottomBarWhenPushedAlone;
        
        [self style1:tabbar];
        self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        self.window.rootViewController = tabbar;
        [self.window makeKeyAndVisible];
        
        
        
    }
}
- (void)style1:(CYTabBarController *)tabbar {
    UINavigationController *nav1 = [[UINavigationController alloc]initWithRootViewController:[HomeVC new]];
    [tabbar addChildController:nav1 title:@"首页" imageName:@"shouye" selectedImageName:@"shouyeclick"];
    UINavigationController *nav2 = [[UINavigationController alloc]initWithRootViewController:[BusinessCircleVC new]];
    [tabbar addChildController:nav2 title:@"商圈" imageName:@"shenghuo" selectedImageName:@"shenghuoclick"];
    UINavigationController *nav3 = [[UINavigationController alloc]initWithRootViewController:[NeighborVC new]];
    [tabbar addChildController:nav3 title:@"邻里" imageName:@"linli" selectedImageName:@"linliclick"];
    UINavigationController *nav4 = [[UINavigationController alloc]initWithRootViewController:[MyCenterVC new]];
    [tabbar addChildController:nav4 title:@"个人中心" imageName:@"wode" selectedImageName:@"wodeclick"];
    [tabbar addCenterController:nil bulge:YES title:@"" imageName:@"yaoshi" selectedImageName:@"cha"];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    return [TencentOAuth HandleOpenURL:url];
//}
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    return [TencentOAuth HandleOpenURL:url];
//}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //    NSString *strUrl = @"http://dajdklajdka?";
    //    url = [NSURL URLWithString:strUrl];

#if BUILD_QQAPIDEMO
    [QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)[QQApiShareEntry class]];
#endif
    
    if (YES == [TencentOAuth CanHandleOpenURL:url])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Where from" message:url.description delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alertView show];
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
#if BUILD_QQAPIDEMO
    [QQApiInterface handleOpenURL:url delegate:(id<QQApiInterfaceDelegate>)[QQApiShareEntry class]];
#endif

    if (YES == [TencentOAuth CanHandleOpenURL:url])
    {
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}
@end

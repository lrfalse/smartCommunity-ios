//
//  LLoginForQQVC.m
//  LL_Community
//
//  Created by ox Ho on 2018/4/8.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "LLoginForQQVC.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <ShareSDK/ShareSDK.h>

#define __TencentDemoAppid_  ([[NSBundle mainBundle] objectForInfoDictionaryKey:@"101464903"])
@interface LLoginForQQVC ()<TencentSessionDelegate>

@property (nonatomic,strong)UIView *navView;//导航栏
@property (nonatomic,strong)TencentOAuth *tencentOAuth;
@end

@implementation LLoginForQQVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self settingNav];
    [self initializationHomeView];
    
}

//设置自定义导航栏
- (void)settingNav
{
    self.navView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectW(self.view), 64)];
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.navBar];
    self.navBar.titleLB.text = @"QQ登陆";
    [self.navBar setingNavSize:self.navView];
//    self.navBar.backBtn.hidden = YES;
    
}
- (void)initializationHomeView {

//    NSString *appid = __TencentDemoAppid_;
//    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:appid
//                                     andDelegate:self];
//    [_tencentOAuth authorize:nil inSafari:NO];
//

    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {

             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }

         else
         {
             NSLog(@"%@",error);
         }

     }];
    
//    [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
}


/**
 *  取消分享平台授权
 *
 *  @param platformType  平台类型
 */
//+ (void)cancelAuthorize:(SSDKPlatformType)platformType;

/**
 *  判断分享平台是否授权
 *
 *  @param platformType 平台类型
 *  @return YES 表示已授权，NO 表示尚未授权
 */
//+ (BOOL)hasAuthorized:(SSDKPlatformType)platformTypem;
@end

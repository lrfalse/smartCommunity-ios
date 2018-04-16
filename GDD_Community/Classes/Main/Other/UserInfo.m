//
//  UserInfo.m
//  GDD_Community
//
//  Created by ox Ho on 2018/3/28.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
+ (UserInfo *)sharedInstance {
    static UserInfo *_sharedObj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedObj = [[UserInfo alloc] init];
    });
    return _sharedObj;
}
@end

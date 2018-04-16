//
//  UserInfo.h
//  GDD_Community
//
//  Created by ox Ho on 2018/3/28.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface UserInfo : NSObject
+ (UserInfo *)sharedInstance;
@property(nonatomic,strong)UserModel* userModel;

@end

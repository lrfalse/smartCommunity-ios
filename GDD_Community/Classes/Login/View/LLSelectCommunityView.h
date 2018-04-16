//
//  LLSelectCommunityView.h
//  LL_Community
//
//  Created by ox Ho on 2018/3/28.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LLSelectCommunityView : UIView
@property (weak, nonatomic) IBOutlet UIButton *citiNameBtn;//城市按钮
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;//搜索按钮
@property (weak, nonatomic) IBOutlet UIButton *positionBtn;//定位按钮
@property (weak, nonatomic) IBOutlet UITableView *cityListTableView;//城市列表

@end

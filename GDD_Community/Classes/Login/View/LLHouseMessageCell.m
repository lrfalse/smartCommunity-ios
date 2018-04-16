//
//  LLHouseMessageCell.m
//  LL_Community
//
//  Created by ox Ho on 2018/3/29.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "LLHouseMessageCell.h"

@implementation LLHouseMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (id)showScreenCell
{
    return [[NSBundle mainBundle] loadNibNamed:@"LLHouseMessageCell" owner:nil options:nil][0];
}
@end

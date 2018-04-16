//
//  LLSelectCityCell.m
//  LL_Community
//
//  Created by ox Ho on 2018/3/28.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import "LLSelectCityCell.h"

@implementation LLSelectCityCell

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
    return [[NSBundle mainBundle] loadNibNamed:@"LLSelectCityCell" owner:nil options:nil][0];
}
@end

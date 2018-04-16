//
//  LLDefine.h
//  LL_Community
//
//  Created by ox Ho on 2018/3/28.
//  Copyright © 2018年 Hty. All rights reserved.
//

#ifndef LLDefine_h
#define LLDefine_h

#define CGRectOrigin(v)    v.frame.origin
#define CGRectSize(v)      v.frame.size
#define CGRectX(v)         CGRectOrigin(v).x
#define CGRectY(v)         CGRectOrigin(v).y
#define CGRectW(v)         CGRectSize(v).width
#define CGRectH(v)         CGRectSize(v).height

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
//for all
#define CLEAR_COLOR [UIColor clearColor]
#define BACKGROUND_COLOR [UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0];
//for font
#define DEFAULT_FONTSIZE    12
#define DEFAULT_FONT(s)     [UIFont systemFontOfSize:s]
#define DEFAULT_BOLDFONT(s) [UIFont boldSystemFontOfSize:s]
#define MAXWIDTH [UIScreen mainScreen].bounds.size.width

//RGB color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

// RGB颜色
#define HWColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 随机色
#define HWRandomColor HWColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#endif /* LLDefine_h */

//
//  NSString+AES.h
//  LL_Community
//
//  Created by ox Ho on 2018/4/4.
//  Copyright © 2018年 Hty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AES)

/**< 加密方法 */
- (NSString*)aci_encryptWithAES;

/**< 解密方法 */
- (NSString*)aci_decryptWithAES;

@end

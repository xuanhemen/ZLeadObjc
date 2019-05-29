//
//  NSString+Function.h
//  ZLead
//
//  Created by 董建伟 on 2019/5/28.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Function)

/** 验证手机号格式是否正确 */
+ (BOOL)validatePhoneNumber:(NSString *)phoneNumber;
@end

NS_ASSUME_NONNULL_END

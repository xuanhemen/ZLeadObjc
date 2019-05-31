//
//  UIColor+Func.h
//  ZLead
//
//  Created by 董建伟 on 2019/5/23.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Func)
/** HEX */
+(UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (UIColor *)zl_mainColor;

+ (UIColor *)zl_bgColor;

+ (UIColor *)zl_lineColor;
/** 主字体颜色 */
+ (UIColor *)zl_textColor;

@end

NS_ASSUME_NONNULL_END

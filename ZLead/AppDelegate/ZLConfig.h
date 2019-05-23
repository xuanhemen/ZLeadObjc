//
//  ZLConfig.h
//  ZLead
//
//  Created by 董建伟 on 2019/5/22.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * ZL_BASE_URL; //服务器地址（全局）

@interface ZLConfig : NSObject

/** 选择初始控制器 */
+(void)chooseRootViewController;
/** 环境配置 */
+(void)config;
@end

NS_ASSUME_NONNULL_END

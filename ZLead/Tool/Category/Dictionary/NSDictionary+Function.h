//
//  NSDictionary+Function.h
//  ZLead
//
//  Created by 董建伟 on 2019/5/29.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Function)

/** 拼接参数 */
+ (NSMutableDictionary *)splicingParameters:(id)params;
@end

NS_ASSUME_NONNULL_END

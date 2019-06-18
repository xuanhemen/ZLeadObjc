//
//  NSDictionary+Function.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/29.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "NSDictionary+Function.h"

@implementation NSDictionary (Function)

/** 拼接参数 */
+ (NSMutableDictionary *)splicingParameters:(NSDictionary *)params {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"platform"] = @"ios";
    param[@"appversion"] = @"1.0.3";
    param[@"apiversion"] = @"1.0.2";
    param[@"imei"] = @"12345678";
    param[@"signature"] = @"xxxxxxxxxxxx";
    NSString *tokenStr =  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (IsStrEmpty(tokenStr)) {
        param[@"token"] = @"";
    }else{
         param[@"token"] = tokenStr;
    }
    NSAssert([params isKindOfClass:[NSDictionary class]], @"所传接口参数data不是一个NSDictionary");
    if ([params isKindOfClass:[NSDictionary class]]) {
        param[@"data"] = params;
    }
    DLog(@"请求参数%@",param);
    return param;
}
@end

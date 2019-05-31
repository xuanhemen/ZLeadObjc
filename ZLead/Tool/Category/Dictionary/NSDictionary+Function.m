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
//    NSDictionary *paramDic = params;
//    NSError *error = nil;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramDic options:NSJSONWritingPrettyPrinted error:&error];
//    NSString *paramStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"platform"] = @"ios";
    param[@"appversion"] = @"1.0.0";
    param[@"apiversion"] = @"1.0.0";
    param[@"imei"] = @"1423415435";
    param[@"signature"] = @"";
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
    return param;
}
@end

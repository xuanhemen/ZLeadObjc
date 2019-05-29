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
+ (NSMutableDictionary *)splicingParameters:(id)params {
    NSDictionary *paramDic = params;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:paramDic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *paramStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"platform"] = @"ios";
    NSString *tokenStr =  [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (IsStrEmpty(tokenStr)) {
        param[@"token"] = @"";
    }else{
         param[@"token"] = tokenStr;
    }
    param[@"data"] = paramStr;
    return param;
}
@end

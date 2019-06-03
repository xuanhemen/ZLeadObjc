//
//  ZLUserInfo.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/1.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLUserInfo.h"

@implementation ZLUserInfo

static ZLUserInfo *_instance = nil;
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    return _instance;
}
+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [ZLUserInfo sharedInstance];
}
- (id)copyWithZone:(struct _NSZone *)zone
{
    return [ZLUserInfo sharedInstance];
}
@end

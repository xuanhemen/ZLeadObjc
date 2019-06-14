//
//  ZLClassifyItemModel.m
//  ZLead
//
//  Created by dmy on 2019/6/5.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLClassifyItemModel.h"

@implementation ZLClassifyItemModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"title":@"sgcName",
        @"classifyId":@"sgcId",
        @"classifyCode":@"sgcCode",
        @"parentId":@"sgcParentId",
        @"remark":@"sgcRemark",
        @"level":@"sgcLevel",
    };
}
@end

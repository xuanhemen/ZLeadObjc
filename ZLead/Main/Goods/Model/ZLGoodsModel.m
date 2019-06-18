//
//  ZLGoodsModel.m
//  ZLead
//
//  Created by dmy on 2019/6/4.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLGoodsModel.h"

@implementation ZLGoodsModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"inventoryValue":@"inventoryValue",
             @"goodsName":@"sgName",
             @"sgClassName1":@"goodsClassName1",
             @"goodsClassName2":@"goodsClassName2",
             @"skuId":@"sgkId",
             @"spuId":@"sguId",
             @"skuCode":@"sgCode",
             @"spuCode":@"spuCode",
             @"customCode":@"sgCustomCode",
             @"gooodsClassId1":@"sgClass1",
             @"gooodsClassId2":@"sgClass2",
             @"priceId":@"sgpId",
             @"fromSource":@"sgFromSource",
             @"status":@"sgStatus",
             @"createTime":@"sgCreateTime",
             @"endTime":@"sgEndTime",
             @"goodsUint":@"sgUnit",
             @"goodsType":@"sgModel",
             @"desc":@"sgDesc",
             @"package":@"sgPackageList",
             @"stockId":@"sgiId",
             @"isLock":@"sgIsLock",
             @"isDelete":@"sgIsDelete",
             @"remark":@"sgRemark",
             @"top":@"sgSort"
             };
}
@end

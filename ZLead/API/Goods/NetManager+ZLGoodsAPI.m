//
//  NetManager+ZLGoodsAPI.m
//  ZLead
//
//  Created by dmy on 2019/6/10.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "NetManager+ZLGoodsAPI.h"
#import "ZLClassifyItemModel.h"
#import "ZLGoodsModel.h"

#define kSizePage 10

@implementation NetManager (ZLGoodsAPI)

- (void)getGoodsListByStatus:(NSInteger )status
                      shopId:(NSString *)shopId
                     pageNum:(NSInteger )pageNum
                      sucess:(successBlock)sucess
                        fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"sgStatus"] = @(status);//[NSString stringWithFormat:@"%@", ];
    dict[@"shopId"] = shopId;
    dict[@"currentPage"] = [NSString stringWithFormat:@"%@", @(pageNum)];
    dict[@"sizePage"] = [NSString stringWithFormat:@"%d", kSizePage];
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_GetGoodsListByStatus parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        NSMutableArray *goodsList = [[NSMutableArray alloc] init];
        for (NSDictionary *goodsDic in responseObject[@"records"]) {
            ZLGoodsModel *item = [ZLGoodsModel mj_objectWithKeyValues:goodsDic];
            item.onlinePrice = goodsDic[@"shopGoodsPrice"][@"sgpPublicEprice"];
            item.offlinePrice = goodsDic[@"shopGoodsPrice"][@"sgpPublicPrice"];
            item.costPrice = goodsDic[@"shopGoodsPrice"][@"sgpPrivatePrice"];
            [goodsList addObject:item];
        }
        sucess(goodsList, [responseObject[@"total"] integerValue]);
    } fail:^(NSError * _Nonnull error) {
        fail(error);
    }];
}

- (void)getGoodsSpuListByStatus:(NSInteger )status
                      shopId:(NSString *)shopId
                     pageNum:(NSInteger )pageNum
                      sucess:(successBlock)sucess
                        fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"sgSpuStatus"] = [NSString stringWithFormat:@"%@", @(status)];
    dict[@"shopId"] = shopId;
    dict[@"currentPage"] = [NSString stringWithFormat:@"%@", @(pageNum)];
    dict[@"sizePage"] = [NSString stringWithFormat:@"%d", kSizePage];
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_GetGoodsSpuListByStatus parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        NSMutableArray *goodsList = [[NSMutableArray alloc] init];
        for (NSDictionary *goodsDic in responseObject[@"records"]) {
            ZLGoodsModel *item = [ZLGoodsModel mj_objectWithKeyValues:goodsDic];
            item.onlinePrice = goodsDic[@"shopGoodsPrice"][@"sgpPublicEprice"];
            item.offlinePrice = goodsDic[@"shopGoodsPrice"][@"sgpPublicPrice"];
            item.costPrice = goodsDic[@"shopGoodsPrice"][@"sgpPrivatePrice"];
            [goodsList addObject:item];
        }
        sucess(goodsList, [responseObject[@"total"] integerValue]);
    } fail:^(NSError * _Nonnull error) {
        fail(error);
    }];
}

- (void)batchEditGoodsStatus:(NSString *)sgGoodsIds
                      sgType:(NSString *)sgType
                      sucess:(successfulBlock)sucess
                        fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"sgGoodsIds"] = sgGoodsIds;
    dict[@"sgType"] = sgType;
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_BatchEditGoodsStatus parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        sucess();
    } fail:^(NSError * _Nonnull error) {
        fail(error);
    }];
}

- (void)editShopGoodsClass:(NSString *)goodsClassifyId
              classifyName:(NSString *)classifyName
                    sucess:(successfulBlock)sucess
                      fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"sgcId"] = goodsClassifyId;
    dict[@"sgcName"] = classifyName;
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_EditShopGoodsClass parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        sucess();
    } fail:^(NSError * _Nonnull error) {
        fail(error);
    }];
}

- (void)removeShopGoodsClass:(NSInteger )goodsClassifyId
                      sucess:(successfulBlock)sucess
                        fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"sgcId"] = [NSString stringWithFormat:@"%@",@(goodsClassifyId)];
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_RemoveShopGoodsClass parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        sucess();
    } fail:^(NSError * _Nonnull error) {
        fail(error);
    }];
}

//- (void)addGoodsClass:(NSString *)sgcParentId
//                classifyName:(NSString *)classifyName
//                      sucess:(successfulBlock)sucess
//                        fail:(failWithErrorBlock)fail {
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"sgcParentId"] = sgcParentId;
//    dict[@"sgcName"] = classifyName;
//    [[NetManager sharedInstance] postRequestWithPath:ZLURL_AddGoodsClass parameters:dict sueccessful:^(id  _Nonnull responseObject) {
//        sucess();
//    } fail:^(NSError * _Nonnull error) {
//        fail(error);
//    }];
//}

- (void)getPlatFormClass:(NSString *)pgcId
                  sucess:(successBlock)sucess
                    fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"pgcId"] = pgcId;
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_GetPlatFormClass parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        NSMutableArray *classifyList = [[NSMutableArray alloc] init];
        for (NSDictionary *classifyItemDic in responseObject[@"platFormClass"]) {
            ZLClassifyItemModel *item = [[ZLClassifyItemModel alloc] init];
            item.classifyId = [classifyItemDic[@"pgcId"] integerValue];
            item.title = classifyItemDic[@"pgcName"];
            item.level = [classifyItemDic[@"pgcLevel"] integerValue];
            item.remark = classifyItemDic[@"pgcRemark"];
            [classifyList addObject:item];
        }
        sucess(classifyList, classifyList.count);
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (void)getPlatformGoodsList:(NSInteger )pageNum
                      sucess:(successBlock)sucess
                        fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"currentPage"] = [NSString stringWithFormat:@"%@", @(pageNum)];
    dict[@"sizePage"] = [NSString stringWithFormat:@"%d", kSizePage];
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_GetPlatformGoodsList parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (void)getShopClassWithParentId:(NSString *)sgcParentId
                   shopId:(NSString *)shopId
                   sucess:(successBlock)sucess
                     fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"sgcParentId"] = sgcParentId;
    dict[@"shopId"] = shopId;
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_GetShopClassLeve1 parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        NSMutableArray *classifyList = [[NSMutableArray alloc] init];
        for (NSDictionary *classifyItemDic in responseObject[@"shopClass"]) {
            ZLClassifyItemModel *item = [[ZLClassifyItemModel alloc] init];
            item.classifyId = [classifyItemDic[@"sgcId"] integerValue];
            item.classifyCode = classifyItemDic[@"sgcCode"];
            item.shopId = [classifyItemDic[@"shopId"] integerValue];
            item.parentId = [classifyItemDic[@"sgcParentId"] integerValue];
            item.remark = classifyItemDic[@"sgcRemark"];
            item.level = [classifyItemDic[@"sgcLevel"] integerValue];
            [classifyList addObject:item];
        }
        sucess(classifyList, classifyList.count);
    } fail:^(NSError * _Nonnull error) {
        fail(error);
    }];
}

- (void)addShopGoodsClass:(NSString *)shopId
             classifyName:(NSString *)classifyName
                 parentId:(NSString *)parentId
                   sucess:(successfulBlock)sucess
                     fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"shopId"] = shopId;
    dict[@"className"] = classifyName;
    dict[@"parentId"] = parentId;
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_AddShopGoodsClass parameters:dict sueccessful:^(id  _Nonnull responseObject) {
         sucess();
    } fail:^(NSError * _Nonnull error) {
        fail(error);
    }];
}


@end

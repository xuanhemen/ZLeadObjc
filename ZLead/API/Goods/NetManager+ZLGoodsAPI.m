//
//  NetManager+ZLGoodsAPI.m
//  ZLead
//
//  Created by dmy on 2019/6/10.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "NetManager+ZLGoodsAPI.h"

#define kSizePage 10

@implementation NetManager (ZLGoodsAPI)

- (void)getGoodsListByStatus:(NSString *)status
                      shopId:(NSString *)shopId
                     pageNum:(NSString *)pageNum
                      sucess:(successBlock)sucess
                        fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"sgStatus"] = status;
    dict[@"shopId"] = shopId;
    dict[@"currentPage"] = pageNum;
    dict[@"sizePage"] = [NSString stringWithFormat:@"%d", kSizePage];
    dict[@"totalPageNum"] = [NSString stringWithFormat:@"%d", kSizePage];
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_GetGoodsListByStatus parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (void)batchEditGoodsStatus:(NSString *)sgGoodsIds
                      sgType:(NSString *)sgType
                      sucess:(resultBlock)sucess
                        fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"sgGoodsIds"] = sgGoodsIds;
    dict[@"sgType"] = sgType;
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_BatchEditGoodsStatus parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (void)editShopGoodsClass:(NSString *)goodsClassifyId
              classifyName:(NSString *)classifyName
                    sucess:(resultBlock)sucess
                      fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"sgcId"] = goodsClassifyId;
    dict[@"sgcName"] = classifyName;
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_EditShopGoodsClass parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (void)removeShopGoodsClass:(NSString *)goodsClassifyId
                      sucess:(resultBlock)sucess
                        fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"sgcId"] = goodsClassifyId;
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_RemoveShopGoodsClass parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (void)addGoodsClass:(NSString *)sgcParentId
                classifyName:(NSString *)classifyName
                      sucess:(resultBlock)sucess
                        fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"sgcParentId"] = sgcParentId;
    dict[@"sgcName"] = classifyName;
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_AddGoodsClass parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (void)getPlatFormClass:(NSString *)pgcId
                  sucess:(successBlock)sucess
                    fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"pgcId"] = pgcId;
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_GetPlatFormClass parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (void)getPlatformGoodsList:(NSInteger )pageNum
                      sucess:(successBlock)sucess
                        fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"currentPage"] = [NSString stringWithFormat:@"%@", @(pageNum)];
    dict[@"sizePage"] = [NSString stringWithFormat:@"%d", kSizePage];
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_GetPlatFormClass parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (void)getShopClassLeve1:(NSString *)sgcParentId
                   shopId:(NSString *)shopId
                   sucess:(resultBlock)sucess
                     fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"sgcParentId"] = sgcParentId;
    dict[@"shopId"] = shopId;
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_GetShopClassLeve1 parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (void)addShopGoodsClass:(NSString *)shopId
             classifyName:(NSString *)classifyName
                 parentId:(NSString *)parentId
                   sucess:(resultBlock)sucess
                     fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"shopId"] = shopId;
    dict[@"className"] = classifyName;
    dict[@"parentId"] = parentId;
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_AddShopGoodsClass parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        
    } fail:^(NSError * _Nonnull error) {
        
    }];
}


@end

//
//  NetManager+ZLGoodsAPI.h
//  ZLead
//
//  Created by dmy on 2019/6/10.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "NetManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetManager (ZLGoodsAPI)
/**
 根据状态获取商品列表
 
 @param status 商品状态 1:销售中,2：下架,3：违规
 @param shopId 店铺ID
 @param pageNum 当前页数
 @param sucess 成功
 @param fail 失败
 */
- (void)getGoodsListByStatus:(NSString *)status
                      shopId:(NSString *)shopId
                     pageNum:(NSString *)pageNum
                       sucess:(successBlock)sucess
                         fail:(failWithErrorBlock)fail;


/**
 商品批量操作（下架&&删除&&置顶&&取消置顶）
 
 @param sgGoodsIds 商品Id集合字符串
 @param sgType 要修改的状态 "delete/under/up/top/untop"
 @param sucess 成功
 @param fail 失败
 */
- (void)batchEditGoodsStatus:(NSString *)sgGoodsIds
                      sgType:(NSString *)sgType
                      sucess:(resultBlock)sucess
                        fail:(failWithErrorBlock)fail;

/**
 修改商品分类
 
 @param goodsClassifyId 分类ID
 @param classifyName 分类名称
 @param sucess 成功
 @param fail 失败
 */
- (void)editShopGoodsClass:(NSString *)goodsClassifyId
                      classifyName:(NSString *)classifyName
                      sucess:(resultBlock)sucess
                        fail:(failWithErrorBlock)fail;

/**
 删除商品分类
 
 @param goodsClassifyId 分类ID
 @param sucess 成功
 @param fail 失败
 */
- (void)removeShopGoodsClass:(NSString *)goodsClassifyId
                    sucess:(resultBlock)sucess
                      fail:(failWithErrorBlock)fail;

/**
 添加商品分类
 
 @param sgcParentId 上级分类ID/非必填
 @param classifyName 分类名称
 @param sucess 成功
 @param fail 失败
 */
- (void)addGoodsClass:(NSString *)sgcParentId
                classifyName:(NSString *)classifyName
                      sucess:(resultBlock)sucess
                        fail:(failWithErrorBlock)fail;

/**
 获取平台分类
 //根据分类id查询下级分类，不传参数/0时查询一级分类
 @param pgcId 分类id
 @param sucess 成功
 @param fail 失败
 */
- (void)getPlatFormClass:(NSString *)pgcId
                   sucess:(successBlock)sucess
                     fail:(failWithErrorBlock)fail;

/**
 查询平台商品列表
 
 @param pageNum 当前页数
 @param sucess 成功
 @param fail 失败
 */
- (void)getPlatformGoodsList:(NSInteger )pageNum
                      sucess:(successBlock)sucess
                        fail:(failWithErrorBlock)fail;

/**
 查询店铺分类
 根据分类id查询下级分类，不传参数/0值时查询一级分类
 
 @param sgcParentId 上级分类ID
 @param shopId 店铺编号
 @param sucess 成功
 @param fail 失败
 */
- (void)getShopClassLeve1:(NSString *)sgcParentId
                   shopId:(NSString *)shopId
                   sucess:(resultBlock)sucess
                     fail:(failWithErrorBlock)fail;

/**
 添加店铺分类
 根据分类id查询下级分类，不传参数/0值时查询一级分类
 
 @param shopId 店铺编号
 @param classifyName 分类名
 @param parentId 父分类编号
 @param sucess 成功
 @param fail 失败
 */
- (void)addShopGoodsClass:(NSString *)shopId
             classifyName:(NSString *)classifyName
                 parentId:(NSString *)parentId
                   sucess:(resultBlock)sucess
                     fail:(failWithErrorBlock)fail;

@end

NS_ASSUME_NONNULL_END

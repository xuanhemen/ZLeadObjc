//
//  URLManager.h
//  ZLead
//
//  Created by 董建伟 on 2019/5/23.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const ZLURL_LOGIN = @"/ZlwUser/login";
static NSString * const ZLURL_PhoneValidateCode = @"/common/getPhoneValidateCode";
static NSString * const ZLURL_CheckSmsCode = @"/common/checkSmsCode";
static NSString * const ZLURL_CheckShopIsExist = @"/ZlwUser/checkShopIsExist";
static NSString * const ZLURL_CheckIsRegByPhone = @"/ZlwUser/isRegByPhone";
static NSString * const ZLURL_GetShopsByUserId = @"/ZlwUser/getShopsByUserId";
static NSString * const ZLURL_GetGoodsListByStatus = @"/ZlwGoods/getGoodsListByStatus";//根据状态获取商品列表
static NSString * const ZLURL_GetGoodsSpuListByStatus = @"/ZlwGoods/getGoodsSpuListByStatus";//根据状态获取商品SPU+sku列表
static NSString * const ZLURL_BatchEditGoodsStatus = @"/ZlwGoods/batchEditGoodsStatus";//商品批量操作（下架&&删除&&置顶&&取消置顶）
static NSString * const ZLURL_EditShopGoodsClass = @"/ZlwGoods/editShopGoodsClass";//改商品分类
static NSString * const ZLURL_RemoveShopGoodsClass = @"/ZlwGoods/removeShopGoodsClass";//删除商品分类
static NSString * const ZLURL_GetPlatFormClass = @"/ZlwPlatformGoods/getPlatFormClass";//获取平台分类
static NSString * const ZLURL_GetPlatformGoodsList = @"/ZlwGoods/getPlatformGoodsList";//查询平台商品列表
static NSString * const ZLURL_GetShopClassLeve1 = @"/ZlwGoods/getShopClassLeve1";//查询店铺分类
static NSString * const ZLURL_AddShopGoodsClass = @"/goods/addShopGoodsClass";//添加店铺商品分类

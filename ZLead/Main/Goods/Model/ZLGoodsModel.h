//
//  ZLGoodsModel.h
//  ZLead
//
//  Created by dmy on 2019/6/4.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLGoodsModel : NSObject
@property (nonatomic, assign) NSInteger inventoryValue;//库存
@property (nonatomic, strong) NSString *goodsName; //商品名
@property (nonatomic, strong) NSString *goodsClassName1;//1级分类名
@property (nonatomic, strong) NSString *goodsClassName2;//2级名
@property (nonatomic, strong) NSString *skuId;//sku编号
@property (nonatomic, strong) NSString *spuId;//sgu编号
@property (nonatomic, strong) NSString *skuCode;//SKU编码
@property (nonatomic, strong) NSString *spuCode;//SPU编号
@property (nonatomic, strong) NSString *customCode;//商品自定义编号
@property (nonatomic, strong) NSString *shopId; //店铺编号
@property (nonatomic, strong) NSString *gooodsClassId2;//2级分类id
@property (nonatomic, strong) NSString *gooodsClassId1;//1级分类id
@property (nonatomic, strong) NSString *sgSpecs;//规格信息
@property (nonatomic, strong) NSString *priceId;//价格编号
@property (nonatomic, strong) NSArray *imagesUrls;//商品所有图片文件夹链接
@property (nonatomic, strong) NSString *fromSource;//发布渠道
@property (nonatomic, assign) NSInteger status;////状态  状态 -1：全部 1：销售中 2：下架 3：违规下架
@property (nonatomic, strong) NSString *createTime; //商品创建时间
@property (nonatomic, strong) NSString *endTime; //商品结束时间
@property (nonatomic, strong) NSString *goodsUint;// /单位
@property (nonatomic, strong) NSString *goodsType;//型号
@property (nonatomic, strong) NSString *desc; //商品描述信息
@property (nonatomic, strong) NSString *package; //包装清单
@property (nonatomic, strong) NSString *stockId; //店铺库存编号
@property (nonatomic, assign) BOOL isLock; // 是否锁定  1：锁定 2：解锁
@property (nonatomic, assign) BOOL isDelete; //是否删除 1：删除 2：未删除
@property (nonatomic, strong) NSString *remark;//备注字段
@property (nonatomic, strong) NSString *topTime;//置顶时间
@property (nonatomic, strong) NSString *goodSpecName;//规格名称
@property (nonatomic, strong) NSString *goodSpecValue;//规格值
@property (nonatomic, strong) NSString *offlinePrice;//线下售价
@property (nonatomic, strong) NSString *onlinePrice;//网销售价
@property (nonatomic, strong) NSString *costPrice;//进货价格
@property (nonatomic, assign) NSInteger goodsNum;
@property (nonatomic, assign) NSInteger monthSaleNum;//月销统计
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) int top;//置顶排序   默认1   置顶为2
@end

NS_ASSUME_NONNULL_END

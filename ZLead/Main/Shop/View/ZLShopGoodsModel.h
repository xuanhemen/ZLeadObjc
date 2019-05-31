//
//  ZLShopGoodsModel.h
//  ZLead
//
//  Created by dmy on 2019/5/28.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLShopGoodsModel : NSObject
@property (nonatomic, assign) NSInteger goodsNum;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) CGFloat salePrice;
@end

NS_ASSUME_NONNULL_END

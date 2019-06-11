//
//  ZLAddPlatformGoodsCell.h
//  ZLead
//
//  Created by dmy on 2019/6/11.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@class ZLGoodsModel;

@interface ZLAddPlatformGoodsCell : ZLBaseCell
@property (nonatomic, strong) void (^selectedButtonBlock) (ZLAddPlatformGoodsCell *cell, BOOL isSelected);
+ (CGFloat)heightForCell:(ZLGoodsModel *)goodsModel;
@end

NS_ASSUME_NONNULL_END

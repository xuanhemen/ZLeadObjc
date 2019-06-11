//
//  ZLAddPlatformGoodsCell.h
//  ZLead
//
//  Created by dmy on 2019/6/11.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@class ZLGoodsModel,ZLAddPlatformGoodsCell;

@protocol ZLAddPlatformGoodsCellDelegate <NSObject>
- (void)addPlatformGoodsCell:(ZLAddPlatformGoodsCell *)cell goodsNameChanged:(NSString *)goodsName;
- (void)addPlatformGoodsCell:(ZLAddPlatformGoodsCell *)cell goodsNumChanged:(NSInteger )goodsNum;
- (void)addPlatformGoodsCell:(ZLAddPlatformGoodsCell *)cell goodsNumOnlinePriceChanged:(CGFloat )onlinePrice;
- (void)addPlatformGoodsCell:(ZLAddPlatformGoodsCell *)cell goodsNumOfflinePriceChanged:(CGFloat )offlinePrice;
- (void)addPlatformGoodsCell:(ZLAddPlatformGoodsCell *)cell shopClassifyNameButton:(UIButton *)classifyNameButton;
@end

@interface ZLAddPlatformGoodsCell : ZLBaseCell
@property (nonatomic, strong) void (^selectedButtonBlock) (ZLAddPlatformGoodsCell *cell, BOOL isSelected);
@property (nonatomic, weak) id <ZLAddPlatformGoodsCellDelegate> delegate;
+ (CGFloat)heightForCell:(ZLGoodsModel *)goodsModel;
@end

NS_ASSUME_NONNULL_END

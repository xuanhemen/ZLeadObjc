//
//  ZLShoppingCartCell.h
//  ZLead
//
//  Created by dmy on 2019/5/28.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@class ZLShoppingCartCell;

@protocol ZLShoppingCartCellDelegate <NSObject>

- (void)numButtonClick:(ZLShoppingCartCell *)cell isAdd:(BOOL)isAdd;

- (void)goodsNumTFTextChanged:(ZLShoppingCartCell *)cell;

@end
@interface ZLShoppingCartCell : ZLBaseCell
@property (nonatomic, weak) id <ZLShoppingCartCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END

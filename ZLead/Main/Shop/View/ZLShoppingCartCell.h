//
//  ZLShoppingCartCell.h
//  ZLead
//
//  Created by dmy on 2019/5/28.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBaseCell.h"
#import "ZLShoppingCartView.h"

NS_ASSUME_NONNULL_BEGIN

@class ZLShoppingCartCell;

@protocol ZLShoppingCartCellDelegate <NSObject>

- (void)numButtonClick:(ZLShoppingCartCell *)cell isAdd:(BOOL)isAdd;

- (void)selectedButtonClick:(ZLShoppingCartCell *)cell isSelected:(BOOL)isSelected;

- (void)goodsNumTFTextChanged:(ZLShoppingCartCell *)cell;

@end
@interface ZLShoppingCartCell : ZLBaseCell
@property (nonatomic, strong) ZLShoppingCartView *shoppingCartView;
@property (nonatomic, weak) id <ZLShoppingCartCellDelegate> delegate;
- (void)setupViews;
@end

NS_ASSUME_NONNULL_END

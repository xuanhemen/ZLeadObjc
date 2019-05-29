//
//  ZLShoppingCartView.h
//  ZLead
//
//  Created by dmy on 2019/5/27.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZLShopGoodsModel;

@interface ZLShoppingCartView : UIView
@property (nonatomic, strong) void (^addButtonBlock) (void);
@property (nonatomic, strong) void (^minusButtonBlock) (void);
@property (nonatomic,strong) UITextField *goodsNumTF;
- (void)setSubviewsFrame:(BOOL )enableSelected;
- (void)setupData:(ZLShopGoodsModel *)goodsModel;
@end

NS_ASSUME_NONNULL_END

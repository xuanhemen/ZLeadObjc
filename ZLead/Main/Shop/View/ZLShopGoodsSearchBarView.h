//
//  ZLShopGoodsSearchBarView.h
//  ZLead
//
//  Created by dmy on 2019/5/29.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLShopGoodsSearchBarView : UIView
@property (nonatomic, copy) void (^startSearchBlock) (void);
@end

NS_ASSUME_NONNULL_END

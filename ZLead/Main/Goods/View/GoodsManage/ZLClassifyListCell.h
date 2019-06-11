//
//  ZLClassifyListCell.h
//  ZLead
//
//  Created by dmy on 2019/6/6.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBaseCell.h"

NS_ASSUME_NONNULL_BEGIN
@class ZLClassifyItemModel;

@interface ZLClassifyListCell : ZLBaseCell
@property (nonatomic, strong) void (^delGoodsClassifyBlock) (ZLClassifyItemModel *classifyItemModel);
@property (nonatomic, strong) void (^editGoodsClassifyBlock) (ZLClassifyItemModel *classifyItemModel);
@end

NS_ASSUME_NONNULL_END

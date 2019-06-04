//
//  ZLGoodsListCell.h
//  ZLead
//
//  Created by qzwh on 2019/5/30.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZLGoodsListCell : ZLBaseCell

/** 是否允许编辑 默认不允许 */
@property (nonatomic, assign)BOOL allowEdit;
@property (nonatomic, copy) void (^selectedButtonBlock) (BOOL isSelected);
@property (nonatomic, copy) void (^eidtButtonBlock) (void);
+ (ZLGoodsListCell *)listCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

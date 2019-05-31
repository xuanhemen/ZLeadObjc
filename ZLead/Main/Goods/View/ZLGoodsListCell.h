//
//  ZLGoodsListCell.h
//  ZLead
//
//  Created by qzwh on 2019/5/30.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLGoodsListCell : UITableViewCell

/** 是否允许编辑 默认不允许 */
@property (nonatomic, assign)BOOL allowEdit;
+ (ZLGoodsListCell *)listCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END

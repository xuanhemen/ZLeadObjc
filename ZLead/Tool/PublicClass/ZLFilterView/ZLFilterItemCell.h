//
//  ZLFilterItemCell.h
//  ZLead
//
//  Created by dmy on 2019/6/5.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZLFilterItemCell, ZLClassifyItemModel;

@protocol ZLFilterItemCellDelegate <NSObject>
- (void)selectedFilterItem:(ZLFilterItemCell *)item classifyItemModel:(ZLClassifyItemModel *)classifyItemModel;
@end

@interface ZLFilterItemCell : UICollectionViewCell
@property (nonatomic , strong) ZLClassifyItemModel *classifyItemModel;
@property (nonatomic , weak) id <ZLFilterItemCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END

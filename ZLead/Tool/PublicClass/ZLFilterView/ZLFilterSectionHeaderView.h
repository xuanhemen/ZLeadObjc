//
//  ZLFilterSectionHeaderView.h
//  ZLead
//
//  Created by dmy on 2019/6/5.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZLFilterDataModel, ZLFilterSectionHeaderView, ZLClassifyItemModel;

@protocol ZLFilterSectionHeaderViewDelegate <NSObject>
- (void)cancelSelectedClassify: (ZLFilterSectionHeaderView *)header filterDataModel: (ZLFilterDataModel *)filterDataModel;
- (void)manageClassify: (ZLFilterSectionHeaderView *)header filterDataModel: (ZLFilterDataModel *)filterDataModel;
@end

@interface ZLFilterSectionHeaderView : UICollectionReusableView
@property (nonatomic, strong) ZLFilterDataModel *filterDataModel;
//@property (nonatomic , strong) GHDropMenuModel *dropMenuModel;
@property (nonatomic, weak) id <ZLFilterSectionHeaderViewDelegate> delegate;
+ (CGFloat)heightForFilterSectionHeaderView:(ZLClassifyItemModel *)classifyItemModel;
@end

NS_ASSUME_NONNULL_END

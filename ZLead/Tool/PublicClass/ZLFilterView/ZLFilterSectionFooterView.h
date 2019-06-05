//
//  ZLFilterSectionFooterView.h
//  ZLead
//
//  Created by dmy on 2019/6/5.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZLFilterDataModel, ZLFilterSectionFooterView;

@protocol ZLFilterSectionFooterViewDelegate <NSObject>
- (void)filterSectionFooterView:(ZLFilterSectionFooterView *)footer isUnfold:(BOOL)isUnfold filterDataModel: (ZLFilterDataModel *)filterDataModel;
@end

@interface ZLFilterSectionFooterView : UICollectionReusableView
@property (nonatomic, strong) ZLFilterDataModel *filterDataModel;
@property (nonatomic, weak) id <ZLFilterSectionFooterViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END

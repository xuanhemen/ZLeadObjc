//
//  ZLFilterView.h
//  ZLead
//
//  Created by dmy on 2019/6/5.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZLFilterDataModel, ZLFilterView, ZLClassifyItemModel;

typedef void(^FilterViewBlock) (ZLClassifyItemModel *firstClassify, ZLClassifyItemModel *secondClassify, ZLClassifyItemModel *thirdClassify);

/** 出现方向*/
typedef NS_ENUM (NSUInteger, ZLFilterViewPushDirection) {
    /** 从左边出来 */
    ZLFilterViewPushDirectionFromLeft = 1,
    /** 从右边出来 */
    ZLFilterViewPushDirectionFromRight,
};

@protocol ZLFilterViewDelegate <NSObject>
- (void)filterView:(ZLFilterView *)filterView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface ZLFilterView : UIView
/** 动画时间 等于0 不开启动画 默认是0 */
@property (nonatomic, assign) NSTimeInterval durationTime;
@property (nonatomic, assign) BOOL isPlatform;//是平台分类
@property (nonatomic, weak) id <ZLFilterViewDelegate> delegate;
@property (nonatomic, strong) FilterViewBlock filterViewBlock;
@property (nonatomic, strong) void (^manageClassifyBlock) (NSInteger classifyType, NSString *parentId);
+ (instancetype)createFilterViewWidthConfiguration: (ZLFilterDataModel *)configuration
                                     pushDirection:(ZLFilterViewPushDirection )pushDirection
                                filterViewBlock: (FilterViewBlock)filterViewBlock;
- (void)reloadData:(ZLFilterDataModel *)filterDataModel section:(NSInteger )section;
- (void)reloadData:(ZLFilterDataModel *)filterDataModel;
- (void)dismiss;
- (void)show;
@end

NS_ASSUME_NONNULL_END

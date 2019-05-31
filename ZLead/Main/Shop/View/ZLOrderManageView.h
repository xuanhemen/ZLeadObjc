//
//  ZLOrderManageView.h
//  ZLead
//
//  Created by dmy on 2019/5/30.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLSegmentTitleView;
@class ZLScrollContentView;

NS_ASSUME_NONNULL_BEGIN

@interface ZLOrderManageView : UIView
//@property (nonatomic, strong) UITableView *orderListTableView;
@property (nonatomic, strong) ZLSegmentTitleView *titleView;
@property (nonatomic, strong) ZLScrollContentView *contentView;
@end

NS_ASSUME_NONNULL_END

//
//  ZLGoodsSearchResultView.h
//  ZLead
//
//  Created by dmy on 2019/6/6.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLGoodsManagerView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZLGoodsSearchResultView : UIView
@property (nonatomic, strong) UITableView *resultTableView;
@property (nonatomic, strong) ZLGoodsManagerView *bottomManagerView;
@end

NS_ASSUME_NONNULL_END

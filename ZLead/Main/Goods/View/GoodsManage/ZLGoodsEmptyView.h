//
//  ZLGoodsEmptyView.h
//  ZLead
//
//  Created by dmy on 2019/6/10.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLGoodsEmptyView : UIView
@property (nonatomic, copy) void (^operateButtonBlock) (void);
@end

NS_ASSUME_NONNULL_END

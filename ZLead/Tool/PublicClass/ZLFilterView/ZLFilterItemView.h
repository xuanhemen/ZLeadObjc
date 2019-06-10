//
//  ZLFilterItemView.h
//  ZLead
//
//  Created by dmy on 2019/6/5.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZLClassifyItemModel;

@interface ZLFilterItemView : UIView
@property (nonatomic, copy) void (^cancelSelectedBlock) (void);
@property (nonatomic, strong) ZLClassifyItemModel *classifyItemModel;
@end

NS_ASSUME_NONNULL_END

//
//  ZLShopTopView.h
//  ZLead
//
//  Created by dmy on 2019/5/25.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZLShopModel;

@interface ZLShopTopView : UIView
@property (nonatomic, copy) void (^changeShopBlock) (void);
- (void)setupData:(ZLShopModel *)shopModel;
@end

NS_ASSUME_NONNULL_END

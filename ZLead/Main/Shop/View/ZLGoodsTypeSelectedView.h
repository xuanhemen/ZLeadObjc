//
//  ZLGoodsTypeSelectedView.h
//  ZLead
//
//  Created by dmy on 2019/5/28.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLGoodsTypeSelectedView : UIView
@property (nonatomic, copy) void (^resetButtonBlock) (void);
@property (nonatomic, copy) void (^sureButtonBlock) (NSString *fType, NSString *sType, NSString *tType);
@end

NS_ASSUME_NONNULL_END

//
//  ZLPaymentMethodCell.h
//  ZLead
//
//  Created by dmy on 2019/5/28.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZLPaymentMethodCell : ZLBaseCell
@property (nonatomic, copy) void (^markButtonBlock) (BOOL isSelected);
@end

NS_ASSUME_NONNULL_END

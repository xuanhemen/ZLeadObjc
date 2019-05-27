//
//  ZLShopManagerNoteCell.h
//  ZLead
//
//  Created by dmy on 2019/5/25.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLBaseCell.h"

NS_ASSUME_NONNULL_BEGIN



@interface ZLShopManagerNoteCell : ZLBaseCell
@property (nonatomic, copy) void (^shopManagerActionBlock) (void);
@property (nonatomic, copy) void (^aboutUsActionBlock) (void);
@end

NS_ASSUME_NONNULL_END

//
//  ZLBrandVC.h
//  ZLead
//
//  Created by 董建伟 on 2019/6/11.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZLBrandVC : ZLBaseViewController


@property (nonatomic, copy) void (^selecItem)(NSString *title,NSString *brandID); // 选中回调
@end

NS_ASSUME_NONNULL_END

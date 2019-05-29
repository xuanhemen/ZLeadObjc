//
//  ZLSetWechatVC.h
//  ZLead
//
//  Created by qzwh on 2019/5/27.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBaseViewController.h"

typedef NS_ENUM(NSInteger, AccountType) {
    AccountTypeWechat,
    AccountTypeAlipay,
};

NS_ASSUME_NONNULL_BEGIN

@interface ZLSetWechatVC : ZLBaseViewController

/** <#注释#> */
@property (nonatomic,assign) AccountType type;



@end

NS_ASSUME_NONNULL_END

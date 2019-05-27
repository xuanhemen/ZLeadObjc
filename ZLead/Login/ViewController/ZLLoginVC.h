//
//  ZLLoginVC.h
//  ZLead
//
//  Created by 董建伟 on 2019/5/23.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBaseViewController.h"
#import "ZLLoginView.h"
NS_ASSUME_NONNULL_BEGIN


@interface ZLLoginVC : ZLBaseViewController


@property (nonatomic, copy) NSString *indentifier; // 登录还是注册
@property (nonatomic, strong)ZLLoginView *loginView; // 登录视图
@end

NS_ASSUME_NONNULL_END

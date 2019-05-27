//
//  ZLLoginView.h
//  ZLead
//
//  Created by 董建伟 on 2019/5/23.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLLoginViewModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,LogStyle) {
    /**
     * 登录界面
     */
    LogStyleLogin = 0,
    /**
     * 注册界面
     */
    LogStyleRegister
};
@interface ZLLoginView : UIView

@property (nonatomic, strong) UIButton *pwLogin; // 使用账号密码登录
@property (nonatomic, strong) UIButton *rsBtn; // 去注册

@property (nonatomic,assign) LogStyle style; //登录类型（登录、注册）

/** 初始化用ViewModel */
-(instancetype)initWithFrame:(CGRect)frame viewModel:(ZLLoginViewModel *)viewModel style:(LogStyle)style;
@end

NS_ASSUME_NONNULL_END

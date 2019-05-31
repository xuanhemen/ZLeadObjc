//
//  ZLSetPasswordVC.h
//  ZLead
//
//  Created by 董建伟 on 2019/5/28.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,SetPWStyle){
    SetPWStyleNewSet = 0, //第一次设置密码
    SetPWStyleForgetSet  //忘记密码时找回密码
};
@interface ZLSetPasswordVC : ZLBaseViewController


@property (nonatomic,assign) SetPWStyle style; //找回密码类型
@end

NS_ASSUME_NONNULL_END

//
//  ZLLoginViewModel.h
//  ZLead
//
//  Created by 董建伟 on 2019/5/23.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLLoginViewModel : NSObject<UITextFieldDelegate>

@property (nonatomic, strong) RACSubject *goRegister; // 去注册

@property (nonatomic, strong) RACSubject *goLogin; // 从注册界面切回到登录界面

@property (nonatomic, strong) RACSubject *login; // 登录

@property (nonatomic, strong) RACSubject *getCode; // 获取验证码

@property (nonatomic, copy) NSString *phoneNumber; // 手机号


/** 负责跳转 */
-(void)jumpFromController:(UIViewController *)vc;

@end

NS_ASSUME_NONNULL_END

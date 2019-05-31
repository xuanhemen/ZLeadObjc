//
//  NetManager+ZLLoginAPI.h
//  ZLead
//
//  Created by dmy on 2019/5/31.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "NetManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetManager (ZLLoginAPI)
/**
 登录
 
 @param phoneNum 手机号码//验证码和密码登录两种方式
 @param password 密码
 @param smscode 密码
 @param sucess 成功
 @param fail 失败
 */
- (void)loginWithPhoneNum:(NSString *)phoneNum
                 password:(NSString *)password
                 smscode:(NSString *)smscode
                   sucess:(resultBlock)sucess
                     fail:(failWithErrorBlock)fail;

/**
 获取短信验证码
 
 @param phoneNum 手机号码
 @param serviceId 短信服务类型 1
 @param sucess 成功
 @param fail 失败
 */
- (void)getPhoneValidateCode:(NSString *)phoneNum
                 serviceId:(NSString *)serviceId
                   sucess:(resultBlock)sucess
                     fail:(failWithErrorBlock)fail;

/**
 验证手机号是否注册
 
 @param phoneNum 手机号码
 @param sucess 成功
 @param fail 失败
 */
- (void)checkIsRegByPhone:(NSString *)phoneNum
                      sucess:(resultBlock)sucess
                        fail:(failWithErrorBlock)fail;

@end

NS_ASSUME_NONNULL_END

//
//  NetManager+ZLLoginAPI.m
//  ZLead
//
//  Created by dmy on 2019/5/31.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "NetManager+ZLLoginAPI.h"

@implementation NetManager (ZLLoginAPI)

- (void)loginWithPhoneNum:(NSString *)phoneNum
                 password:(NSString *)password
                  smscode:(NSString *)smscode
                   sucess:(resultBlock)sucess
                     fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"phone"] = phoneNum;
    if (password.length > 0) {
        dict[@"password"] = password;
    }
    if (smscode.length > 0) {
        dict[@"code"] = smscode;
    }
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_LOGIN parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        sucess(responseObject);
    } fail:^(NSError * _Nonnull error) {
        fail(error);
    }];
}

- (void)getPhoneValidateCode:(NSString *)phoneNum
                   serviceId:(NSString *)serviceId
                      sucess:(resultBlock)sucess
                        fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"phone"] = phoneNum;
    dict[@"serviceId"] = serviceId;
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_PhoneValidateCode parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        sucess(responseObject);
    } fail:^(NSError * _Nonnull error) {
        
    }];
}

- (void)checkIsRegByPhone:(NSString *)phoneNum
                   sucess:(resultBlock)sucess
                     fail:(failWithErrorBlock)fail {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"phone"] = phoneNum;
    [[NetManager sharedInstance] postRequestWithPath:ZLURL_CheckIsRegByPhone parameters:dict sueccessful:^(id  _Nonnull responseObject) {
        sucess(responseObject);
    } fail:^(NSError * _Nonnull error) {
        fail(error);
    }];
}

@end

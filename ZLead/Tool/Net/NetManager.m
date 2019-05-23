//
//  NetManager.m
//  Demo
//
//  Created by 董建伟 on 2019/4/1.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "NetManager.h"
#import "ZLConfig.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
@implementation NetManager

static NetManager *_instance = nil;
+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    });
    return _instance;
}
+ (id)allocWithZone:(struct _NSZone *)zone{
    return [NetManager sharedInstance];
}

- (id)copyWithZone:(nullable NSZone *)zone {
    return [NetManager sharedInstance];
}
/**get请求*/
+ (void)getWithURLString:(NSString *)URLString
                 params:(id)params
                success:(void (^)(NSDictionary *response))success
                failure:(void (^)(NSDictionary *errorMsg))failure{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20.0f;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlStr = [ZL_BASE_URL stringByAppendingPathComponent:URLString];
    [manager GET:urlStr parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        /**请求成功*/
        success(dic);
        /**请求失败*/
        failure(dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        /**请求失败 code*/
        
    }];
}
/**post请求*/
+ (void)postWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(NSDictionary *response))success
                 failure:(void (^)(NSDictionary *errorMsg))failure{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20.0f;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlStr = [ZL_BASE_URL stringByAppendingPathComponent:URLString];
    [manager POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
#ifdef DEBUG
        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        DLog(@"%@",jsonStr);
#else
#endif
        
        NSError *error;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        /**请求成功*/
        success(dic);
        /**请求失败*/
        failure(dic);
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        /**请求失败 code*/
    }];
}
/**http请求*/
+ (void)requestWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                       type:(HttpRequestType)type
                    success:(void (^)(NSDictionary *response))success
                    failure:(void (^)(NSDictionary *errorMsg))failure{
    
    switch (type) {
        case HttpRequestTypeGet:
        {
            [NetManager getWithURLString:URLString params:parameters success:success failure:failure];
        }
            break;
        case HttpRequestTypePost:
        {
            [NetManager postWithURLString:URLString parameters:parameters success:success failure:failure];
        }
            break;
        default:
            break;
    }
    
}
///**展示HUD*/
//- (void)showHUD{
////    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
////    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];
//    [SVProgressHUD setBackgroundColor:[UIColor grayColor]];
//    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//    [SVProgressHUD showWithStatus:@"正在加载..."];
//}
///**加载完成取消HUD*/
//- (void)dismissHUD{
//    [SVProgressHUD dismiss];
//}
@end

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
#import "NSDictionary+Function.h"
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
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20.0f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"application/json;charset=UTF-8", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    NSString *urlStr = [ZL_BASE_URL stringByAppendingPathComponent:URLString];
    NSMutableDictionary *param = [NSMutableDictionary splicingParameters:parameters]; //拼接参数
    NSLog(@"请求%@",param);
    [manager POST:urlStr parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
#ifdef DEBUG
        //        NSString *jsonStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //        DLog(@"%@",jsonStr);
#else
#endif
        NSError *error;
        //        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        /**请求成功*/
        success(responseObject);
        //        NSString *str = [dic objectForKey:@"statusCode"];
        //        if ([str isEqualToString:@"200"]){//
        //            NSDictionary *dictionary = [dic objectForKey:@"data"];
        //            NSString *code = [dictionary objectForKey:@"code"];
        //            if ([code isEqualToString:@"200"]) {
        //                NSDictionary *dataDic = [dictionary objectForKey:@"zlw_user"];
        //                NSLog(@"%@",dataDic);
        //
        //            }else if ([code isEqualToString:@"301"]){//
        //                NSLog(@"该账号已经注册");
        //            }
        //
        //
        //        }else if ([str isEqualToString:@"500"]){
        //
        //            NSLog(@"");
        //        }
        /**请求失败*/
        //        failure(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        /**请求失败 code*/
        DLog(@"接口=%@请求失败=%@", URLString, error.userInfo);
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

- (void)postRequestWithPath:(NSString*)path andParameters:(NSMutableDictionary*)parameters forSueccessful:(void(^)(id responseObject))successful forFail:(void(^)(NSError *error)) fail {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer.timeoutInterval = 20.0f;
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"application/json;charset=UTF-8", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    NSString *urlStr = [ZL_BASE_URL stringByAppendingPathComponent:path];
    NSMutableDictionary *param = [NSMutableDictionary splicingParameters:parameters]; //拼接参数
    DLog(@"POST请求地址:%@请求的参数:%@------------------------------------",path,parameters);
    [mgr POST:urlStr parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // responseObject 返回状态码 200 表示成功
        if ([responseObject[@"error"] intValue] != 200) {
            // 将服务器返回错误message包装成NSError对象返回
            NSString *description = responseObject[@"message"];
            NSError *messageError = [NSError errorWithDomain:@"MessageError" code:[responseObject[@"error"] intValue] userInfo:@{NSLocalizedDescriptionKey:description}];
            fail(messageError);
        } else {
            successful(responseObject[@"data"]);
        }
        DLog(@"接口path=%@请求成功了! 返回的参数:%@,message=%@", path, responseObject,responseObject[@"message"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
        DLog(@"接口请求失败了 原因:%@",error);
        
    }];
    
}

- (void)getRequestWithPath:(NSString*)path andParameters:(NSMutableDictionary*)parameters forSueccessful:(void(^)(id responseObject))successful forFail:(void(^)(NSError *error)) fail {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer.timeoutInterval = 20.0f;
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"application/json;charset=UTF-8", @"text/json", @"text/javascript",@"text/html",@"text/plain",nil];
    NSString *urlStr = [ZL_BASE_URL stringByAppendingPathComponent:path];
    
    DLog(@"get请求地址:%@请求的参数:%@------------------------------------\n",path,parameters);
    [mgr GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // responseObject 返回状态码 200 表示成功
        if ([responseObject[@"error"] intValue] != 200) {
            // 将服务器返回错误message包装成NSError对象返回
            NSString *description = responseObject[@"message"];
            NSError *messageError = [NSError errorWithDomain:@"MessageError" code:9999 userInfo:@{NSLocalizedDescriptionKey:description}];
            fail(messageError);
            
        } else {
            successful(responseObject[@"data"]);
        }
        DLog(@"接口path=%@请求成功了! 返回的参数:%@,message=%@", path, responseObject,responseObject[@"message"]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
        DLog(@"接口请求失败了 原因:%@",error);
    }];
    
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

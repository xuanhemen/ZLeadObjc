//
//  NetManager.h
//  Demo
//
//  Created by 董建伟 on 2019/4/1.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,HttpRequestType) {
    /**
     * get请求
     */
    HttpRequestTypeGet = 0,
    /**
     * post请求
     */
    HttpRequestTypePost
};

@interface NetManager : NSObject

/** 单例方法*/
+(instancetype)sharedInstance;

/**
 *  发送get请求
 *
 *  @param URLString 请求的网址字符串
 *  @param params    请求的参数
 *  @param success   请求成功的回调
 *  @param failure   请求失败的回调
 */
+(void)getWithURLString:(NSString *)URLString
                 params:(id)params
                success:(void (^)(NSDictionary *response))success
                failure:(void (^)(NSDictionary *errorMsg))failure;
/**
 *  发送post请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+(void)postWithURLString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
                 success:(void (^)(NSDictionary *response))success
                 failure:(void (^)(NSDictionary *errorMsg))failure;
/**
 *  发送http请求
 *
 *  @param URLString  请求的网址字符串
 *  @param parameters 请求的参数
 *  @param type       请求方式
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 */
+(void)requestWithURLString:(NSString *)URLString
                 parameters:(id)parameters
                       type:(HttpRequestType)type
                    success:(void (^)(NSDictionary *response))success
                    failure:(void (^)(NSDictionary *errorMsg))failure;
@end

NS_ASSUME_NONNULL_END

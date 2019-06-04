//
//  NetManager+ZLShopAPI.h
//  ZLead
//
//  Created by dmy on 2019/6/3.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "NetManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetManager (ZLShopAPI)
/**
 获取公司/店铺记录
 
 @param userId 用户ID
 @param sucess 成功
 @param fail 失败
 */
- (void)getShopListWithUserId:(NSString *)userId
                   sucess:(successBlock)sucess
                     fail:(failWithErrorBlock)fail;
@end

NS_ASSUME_NONNULL_END

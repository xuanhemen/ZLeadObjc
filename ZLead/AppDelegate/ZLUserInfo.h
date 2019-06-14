//
//  ZLUserInfo.h
//  ZLead
//
//  Created by 董建伟 on 2019/6/1.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLUserInfo : NSObject

@property (nonatomic, copy) NSString *userID; // 用户id
@property (nonatomic, copy) NSString *currentShopId; // 当前选择的店铺

+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END

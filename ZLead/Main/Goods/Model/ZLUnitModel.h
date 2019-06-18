//
//  ZLUnitModel.h
//  ZLead
//
//  Created by 董建伟 on 2019/6/17.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLUnitModel : NSObject

@property (nonatomic, copy) NSString *sguId; // 编号
@property (nonatomic, copy) NSString *sguName; // 单位名称
@property (nonatomic, copy) NSString *sguRemark; // 备注
@end

NS_ASSUME_NONNULL_END

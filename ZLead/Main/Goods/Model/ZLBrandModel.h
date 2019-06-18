//
//  ZLBrandModel.h
//  ZLead
//
//  Created by 董建伟 on 2019/6/18.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLBrandModel : NSObject

@property (nonatomic, copy) NSString *sgbNamePinyin; //
@property (nonatomic, copy) NSString *sgbNamePyFirst; // annotation
@property (nonatomic, copy) NSString *sgbRemark; // <#annotation#>
@property (nonatomic, copy) NSString *sgbId; // 品牌id
@property (nonatomic, copy) NSString *pgbId; // <#annotation#>
@property (nonatomic, copy) NSString *sgbName; // 品牌名称
@property (nonatomic, copy) NSString *sgmId; // <#annotation#>


@end

NS_ASSUME_NONNULL_END

//
//  ZLGoodsModel.h
//  ZLead
//
//  Created by dmy on 2019/6/4.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLGoodsModel : NSObject
@property (nonatomic, strong) NSString *goodsId;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, strong) NSString *gooodsClassId1;
@property (nonatomic, strong) NSString *goodsClassName1;
@property (nonatomic, strong) NSString *gooodsClassId2;
@property (nonatomic, strong) NSString *goodsClassName2;
@property (nonatomic, strong) NSString *goodsUint;
@property (nonatomic, assign) NSInteger goodsNum;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL top;
@end

NS_ASSUME_NONNULL_END

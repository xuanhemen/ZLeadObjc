//
//  ZLClassifyItemModel.h
//  ZLead
//
//  Created by dmy on 2019/6/5.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLClassifyItemModel : NSObject
@property (nonatomic, strong) NSString *classifyId;//编号
@property (nonatomic, strong) NSString *classifyCode;//编码
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) NSInteger shopId;//店铺ID
@property (nonatomic, assign) NSInteger parentId;//父id
@property (nonatomic, strong) NSString *remark;//"备注",
@property (nonatomic, assign) NSInteger level; //等级： 1 ， 2
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL isPlatform;
@property (nonatomic, strong) NSArray <ZLClassifyItemModel *> *childrenList;//子分类
@end

NS_ASSUME_NONNULL_END

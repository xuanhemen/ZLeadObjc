//
//  ZLAddClassifyNameVC.h
//  ZLead
//
//  Created by dmy on 2019/6/10.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBaseViewController.h"

@class ZLClassifyItemModel;
NS_ASSUME_NONNULL_BEGIN

@interface ZLAddClassifyNameVC : ZLBaseViewController
@property (nonatomic, assign) NSString *parentId;//父id
@property (nonatomic, assign) NSInteger level; //等级： 1 ， 2
@property (nonatomic, strong) ZLClassifyItemModel *classifyItemModel;//是编辑需要传，添加不需要传
@property (nonatomic, copy) void (^addClassifySuccessBlock) (void);
@end

NS_ASSUME_NONNULL_END

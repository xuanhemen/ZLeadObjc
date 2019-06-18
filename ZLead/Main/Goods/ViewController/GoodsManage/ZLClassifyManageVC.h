//
//  ZLClassifyListViewController.h
//  ZLead
//
//  Created by dmy on 2019/6/6.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZLClassifyManageVC : ZLBaseViewController
@property (nonatomic, assign) NSString *parentId;//父id
@property (nonatomic, assign) NSInteger level; //等级： 1 ， 2
//@property (nonatomic, assign) BOOL isFromPlatform;//yes 平台分类 no 来自店铺
@end

NS_ASSUME_NONNULL_END

//
//  ZLAddGoodsViewModel.h
//  ZLead
//
//  Created by 董建伟 on 2019/6/6.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLAddGoodsViewModel : NSObject<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic, strong) NSMutableArray *dataArr; // 数据源


@end

NS_ASSUME_NONNULL_END

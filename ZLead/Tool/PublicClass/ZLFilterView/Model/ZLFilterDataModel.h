//
//  ZLFilterDataModel.h
//  ZLead
//
//  Created by dmy on 2019/6/5.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ZLClassifyItemModel;

@interface ZLFilterDataModel : NSObject
@property (nonatomic, strong) ZLClassifyItemModel *selectedClassifyItemModel;
@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, assign) BOOL isUnflod;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSString *sectionName;
@end

NS_ASSUME_NONNULL_END

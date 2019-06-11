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
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) NSInteger classifyId;
@property (nonatomic, strong) NSString *sgcCode;
@property (nonatomic, assign) NSInteger sgcParentId;
@property (nonatomic, assign) NSInteger sgcLevel;
@property (nonatomic, strong) NSString *sgcRemark;
@end

NS_ASSUME_NONNULL_END

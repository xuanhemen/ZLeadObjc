//
//  ZLBatchSetClassifyView.h
//  ZLead
//
//  Created by dmy on 2019/6/11.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLBatchSetClassifyView : UIView
@property (nonatomic, strong) void (^batchSetClassifyBlock) (void);
- (void)setSelectedGoodsNum:(NSInteger )num;
@end

NS_ASSUME_NONNULL_END

//
//  ZLSpeTableView.h
//  ZLead
//
//  Created by 董建伟 on 2019/6/12.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLAddGoodsViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZLSpeTableView : UIView

- (instancetype)initWithFrame:(CGRect)frame param:(NSDictionary *)params viewModel:(ZLAddGoodsViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END

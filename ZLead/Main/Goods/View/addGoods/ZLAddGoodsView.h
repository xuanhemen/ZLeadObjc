//
//  ZLAddGoodsView.h
//  ZLead
//
//  Created by 董建伟 on 2019/6/10.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLAddGoodsViewModel.h"
#import "ZLAddGoodsImgView.h"
#import "ZLAddImgViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZLAddGoodsView : UIView

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *sureBtn; // 确定

- (instancetype)initWithFrame:(CGRect)frame viewModel:(ZLAddGoodsViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END

//
//  ZLImgTextView.h
//  ZLead
//
//  Created by 董建伟 on 2019/6/13.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLDescribeView.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZLImgTextView : UIView

@property (nonatomic,assign) BOOL isEmpty; //是否是空的视图
@property (nonatomic, strong) UIButton *imgBtn; //

@property (nonatomic, strong) ZLDescribeView *desView; // 商品描述

@end

NS_ASSUME_NONNULL_END

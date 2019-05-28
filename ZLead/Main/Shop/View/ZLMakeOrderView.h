//
//  ZLMakeOrderView.h
//  ZLead
//
//  Created by dmy on 2019/5/28.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLMakeOrderView : UIView
@property (nonatomic, strong) UITableView *goodsListTableView;
@property (nonatomic, strong) UIButton *allSelectedButton;
@property (nonatomic, copy)  void (^allSelectedBlock) (BOOL isSelected);
@end

NS_ASSUME_NONNULL_END

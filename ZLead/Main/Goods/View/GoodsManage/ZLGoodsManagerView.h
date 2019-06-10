//
//  ZLGoodsManagerView.h
//  ZLead
//
//  Created by dmy on 2019/6/4.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLGoodsManagerView : UIView
@property (nonatomic, strong) UIButton *allSelectedButton;
@property (nonatomic, copy) void (^allSelectedBlock) (BOOL isSelected);
@property (nonatomic, copy) void (^unShelveBlock) (void);
@property (nonatomic, copy) void (^delBlock) (void);
@property (nonatomic, copy) void (^topBlock) (void);
@property (nonatomic, copy) void (^cancelTopBlock) (void);
- (void)refreshUnShelveButton:(BOOL )isEnableUnShelve;
- (void)refreshDelButton:(BOOL )isEnableDel;
- (void)refreshTopButton:(BOOL )isEnableTop;
- (void)refreshCanelTopButton:(BOOL )isCancelTop;
- (void)reset;
@end

NS_ASSUME_NONNULL_END

//
//  ZLSearchBarView.h
//  ZLead
//
//  Created by dmy on 2019/6/6.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLSearchBarView;

@protocol ZLSearchBarViewDelegate <NSObject>
@optional
- (void)backPreviousPage;
- (void)addGoods;
- (void)manageGoods:(UIButton *)manageBtn;
- (void)searchGoods;
@end

NS_ASSUME_NONNULL_BEGIN

@interface ZLSearchBarView : UIView
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, weak) id <ZLSearchBarViewDelegate> delegate;
- (void)changeSearchBarViewStyle:(BOOL)enableManage;
@end

NS_ASSUME_NONNULL_END

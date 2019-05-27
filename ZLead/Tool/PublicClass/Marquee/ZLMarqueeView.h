//
//  ZLMarqueeView.h
//  ZLead
//
//  Created by dmy on 2019/5/27.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZLMarqueeView : UIView
/** 标题的字体 默认为14 */
@property(nonatomic)UIFont *titleFont;
/**标题的颜色 默认红色*/
@property(nonatomic)UIColor *titleColor;
/**存放titles的数组 和初始化的数组一致*/
@property(nonatomic)NSArray *titleArr;
//回调
@property(nonatomic,copy)void(^handlerTitleClickCallBack)(NSInteger index);

#pragma mark - init Methods

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSArray *)titles;
@end

NS_ASSUME_NONNULL_END

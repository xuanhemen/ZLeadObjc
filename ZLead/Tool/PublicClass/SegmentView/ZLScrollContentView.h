//
//  ZLScrollContentView.h
//  ZLead
//
//  Created by dmy on 2019/5/29.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLScrollContentView;

@protocol ZLScrollContentViewDelegate <NSObject>

@optional

- (void)contentViewDidScroll:(ZLScrollContentView *)contentView fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex progress:(float)progress;

- (void)contentViewDidEndDecelerating:(ZLScrollContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex;

@end

@interface ZLScrollContentView : UIView

/**
 加载滚动视图的界面
 
 @param childVcs 当前View需要装入的控制器集合
 @param parentVC 当前View所在的父控制器
 */
- (void)reloadViewWithChildVcs:(NSArray<UIViewController *> *)childVcs parentVC:(UIViewController *)parentVC;

@property (nonatomic, weak) id<ZLScrollContentViewDelegate> delegate;

/**
 设置当前滚动到第几个页面，默认为第0页
 */
@property (nonatomic, assign) NSInteger currentIndex;

@end

//
//  GeneralTableView.h
//  Demo
//
//  Created by 董建伟 on 2019/4/4.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GeneralTableViewDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface GeneralTableView : UITableView

/** delegate类 */
@property(nonatomic,strong)GeneralTableViewDelegate * tableDelegate;

/**
    初始化
 
 *  @param  frame      坐标
 *  @param  style      样式（plain或group）
 *  @param  array      数据源
 *  @param  height     行高
 *  @param  myCell     创建cell
 *  @param  selecBlock 点击cell执行此block
 *  @return  返回tableView实例
 */

-(instancetype)initWithFrame:(CGRect)frame
                       style:(UITableViewStyle)style
                       array:(NSArray *)array
                  cellHeight:(CGFloat)height
                        cell:(UITableViewCell * (^)(UITableView *tableView,NSIndexPath *indexPaht))myCell
                selectedCell:(void (^)(NSIndexPath *indexPath))selecBlock;

/**
 下拉刷新

 @param downFresh 下拉回调
 */
-(void)addDropDownRefresh:(void (^)(void))downFresh;

/**
 上拉加载

 @param pullFresh 上拉回调
 */
-(void)addPullUpLoading:(void (^)(void))pullFresh;

/**
 结束刷新
 */
-(void)endFresh;

@end

NS_ASSUME_NONNULL_END

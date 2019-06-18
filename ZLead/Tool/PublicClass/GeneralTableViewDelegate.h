//
//  GeneralTableViewDelegate.h
//  Demo
//
//  Created by 董建伟 on 2019/4/4.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface GeneralTableViewDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>


/** section下的行数 */
@property(nonatomic,copy)NSInteger (^secRow)(NSInteger);
/** 数据源 */
@property(nonatomic,strong)NSArray * dataArr;
/** 创建cell */
@property(nonatomic,copy)UITableViewCell *(^createCell)(UITableView *,NSIndexPath *);
/** 点击cell */
@property(nonatomic,copy)void (^selecBlock)(NSIndexPath *indexPath);
/** 创建sectionView */
@property(nonatomic,copy)UIView * (^secView)(NSInteger section);

@property (nonatomic, copy) NSString *ind; // <#annotation#> 
/**
 配置代理

 @param array 数据源
 @param cell 创建cell
 @param selectedBlock 点击cell
 */
-(void)configDelegateWithArray:(NSArray *)array
                          cell:(UITableViewCell *(^)(UITableView *,NSIndexPath*))cell
                   selecedCell:(void (^)(NSIndexPath *)) selectedBlock;
@end

NS_ASSUME_NONNULL_END

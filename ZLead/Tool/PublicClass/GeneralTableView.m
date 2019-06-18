//
//  GeneralTableView.m
//  Demo
//
//  Created by 董建伟 on 2019/4/4.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "GeneralTableView.h"
#import "MJRefresh.h"
@implementation GeneralTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style array:(NSArray *)array cellHeight:(CGFloat)height cell:(UITableViewCell * (^)(UITableView *tableView,NSIndexPath *indexPath))myCell selectedCell:(void (^)(NSIndexPath *indexPath))selecBlock{
    self = [super initWithFrame:frame style:style];
    if (self) {

        //配置代理
        self.delegate = self.tableDelegate;
        self.dataSource = self.tableDelegate;
        [self.tableDelegate configDelegateWithArray:array cell:myCell selecedCell:selecBlock];
        self.tableDelegate.ind = @"测试";
        self.rowHeight = height;
        if (style == UITableViewStylePlain) {
            self.sectionHeaderHeight = 0;
        }
        self.sectionFooterHeight = 0;
        self.tableFooterView = [UIView new];
    }
    return self;
    
}

/**
 实例化代理对象

 @return 代理实例
 */
-(GeneralTableViewDelegate *)tableDelegate{
    if (!_tableDelegate) {
        _tableDelegate = [[GeneralTableViewDelegate alloc] init];
    }
    return _tableDelegate;
}
- (void)addDropDownRefresh:(void (^)(void))downFresh{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       downFresh();
    }];
    header.stateLabel.textColor = [UIColor lightGrayColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
    self.mj_header = header;
}
- (void)addPullUpLoading:(void (^)(void))pullFresh{
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        pullFresh();
    }];
    footer.stateLabel.text = @"加载更多";
    footer.stateLabel.textColor = [UIColor lightGrayColor];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载数据" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多数据了" forState:MJRefreshStateNoMoreData];
    self.mj_footer = footer;

}
- (void)endFresh{
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
    
}

@end

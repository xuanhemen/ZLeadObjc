//
//  ZLGoodsSearchResultView.m
//  ZLead
//
//  Created by dmy on 2019/6/6.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLGoodsSearchResultView.h"
#import "ZLGoodsHeaderView.h"
#import "ZLGoodsManagerView.h"

@interface ZLGoodsSearchResultView ()

@property (nonatomic, strong) ZLGoodsHeaderView *headerView;
@property (nonatomic, assign) BOOL allowEdit;
@property (nonatomic, assign) BOOL isAllSelected;
@end

@implementation ZLGoodsSearchResultView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.headerView = [[ZLGoodsHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 45)];
    [self addSubview:self.headerView];
    
    self.resultTableView.frame = CGRectMake(0, 45, kScreenWidth, self.frame.size.height - 45);
    
    self.bottomManagerView = [[ZLGoodsManagerView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - dis(50), kScreenWidth, dis(50))];
    self.bottomManagerView.hidden = YES;
    [self addSubview:self.bottomManagerView];
}

#pragma mark - lazy load

- (UITableView *)resultTableView {
    if (!_resultTableView) {
        _resultTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self addSubview:self.resultTableView];
        _resultTableView.tableFooterView = [UIView new];
        _resultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _resultTableView;
}

@end

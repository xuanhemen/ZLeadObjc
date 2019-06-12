//
//  ZLSearchAddPlatformGoodsView.m
//  ZLead
//
//  Created by dmy on 2019/6/12.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLSearchAddPlatformGoodsView.h"
#import "ZLGoodsHeaderView.h"
#import "ZLGoodsManagerView.h"

@interface ZLSearchAddPlatformGoodsView ()
@end

@implementation ZLSearchAddPlatformGoodsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.resultTableView.frame = CGRectMake(0, 0, kScreenWidth, self.frame.size.height - dis(50) - kSafeHeight);
    self.batchSetClassifyView.frame = CGRectMake(0, kScreenHeight - dis(50) - kSafeHeight, kScreenWidth, dis(50));
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

- (ZLBatchSetClassifyView *)batchSetClassifyView {
    if (!_batchSetClassifyView) {
        _batchSetClassifyView = [[ZLBatchSetClassifyView alloc] initWithFrame:CGRectZero];
         [self addSubview:self.batchSetClassifyView];
    }
    return _batchSetClassifyView;
}

@end

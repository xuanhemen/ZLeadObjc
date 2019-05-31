//
//  ZLOrderManageView.m
//  ZLead
//
//  Created by dmy on 2019/5/30.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLOrderManageView.h"
#import "ZLOrderListCell.h"
#import "ZLSegmentTitleView.h"
#import "ZLScrollContentView.h"

@interface ZLOrderManageView ()

@end

@implementation ZLOrderManageView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
//    self.orderListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
//    self.orderListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.orderListTableView.backgroundColor = [UIColor clearColor];
//    [self.orderListTableView registerClass:[ZLOrderListCell class] forCellReuseIdentifier:@"ZLOrderListCell"];
//    [self addSubview:self.orderListTableView];
    
    self.titleView = [[ZLSegmentTitleView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, dis(375), dis(42))];
    self.titleView.itemMinMargin = 15.f;
    self.titleView.backgroundColor = [UIColor whiteColor];
    self.titleView.titleFont = kFont14;
    self.titleView.titleSelectedColor = [UIColor colorWithHexString:@"#FFB223"];
    self.titleView.indicatorColor = [UIColor colorWithHexString:@"#FFB223"];
    [self addSubview:self.titleView];
    
    self.contentView = [[ZLScrollContentView alloc] initWithFrame:CGRectMake(0, kNavBarHeight + dis(42), kScreenWidth, kScreenHeight - kNavBarHeight -  dis(42))];
    [self addSubview:self.contentView];
}

@end

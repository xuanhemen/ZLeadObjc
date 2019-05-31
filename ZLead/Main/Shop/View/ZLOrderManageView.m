//
//  ZLOrderManageView.m
//  ZLead
//
//  Created by dmy on 2019/5/30.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLOrderManageView.h"
#import "ZLOrderListCell.h"

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
    self.orderListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    self.orderListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.orderListTableView.backgroundColor = [UIColor clearColor];
    [self.orderListTableView registerClass:[ZLOrderListCell class] forCellReuseIdentifier:@"ZLOrderListCell"];
    [self addSubview:self.orderListTableView];
}

@end

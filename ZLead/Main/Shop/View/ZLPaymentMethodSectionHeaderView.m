//
//  ZLPaymentMethodSectionHeaderView.m
//  ZLead
//
//  Created by dmy on 2019/5/28.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLPaymentMethodSectionHeaderView.h"

@implementation ZLPaymentMethodSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =  [UIColor colorWithHexString:@"#F7F7F7"];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UIView *contentView = [[UIView alloc] initWithFrame:kRect(0, 11, 375, 42)];
    contentView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:kRect(15, 0, 375, 42)];
    titleLabel.text = @"选择收款方式";
    titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Medium" size: 16];
    titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    [contentView addSubview:titleLabel];
    UIView *bLine = [[UIView alloc] initWithFrame:CGRectMake(0, dis(42) - 0.5, kScreenWith, 0.5)];
    bLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [contentView addSubview:bLine];
    [self addSubview:contentView];
}

@end

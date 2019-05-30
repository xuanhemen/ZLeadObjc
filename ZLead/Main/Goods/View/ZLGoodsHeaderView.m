//
//  ZLGoodsHeaderView.m
//  ZLead
//
//  Created by qzwh on 2019/5/30.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLGoodsHeaderView.h"

@interface ZLGoodsHeaderView ()

@property (nonatomic, strong)UIButton *sellingBtn;      // 已上架
@property (nonatomic, strong)UIButton *unsellBtn;       // 未上架
@property (nonatomic, strong)UIButton *selledBtn;       // 已售完

@property (nonatomic, strong)UIView *indView;
@property (nonatomic, strong)UIView *lineView;

@end

@implementation ZLGoodsHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    [self.unsellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self.sellingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.unsellBtn.mas_left).offset(dis(-100));
        make.centerY.equalTo(self.unsellBtn);
    }];
    
    [self.selledBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.unsellBtn.mas_right).offset(dis(100));
        make.centerY.equalTo(self.unsellBtn);
    }];
    
    [self moveIndViewWithButton:self.sellingBtn];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [UIColor zl_lineColor];
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark - action
- (void)statusChanged:(UIButton *)sender {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            if (btn == sender) {
                btn.selected = YES;
            }else {
                btn.selected = NO;
            }
        }
    }
    [self moveIndViewWithButton:sender];
}

- (void)moveIndViewWithButton:(UIButton *)btn {
    [self.indView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.right.equalTo(btn);
        make.height.mas_equalTo(2);
    }];
}

#pragma mark - lazy load
- (UIButton *)sellingBtn {
    if (!_sellingBtn) {
        _sellingBtn = [self customButtonWithTitle:@"已上架"];
        _sellingBtn.selected = YES;
        [self addSubview:_sellingBtn];
    }
    return _sellingBtn;
}

- (UIButton *)unsellBtn {
    if (!_unsellBtn) {
        _unsellBtn = [self customButtonWithTitle:@"未上架"];
        _unsellBtn.selected = NO;
        [self addSubview:_unsellBtn];
    }
    return _unsellBtn;
}

- (UIButton *)selledBtn {
    if (!_selledBtn) {
        _selledBtn = [self customButtonWithTitle:@"已售完"];
        _selledBtn.selected = NO;
        [self addSubview:_selledBtn];
    }
    return _selledBtn;
}

- (UIView *)indView {
    if (!_indView) {
        _indView = [[UIView alloc] init];
        _indView.backgroundColor = [UIColor zl_mainColor];
        [self addSubview:_indView];
    }
    return _indView;
}

- (UIButton *)customButtonWithTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = kFont14;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(statusChanged:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

@end

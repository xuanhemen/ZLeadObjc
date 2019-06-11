//
//  ZLGoodsManagerView.m
//  ZLead
//
//  Created by dmy on 2019/6/4.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLGoodsManagerView.h"

@interface ZLGoodsManagerView ()
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIButton *unShelveButton;
@property (nonatomic, strong) UIButton *delButton;
@property (nonatomic, strong) UIButton *topButton;
@property (nonatomic, strong) UIButton *cancelTopButton;
@end

@implementation ZLGoodsManagerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.topLineView = [[UIView alloc] init];
    self.topLineView.backgroundColor = [UIColor zl_lineColor];
    [self addSubview:self.topLineView];
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.allSelectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(dis(10));
        make.width.equalTo(@(dis(18)));
        make.height.equalTo(@(dis(18)));
        make.centerY.equalTo(self);
    }];
    
    UILabel *allSelectedLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.allSelectedButton.right + 6, 0, 100, dis(50))];
    allSelectedLabel.text = @"全选";
    allSelectedLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 13];
    allSelectedLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [self addSubview:allSelectedLabel];
    
    [self.cancelTopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(dis(-15));
        make.width.equalTo(@(dis(70)));
        make.height.equalTo(@(dis(30)));
        make.centerY.equalTo(self);
    }];
    
    [self.topButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.cancelTopButton.mas_left).offset(dis(-10));
        make.width.equalTo(@(dis(50)));
        make.height.equalTo(@(dis(30)));
        make.centerY.equalTo(self);
    }];
    
    [self.delButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topButton.mas_left).offset(dis(-10));
        make.width.equalTo(@(dis(50)));
        make.height.equalTo(@(dis(30)));
        make.centerY.equalTo(self);
    }];
    
    [self.unShelveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.delButton.mas_left).offset(dis(-10));
        make.width.equalTo(@(dis(50)));
        make.height.equalTo(@(dis(30)));
        make.centerY.equalTo(self);
    }];
}

- (UIButton *)allSelectedButton {
    if (!_allSelectedButton) {
        _allSelectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _allSelectedButton.frame = kRect(10, 15, 18, 18);
        [_allSelectedButton addTarget:self action:@selector(allSelectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_allSelectedButton setImage:[UIImage imageNamed:@"goods-selected-normal"] forState:UIControlStateNormal];
        [_allSelectedButton setImage:[UIImage imageNamed:@"goods-selected-highlight"] forState:UIControlStateSelected];
        [self addSubview:_allSelectedButton];
    }
    return _allSelectedButton;
}

- (UIButton *)unShelveButton {
    if (!_unShelveButton) {
        _unShelveButton = [self customButtonWithTitle:@"下架"];
        [_unShelveButton addTarget:self action:@selector(unShelveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_unShelveButton];
    }
    return _unShelveButton;
}

- (UIButton *)delButton {
    if (!_delButton) {
        _delButton = [self customButtonWithTitle:@"删除"];
        [_delButton addTarget:self action:@selector(delButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_delButton];
    }
    return _delButton;
}

- (UIButton *)topButton {
    if (!_topButton) {
        _topButton = [self customButtonWithTitle:@"置顶"];
        [_topButton addTarget:self action:@selector(topButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_topButton];
    }
    return _topButton;
}

- (UIButton *)cancelTopButton {
    if (!_cancelTopButton) {
        _cancelTopButton = [self customButtonWithTitle:@"取消置顶"];
        [_cancelTopButton addTarget:self action:@selector(cancelTopButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_cancelTopButton];
    }
    return _cancelTopButton;
}

- (UIButton *)customButtonWithTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = kFont13;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithHexString:@"#FFB32A"] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    btn.layer.cornerRadius = dis(15);
    btn.layer.borderWidth = 1;
    btn.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
    return btn;
}

#pragma mark - Public Method

- (void)refreshUnShelveButton:(BOOL )isEnableUnShelve {
    [self.unShelveButton setTitleColor:isEnableUnShelve ? [UIColor colorWithHexString:@"#333333"] : [UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
}

- (void)refreshDelButton:(BOOL )isEnableDel {
    [self.delButton setTitleColor:isEnableDel ? [UIColor colorWithHexString:@"#333333"] : [UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
}

- (void)refreshTopButton:(BOOL )isEnableTop {
    [self.topButton setTitleColor:isEnableTop ? [UIColor colorWithHexString:@"#333333"] : [UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
}

- (void)refreshCanelTopButton:(BOOL )isCancelTop {
    [self.cancelTopButton setTitleColor:isCancelTop ? [UIColor colorWithHexString:@"#FFB32A"] : [UIColor colorWithHexString:@"#999999"]  forState:UIControlStateNormal];
    self.cancelTopButton.layer.borderColor = isCancelTop ? [UIColor colorWithHexString:@"#FFB32A"].CGColor : [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
}

- (void)reset {
    self.allSelectedButton.selected = NO;
    [self.unShelveButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [self.delButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [self.topButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [self.cancelTopButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    self.cancelTopButton.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
}

- (void)configStyleForClassifyFilterView {
    self.cancelTopButton.hidden = YES;
    self.topButton.hidden = YES;
    [self.cancelTopButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.width.equalTo(@(0));
        make.height.equalTo(@(0));
        make.centerY.equalTo(self);
    }];

    [self.topButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.cancelTopButton.mas_left);
        make.width.equalTo(@(0));
        make.height.equalTo(@(0));
        make.centerY.equalTo(self);
    }];
    
    [self.delButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(dis(-15));
        make.width.equalTo(@(dis(50)));
        make.height.equalTo(@(dis(30)));
        make.centerY.equalTo(self);
    }];
    
    [self.unShelveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.delButton.mas_left).offset(dis(-10));
        make.width.equalTo(@(dis(50)));
        make.height.equalTo(@(dis(30)));
        make.centerY.equalTo(self);
    }];
}

#pragma mark - UIButton Actions

- (void)allSelectedButtonAction:(UIButton *)selectedBtn {
    selectedBtn.selected = !selectedBtn.selected;
    if (self.allSelectedBlock) {
        self.allSelectedBlock(selectedBtn.selected);
    }
}

- (void)unShelveButtonAction:(UIButton *)unShelveBtn {
    if (self.unShelveBlock) {
        self.unShelveBlock();
    }
}

- (void)delButtonAction:(UIButton *)delBtn {
    if (self.delBlock) {
        self.delBlock();
    }
}

- (void)topButtonAction:(UIButton *)topBtn {
    if (self.topBlock) {
        self.topBlock();
    }
}

- (void)cancelTopButtonAction:(UIButton *)cancelTopBtn {
    if (self.cancelTopBlock) {
        self.cancelTopBlock();
    }
}

@end

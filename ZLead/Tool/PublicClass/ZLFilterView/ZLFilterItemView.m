//
//  ZLFilterItemView.m
//  ZLead
//
//  Created by dmy on 2019/6/5.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLFilterItemView.h"
#import "ZLClassifyItemModel.h"

@interface ZLFilterItemView ()
@property (nonatomic, strong) UIButton *titleButton;
@property (nonatomic, strong) UIButton *cancelButton;
@end

@implementation ZLFilterItemView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.titleButton.backgroundColor = [UIColor colorWithHexString:@"#FFF8EB"];
    self.titleButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.titleButton setTitleColor:[UIColor colorWithHexString:@"#FFB32A"] forState:UIControlStateNormal];
    self.titleButton.layer.borderColor = [UIColor colorWithHexString:@"#FFB32A"].CGColor;
    self.titleButton.layer.borderWidth = 0.5;
    [self addSubview:self.titleButton];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelButton setImage:[UIImage imageNamed:@"cancel-selected-classify-icon"] forState:UIControlStateNormal];
    [self addSubview:self.cancelButton];
}

- (void)setClassifyItemModel:(ZLClassifyItemModel *)classifyItemModel {
    self.titleButton.frame = CGRectMake(0, 0, self.width, self.height);
    self.cancelButton.frame = CGRectMake(self.width - dis(18), self.height - dis(14), dis(18), dis(14));
    [self.titleButton setTitle:classifyItemModel.title forState:UIControlStateNormal];
}

#pragma mark - UIButton Actions

- (void)cancelButtonAction {
    if (self.cancelSelectedBlock) {
        self.cancelSelectedBlock();
    }
}

@end

//
//  ZLFilterSectionFooterView.m
//  ZLead
//
//  Created by dmy on 2019/6/5.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLFilterSectionFooterView.h"
#import "ZLFilterDataModel.h"

@interface ZLFilterSectionFooterView ()
@property (nonatomic, strong) UIButton *unflodButton;
@end

@implementation ZLFilterSectionFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.unflodButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.unflodButton.frame = CGRectMake(0, dis(10), self.width, self.height - dis(10));
    self.unflodButton.backgroundColor = [UIColor colorWithHexString:@"#FAFAFA"];
    [self.unflodButton setTitle:@"展开" forState:UIControlStateNormal];
    self.unflodButton.titleLabel.font = kFont12;
    [self.unflodButton setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
    [self.unflodButton addTarget:self action:@selector(unflodButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.unflodButton];
}

- (void)setFilterDataModel:(ZLFilterDataModel *)filterDataModel {
    _filterDataModel = filterDataModel;
    [self.unflodButton setTitle:_filterDataModel.isUnflod ? @"收起" : @"展开" forState:UIControlStateNormal];
}

#pragma mark - UIButton Actions

- (void)unflodButtonAction:(UIButton *)unflodButton {
    unflodButton.selected = !unflodButton.selected;
    _filterDataModel.isUnflod = !_filterDataModel.isUnflod;
    [self.unflodButton setTitle:_filterDataModel.isUnflod ? @"收起" : @"展开" forState:UIControlStateNormal];
    if (self.delegate && [self.delegate respondsToSelector:@selector(filterSectionFooterView:isUnfold:filterDataModel:)]) {
        [self.delegate filterSectionFooterView:self isUnfold:_filterDataModel.isUnflod filterDataModel:_filterDataModel];
    }
}

@end

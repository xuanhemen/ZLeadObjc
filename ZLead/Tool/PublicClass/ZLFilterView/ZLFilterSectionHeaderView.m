//
//  ZLFilterSectionHeaderView.m
//  ZLead
//
//  Created by dmy on 2019/6/5.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLFilterSectionHeaderView.h"
#import "ZLFilterItemView.h"
#import "ZLFilterDataModel.h"
#import "ZLClassifyItemModel.h"
#import "NSString+Size.h"

@interface ZLFilterSectionHeaderView()
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *manageButton;
@property (nonatomic, strong) ZLFilterItemView *filterItemView;
@property (nonatomic, strong) ZLClassifyItemModel *classifyItemModel;
@end

@implementation ZLFilterSectionHeaderView

- (void)setClassifyItemModel:(ZLClassifyItemModel *)classifyItemModel {
    _classifyItemModel = classifyItemModel;
    if (classifyItemModel && _filterDataModel.indexPath.section != 0) {
        self.filterItemView.frame = CGRectMake(0, self.height - dis(42), dis(97), dis(32));
        self.filterItemView.hidden = NO;
    } else {
        self.filterItemView.hidden = YES;
        if (_filterDataModel.indexPath.section != 0) {
            self.manageButton.hidden = NO;
        } else {
            self.manageButton.hidden = YES;
        }
    }
    CGSize titleSize = [self.title.text sizeWithFont:[UIFont boldSystemFontOfSize:14] maxSize:CGSizeMake(MAXFLOAT, self.frame.size.height)];
    self.title.frame = CGRectMake(0, 0, titleSize.width, self.frame.size.height);
    self.manageButton.frame = CGRectMake(self.frame.size.width - 60, 0, 60, dis(44));
    
    [self.filterItemView setClassifyItemModel:classifyItemModel];
}

- (void)setFilterDataModel:(ZLFilterDataModel *)filterDataModel {
    _filterDataModel = filterDataModel;
    [self setClassifyItemModel:_filterDataModel.selectedClassifyItemModel];
    self.title.text = filterDataModel.sectionName;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupViews];
//        [self configuration];
    }
    return self;
}

- (void)configuration {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tap];
}

- (void)tap:(UITapGestureRecognizer *)gesture {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelSelectedClassify:filterDataModel:)]) {
        [self.delegate cancelSelectedClassify:self filterDataModel:self.filterDataModel];
    }
}

- (void)setupViews {
    [self addSubview:self.title];
    [self addSubview:self.manageButton];
    [self addSubview:self.filterItemView];
    kWeakSelf(weakSelf)
    self.filterItemView.cancelSelectedBlock = ^{
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(cancelSelectedClassify:filterDataModel:)]) {
            [weakSelf.delegate cancelSelectedClassify:weakSelf filterDataModel:weakSelf.filterDataModel];
        }
    };
}

- (void)layoutSubviews {
    [super layoutSubviews];
//    CGSize titleSize = [self.title.text sizeWithFont:[UIFont boldSystemFontOfSize:14] maxSize:CGSizeMake(MAXFLOAT, self.frame.size.height)];
//    CGSize detailsSize = [self.details.text sizeWithFont:[UIFont boldSystemFontOfSize:11] maxSize:CGSizeMake(MAXFLOAT, self.frame.size.height)];
    
    self.title.frame = CGRectMake(0, 0, self.frame.size.width - 100, dis(44));
    
    self.manageButton.frame = CGRectMake(self.frame.size.width - 60, 0, 60, dis(44));
    
//    self.filterItemView.frame = CGRectMake(0, self.height - dis(42), dis(97), dis(32));
}

- (ZLFilterItemView *)filterItemView {
    if (!_filterItemView) {
        _filterItemView = [[ZLFilterItemView alloc] init];
        _filterItemView.hidden = YES;
    }
    return _filterItemView;
}

- (UIButton *)manageButton {
    if (_manageButton == nil) {
        _manageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_manageButton setTitle:@"管理" forState:UIControlStateNormal];
        _manageButton.titleLabel.font = kFont11;
        _manageButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_manageButton setTitleColor:[UIColor colorWithHexString:@"#FFBC1A"] forState:UIControlStateNormal];
        [_manageButton addTarget:self action:@selector(manageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _manageButton;
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.userInteractionEnabled = YES;
        _title.textColor = [UIColor colorWithHexString:@"#333333"];
        _title.font = [UIFont boldSystemFontOfSize:16];
    }
    return _title;
}

+ (CGFloat)heightForFilterSectionHeaderView:(ZLClassifyItemModel *)classifyItemModel {
    if (classifyItemModel) {
        return dis(86);
    } else {
        return dis(44);
    }
}

- (void)manageButtonAction:(UIButton *)manageBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(manageClassify:filterDataModel:)]) {
        [self.delegate manageClassify:self filterDataModel:self.filterDataModel];
    }
}

@end

//
//  ZLFilterItemCell.m
//  ZLead
//
//  Created by dmy on 2019/6/5.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLFilterItemCell.h"
#import "ZLClassifyItemModel.h"

@interface ZLFilterItemCell()
@property (nonatomic , strong) UILabel *title;
@end

@implementation ZLFilterItemCell

- (void)setClassifyItemModel:(ZLClassifyItemModel *)classifyItemModel {
    _classifyItemModel = classifyItemModel;
    self.title.text = classifyItemModel.title;
    self.title.backgroundColor = classifyItemModel.isSelected ? [UIColor colorWithHexString:@"#FFF8EB"] : [UIColor colorWithHexString:@"#F4F4F4"];
    self.title.textColor = classifyItemModel.isSelected ?[UIColor colorWithHexString:@"#FFB32A"] : [UIColor colorWithHexString:@"#333333"];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.title.frame = CGRectMake(0, 0, self.frame.size.width , self.frame.size.height);
}

- (void)setupViews {
    [self addSubview:self.title];
    
}

- (void)tap:(UITapGestureRecognizer *)gesture {
    self.classifyItemModel.isSelected = YES;
    [self setClassifyItemModel:self.classifyItemModel];
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedFilterItem:classifyItemModel:)]) {
        [self.delegate selectedFilterItem:self classifyItemModel:self.classifyItemModel];
    }
}

- (UILabel *)title {
    if (_title == nil) {
        _title = [[UILabel alloc]init];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.userInteractionEnabled = YES;
        _title.layer.masksToBounds = YES;
        _title.layer.cornerRadius = 2;
        _title.backgroundColor = [UIColor colorWithHexString:@"#F4F4F4"];
        _title.font = [UIFont systemFontOfSize:12];
        _title.textColor = [UIColor colorWithHexString:@"#333333"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        tap.numberOfTouchesRequired = 1;
        tap.numberOfTapsRequired = 1;
        [_title addGestureRecognizer:tap];
        
    }
    return _title;
}

@end


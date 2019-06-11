//
//  ZLAddPlatformGoodsCell.m
//  ZLead
//
//  Created by dmy on 2019/6/11.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddPlatformGoodsCell.h"
#import "ZLGoodsModel.h"

@interface ZLAddPlatformGoodsCell ()<UITextViewDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UILabel *goodsNameLabel;
@property (nonatomic, strong) UITextView *goodsNameTextView;
@property (nonatomic, strong) UILabel *goodsNumTitleLabel;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *minusButton;
@property (nonatomic, strong) UITextField *goodsNumTF;
@property (nonatomic, strong) UILabel *onlinePriceLabel;
@property (nonatomic, strong) UILabel *offlinePriceLabel;
@property (nonatomic, strong) UITextField *onlinePriceTF;//网店价格
@property (nonatomic, strong) UITextField *offlinePriceTF;//线下门店价格
@property (nonatomic, strong) UILabel *shopClassifyLabel;
@property (nonatomic, strong) UIButton *classifyNameButton;
@property (nonatomic, strong) UIView *expandView;
@property (nonatomic, strong) UILabel *onlinePriceSignLabel;//网店价格¥符号
@property (nonatomic, strong) UILabel *offlinePriceSignLabel;//线下门店价格¥符号
@property (nonatomic, strong) ZLGoodsModel *goodsModel;
@end

@implementation ZLAddPlatformGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.goodsImageView.frame = kRect(45, 8, 100, 100);
    self.selectedButton.frame = CGRectMake(dis(15), self.goodsImageView.top + dis(41), dis(18), dis(18));
    self.goodsNameLabel.frame = CGRectMake(self.goodsImageView.right + dis(14), self.goodsImageView.top + dis(5), dis(196), dis(70));
    self.goodsNameTextView.frame = CGRectMake(self.goodsImageView.right + dis(12), self.goodsImageView.top, dis(202), dis(74));
    self.goodsNameTextView.hidden = YES;
    self.expandView.hidden = YES;
    self.expandView.frame = CGRectMake(0, self.goodsImageView.bottom + dis(8), kScreenWidth, dis(180));
    self.goodsNumTitleLabel.frame = CGRectMake(dis(45), dis(18), dis(60), dis(17));
    self.minusButton.frame = CGRectMake(dis(255), dis(11), dis(34), dis(32));
    self.goodsNumTF.frame = CGRectMake(self.minusButton.right + dis(1), dis(11), dis(34), dis(32));
    self.addButton.frame = CGRectMake(self.goodsNumTF.right + dis(1), dis(11), dis(34), dis(32));
    self.onlinePriceLabel.frame = CGRectMake(dis(45), self.goodsNumTitleLabel.bottom + dis(32), dis(60), dis(17));
    self.onlinePriceTF.frame = CGRectMake(kScreenWidth - dis(96), self.addButton.bottom + dis(17), dis(80), dis(30));
    self.onlinePriceSignLabel.frame = CGRectMake(self.onlinePriceTF.left - dis(62), self.addButton.bottom + dis(17), dis(60), dis(30));
    self.offlinePriceLabel.frame = CGRectMake(dis(45), self.onlinePriceLabel.bottom + dis(29), dis(60), dis(17));
    self.offlinePriceTF.frame = CGRectMake(kScreenWidth - dis(96), self.onlinePriceTF.bottom + dis(16), dis(80), dis(30));
    self.offlinePriceSignLabel.frame = CGRectMake(self.onlinePriceTF.left - dis(62), self.onlinePriceTF.bottom + dis(17), dis(60), dis(30));
    self.shopClassifyLabel.frame = CGRectMake(dis(45), self.offlinePriceLabel.bottom + dis(26), dis(60), dis(17));
//    self.classifyNameButton.frame = CGRectMake(kScreenWidth - dis(114), self.offlinePriceTF.bottom + dis(17), dis(98), dis(25));
    self.classifyNameButton.frame = CGRectMake(kScreenWidth - dis(135), self.offlinePriceTF.bottom + dis(17), dis(120), dis(25));
}

- (UIButton *)selectedButton {
    if (!_selectedButton) {
        _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedButton setImage:[UIImage imageNamed:@"goods-selected-normal"] forState:UIControlStateNormal];
        [_selectedButton setImage:[UIImage imageNamed:@"goods-selected-highlight"] forState:UIControlStateSelected];
        [_selectedButton addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.selectedButton];
    }
    return _selectedButton;
}

- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
        _goodsImageView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
        _goodsImageView.layer.cornerRadius = 5;
        _goodsImageView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.goodsImageView];
    }
    return _goodsImageView;
}

- (UITextView *)goodsNameTextView {
    if (!_goodsNameTextView) {
        _goodsNameTextView = [[UITextView alloc] init];
        _goodsNameTextView.layer.borderWidth = 0.5;
        _goodsNameTextView.layer.borderColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0].CGColor;
        _goodsNameTextView.layer.cornerRadius = 2;
        _goodsNameTextView.font = kFont14;
        _goodsNameTextView.text = @"美国雷亚手电钻多功能家用电 钻工业级手枪钻电动螺丝刀手 电转220V";
        _goodsNameTextView.delegate = self;
         [self.contentView addSubview:self.goodsNameTextView];
    }
    return _goodsNameTextView;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] init];
        _goodsNameLabel.font = kFont14;
        _goodsNameLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _goodsNameLabel.numberOfLines = 0;
        _goodsNameLabel.text = @"美国雷亚手电钻多功能家用电 钻工业级手枪钻电动螺丝刀手 电转220V";
        [self.contentView addSubview:self.goodsNameLabel];
    }
    return _goodsNameLabel;
}

- (UIView *)expandView {
    if (!_expandView) {
        _expandView = [[UIView alloc] init];
        _expandView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.expandView];
    }
    return _expandView;
}

- (UILabel *)goodsNumTitleLabel {
    if (!_goodsNumTitleLabel) {
        _goodsNumTitleLabel = [[UILabel alloc] init];
        _goodsNumTitleLabel.font = kFont13;
        _goodsNumTitleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _goodsNumTitleLabel.text = @"数量";
        [self.expandView addSubview:self.goodsNumTitleLabel];
    }
    return _goodsNumTitleLabel;
}

- (UILabel *)onlinePriceLabel {
    if (!_onlinePriceLabel) {
        _onlinePriceLabel = [[UILabel alloc] init];
        _onlinePriceLabel.font = kFont13;
        _onlinePriceLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _onlinePriceLabel.text = @"网店售价";
        [self.expandView addSubview:self.onlinePriceLabel];
    }
    return _onlinePriceLabel;
}

- (UILabel *)offlinePriceLabel {
    if (!_offlinePriceLabel) {
        _offlinePriceLabel = [[UILabel alloc] init];
        _offlinePriceLabel.font = kFont13;
        _offlinePriceLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _offlinePriceLabel.text = @"门店售价";
        [self.expandView addSubview:self.offlinePriceLabel];
    }
    return _offlinePriceLabel;
}

- (UILabel *)shopClassifyLabel {
    if (!_shopClassifyLabel) {
        _shopClassifyLabel = [[UILabel alloc] init];
        _shopClassifyLabel.font = kFont13;
        _shopClassifyLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _shopClassifyLabel.text = @"店铺分类";
        [self.expandView addSubview:self.shopClassifyLabel];
    }
    return _shopClassifyLabel;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.expandView addSubview:self.addButton];
    }
    return _addButton;
}

- (UIButton *)minusButton {
    if (!_minusButton) {
        _minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_minusButton addTarget:self action:@selector(minusButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.expandView addSubview:self.minusButton];
    }
    return _minusButton;
}

- (UITextField *)goodsNumTF {
    if (!_goodsNumTF) {
        _goodsNumTF = [[UITextField alloc] init];
        _goodsNumTF.font = kFont14;
        _goodsNumTF.text = @"1";
        _goodsNumTF.textAlignment = NSTextAlignmentCenter;
        _goodsNumTF.keyboardType = UIKeyboardTypeNumberPad;
        _goodsNumTF.textColor = [UIColor colorWithHexString:@"#333333"];
        _goodsNumTF.backgroundColor = [UIColor colorWithHexString:@"#EBEBEB"];
        _goodsNumTF.delegate = self;
        [self.expandView addSubview:_goodsNumTF];
    }
    return _goodsNumTF;
}


- (UITextField *)onlinePriceTF {
    if (!_onlinePriceTF) {
        _onlinePriceTF = [[UITextField alloc] init];
        _onlinePriceTF.font = kFont14;
        _onlinePriceTF.textAlignment = NSTextAlignmentCenter;
        _onlinePriceTF.keyboardType = UIKeyboardTypeNumberPad;
        _onlinePriceTF.text = @"0.00";
        _onlinePriceTF.textColor = [UIColor colorWithHexString:@"#FF3A3A"];
        _onlinePriceTF.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
        _onlinePriceTF.layer.borderWidth = 1;
        _onlinePriceTF.delegate = self;
        [self.expandView addSubview:_onlinePriceTF];
    }
    return _onlinePriceTF;
}

- (UITextField *)offlinePriceTF {
    if (!_offlinePriceTF) {
        _offlinePriceTF = [[UITextField alloc] init];
        _offlinePriceTF.font = kFont14;
        _offlinePriceTF.textAlignment = NSTextAlignmentCenter;
        _offlinePriceTF.keyboardType = UIKeyboardTypeNumberPad;
        _offlinePriceTF.text = @"0.00";
        _offlinePriceTF.textColor = [UIColor colorWithHexString:@"#FF3A3A"];
        _offlinePriceTF.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
        _offlinePriceTF.layer.borderWidth = 1;
        _offlinePriceTF.delegate = self;
        [self.expandView addSubview:_offlinePriceTF];
    }
    return _offlinePriceTF;
}

- (UIButton *)classifyNameButton {
    if (!_classifyNameButton) {
        _classifyNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _classifyNameButton.backgroundColor = [UIColor zl_mainColor];
        [_classifyNameButton setTitle:@"一级分类/二级分类" forState:UIControlStateNormal];
        _classifyNameButton.titleLabel.font = kFont12;
        [_classifyNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_classifyNameButton addTarget:self action:@selector(classifyNameButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.expandView addSubview:self.classifyNameButton];
    }
    return _classifyNameButton;
}

- (UILabel *)offlinePriceSignLabel {
    if (!_offlinePriceSignLabel) {
        _offlinePriceSignLabel = [[UILabel alloc] init];
        _offlinePriceSignLabel.font = kFont14;
        _offlinePriceSignLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _offlinePriceSignLabel.text = @"¥";
        _offlinePriceSignLabel.textAlignment = NSTextAlignmentRight;
        [self.expandView addSubview:self.offlinePriceSignLabel];
    }
    return _offlinePriceSignLabel;
}

- (UILabel *)onlinePriceSignLabel {
    if (!_onlinePriceSignLabel) {
        _onlinePriceSignLabel = [[UILabel alloc] init];
        _onlinePriceSignLabel.font = kFont14;
        _onlinePriceSignLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        _onlinePriceSignLabel.text = @"¥";
        _onlinePriceSignLabel.textAlignment = NSTextAlignmentRight;
        [self.expandView addSubview:self.onlinePriceSignLabel];
    }
    return _onlinePriceSignLabel;
}


#pragma mark - UIButton Actions

- (void)selectedButtonAction:(UIButton *)selectedBtn {
    selectedBtn.selected = !selectedBtn.selected;
    if (self.selectedButtonBlock) {
        self.selectedButtonBlock(self, self.goodsModel.isSelected);
    }
}

- (void)addButtonAction:(UIButton *)addBtn {
    NSInteger goodsNum = [self.goodsNumTF.text integerValue];
    self.goodsNumTF.text = [NSString stringWithFormat:@"%@", @(goodsNum + 1)];
    if (self.delegate && [self.delegate respondsToSelector:@selector(addPlatformGoodsCell:goodsNumChanged:)]) {
        [self.delegate addPlatformGoodsCell:self goodsNumChanged:[self.goodsNumTF.text integerValue]];
    }
}

- (void)minusButtonAction:(UIButton *)addBtn {
    NSInteger goodsNum = [self.goodsNumTF.text integerValue];
    if (goodsNum >= 2) {
        self.goodsNumTF.text = [NSString stringWithFormat:@"%@", @(goodsNum - 1)];
        if (self.delegate && [self.delegate respondsToSelector:@selector(addPlatformGoodsCell:goodsNumChanged:)]) {
            [self.delegate addPlatformGoodsCell:self goodsNumChanged:[self.goodsNumTF.text integerValue]];
        }
    }
}

- (void)classifyNameButtonAction:(UIButton *)classifyNameBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addPlatformGoodsCell:shopClassifyNameButton:)]) {
        [self.delegate addPlatformGoodsCell:self shopClassifyNameButton:self.classifyNameButton];
    }
}

#pragma mark - Setup Data

- (void)setupData:(ZLGoodsModel *)goodsModel {
    self.selectedButton.selected = goodsModel.isSelected;
    self.goodsModel = goodsModel;
    if (goodsModel.isSelected) {
        self.expandView.hidden = NO;
        self.goodsNameLabel.hidden = YES;
        self.goodsNameTextView.hidden = NO;
        self.bottomSeparator.frame = CGRectMake(dis(15), dis(307) - 1, dis(345), 1);
    } else {
        [self.goodsNameLabel sizeToFit];
        self.goodsNameLabel.y =  self.goodsImageView.top + dis(5);
        self.goodsNameLabel.width = dis(196);
        self.expandView.hidden = YES;
        self.goodsNameLabel.hidden = NO;
        self.goodsNameTextView.hidden = YES;
        self.bottomSeparator.frame = CGRectMake(dis(15), dis(307) - 1, dis(345), 0);
    }
}

+ (CGFloat)heightForCell:(ZLGoodsModel *)goodsModel {
    if (goodsModel.isSelected) {
        return dis(307);
    } else {
        return dis(116);
    }
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addPlatformGoodsCell:goodsNameChanged:)]) {
        [self.delegate addPlatformGoodsCell:self goodsNameChanged:textView.text];
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.goodsNumTF) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(addPlatformGoodsCell:goodsNumChanged:)]) {
            [self.delegate addPlatformGoodsCell:self goodsNumChanged:[textField.text floatValue]];
        }
    } else if (textField == self.onlinePriceTF) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(addPlatformGoodsCell:goodsNumOnlinePriceChanged:)]) {
            [self.delegate addPlatformGoodsCell:self goodsNumOnlinePriceChanged:[textField.text floatValue]];
        }
    } else if (textField == self.offlinePriceTF) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(addPlatformGoodsCell:goodsNumOfflinePriceChanged:)]) {
            [self.delegate addPlatformGoodsCell:self goodsNumOfflinePriceChanged:[textField.text floatValue]];
        }
    }
}


@end

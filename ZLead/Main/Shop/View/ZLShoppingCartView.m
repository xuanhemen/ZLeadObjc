//
//  ZLShoppingCartView.m
//  ZLead
//
//  Created by dmy on 2019/5/27.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLShoppingCartView.h"
#import "ZLShopGoodsModel.h"

@interface ZLShoppingCartView ()
@property (nonatomic, strong) UILabel *goodsIdLabel;//商品编号
@property (nonatomic, strong) UIView *separator;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UILabel *goodsTitleLabel;
@property (nonatomic, strong) UILabel *goodsTypeLabel;
@property (nonatomic, strong) UILabel *goodsPriceLabel;
@property (nonatomic, strong) UIView *numChangeView;
@property (nonatomic,strong) UIButton *addButton;
@property (nonatomic,strong) UIButton *minusButton;
@property (nonatomic,strong) ZLShopGoodsModel *shopGoodsModel;
@end

@implementation ZLShoppingCartView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.goodsIdLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.goodsIdLabel.textAlignment = NSTextAlignmentCenter;
    self.goodsIdLabel.font = kFont10;
    self.goodsIdLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    self.goodsIdLabel.backgroundColor =  [UIColor colorWithHexString:@"#F8F8F8"];
    self.goodsIdLabel.layer.cornerRadius = 2;
    [self addSubview:self.goodsIdLabel];
    
    self.separator = [[UIView alloc] initWithFrame:CGRectZero];
    self.separator.backgroundColor = [UIColor zl_lineColor];
    [self addSubview:self.separator];
    
    self.selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selectedButton setImage:[UIImage imageNamed:@"goods-selected-normal"] forState:UIControlStateNormal];
    [self.selectedButton setImage:[UIImage imageNamed:@"goods-selected-highlight"] forState:UIControlStateSelected];
    [self.selectedButton addTarget:self action:@selector(selectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.selectedButton];
    
    self.goodsImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.goodsImageView.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    [self addSubview:self.goodsImageView];
    
    self.goodsTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.goodsTitleLabel.font = kBoldFont14;
    self.goodsTitleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.goodsTitleLabel.numberOfLines = 2;
    [self addSubview:self.goodsTitleLabel];
    
    self.goodsTypeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.goodsTypeLabel.font = kFont10;
    self.goodsTypeLabel.textAlignment = NSTextAlignmentCenter;
    self.goodsTypeLabel.textColor = [UIColor colorWithHexString:@"#5FCC00"];
    self.goodsTypeLabel.layer.borderWidth = 0.5;
    self.goodsTypeLabel.layer.borderColor = [UIColor colorWithRed:95/255.0 green:204/255.0 blue:0/255.0 alpha:1.0].CGColor;
    self.goodsTypeLabel.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    self.goodsTypeLabel.layer.cornerRadius = 2;
    [self addSubview:self.goodsTypeLabel];
    
    self.goodsPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.goodsPriceLabel.font = kFont15;
    self.goodsPriceLabel.textColor = [UIColor colorWithHexString:@"#F79A1E"];
    [self addSubview:self.goodsPriceLabel];
    
    self.numChangeView = [[UIView alloc] initWithFrame:CGRectZero];
    self.numChangeView.layer.cornerRadius = 2;
//    self.numChangeView.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
//    self.numChangeView.layer.borderWidth = 0.5;
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.numChangeView];
    
    UIButton *minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.numChangeView addSubview:minusBtn];
    [minusBtn setImage:[UIImage imageNamed:@"shop-minus-sign-icon"] forState:UIControlStateNormal];
    [minusBtn addTarget:self action:@selector(minusButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    minusBtn.tag = 11;
    self.minusButton = minusBtn;
    
    UITextField *goodsNumTF = [[UITextField alloc] init];
    [self.numChangeView addSubview:goodsNumTF];
    goodsNumTF.textAlignment = NSTextAlignmentCenter;
    goodsNumTF.text = @"0";
    goodsNumTF.font = kFont12;
    goodsNumTF.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    goodsNumTF.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    goodsNumTF.layer.cornerRadius = 2;
    self.goodsNumTF = goodsNumTF;
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.numChangeView addSubview:addBtn];
    [addBtn setImage:[UIImage imageNamed:@"shop-add-sign-icon"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.tag = 12;
    self.addButton = addBtn;
    [self setupData:nil];
}

- (void)setSubviewsFrame:(BOOL )enableSelected {
    self.separator.hidden = YES;
    if (enableSelected) {
        self.backgroundColor = [UIColor whiteColor];
//        self.separator.frame = kRect(10, 37, 325, 0.5);
        self.selectedButton.frame = kRect(10, 57, 18, 18);
        self.goodsImageView.frame = kRect(39, 6, 120, 120);
    } else {
        self.goodsImageView.frame = kRect(15, 6, 120, 120);
    }
    kWeakSelf(weakSelf);
    [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.separator.mas_bottom).offset(dis(14));
        make.left.equalTo(weakSelf.goodsImageView.mas_right).offset(dis(10));
        make.right.equalTo(weakSelf.mas_right).offset(dis(-10));
        make.height.lessThanOrEqualTo(@(dis(40.0)));
    }];
    
    [self.goodsIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf).offset(dis(-58));
        make.left.equalTo(weakSelf.goodsTitleLabel.mas_left);
        make.height.lessThanOrEqualTo(@(dis(155)));
    }];
    
    [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.goodsImageView.mas_right).offset(dis(10));
        make.bottom.equalTo(weakSelf.mas_bottom).offset(dis(-8));
        make.width.lessThanOrEqualTo(@(dis(100.0)));
    }];
    
    [self.numChangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(dis(-15));
        make.bottom.equalTo(weakSelf.mas_bottom).offset(dis(-6));
        make.width.mas_equalTo(dis(60));
        make.height.mas_equalTo(dis(18));
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.numChangeView.mas_right);
        make.bottom.equalTo(weakSelf.numChangeView.mas_bottom);
        make.width.mas_equalTo(dis(12));
        make.height.mas_equalTo(dis(18));
    }];
    
    [self.goodsNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.addButton.mas_left);
        make.bottom.equalTo(weakSelf.numChangeView.mas_bottom);
        make.width.mas_equalTo(dis(36));
        make.height.mas_equalTo(dis(18));
    }];
    
    [self.minusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.goodsNumTF.mas_left);
        make.bottom.equalTo(weakSelf.numChangeView.mas_bottom);
        make.width.mas_equalTo(dis(12));
        make.height.mas_equalTo(dis(18));
    }];
}

- (void)setUnitPriceText:(CGFloat)price goodsUnit:(NSString *)goodsUnit{
    NSString *priceStr = [NSString stringWithFormat:@"门店价¥%.2f/%@", price, goodsUnit];
    NSString *priceNumStr = [NSString stringWithFormat:@"%.2f", price];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:priceStr attributes: @{NSFontAttributeName: kFont14 ,NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    [string addAttributes:@{NSFontAttributeName: kFont10 , NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#F79A1E"]} range:NSMakeRange(0, 4)];
    [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Mediu" size: 18] ? [UIFont fontWithName:@"PingFangSC-Mediu" size: 18] :kFont18 , NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#F79A1E"]} range:NSMakeRange(4, priceNumStr.length)];
    [string addAttributes:@{NSFontAttributeName:kFont10, NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#F79A1E"]} range:NSMakeRange(priceStr.length - goodsUnit.length - 1, goodsUnit.length + 1)];
    self.goodsPriceLabel.attributedText = string;
}

- (void)setupData:(ZLShopGoodsModel *)goodsModel {
    self.shopGoodsModel = goodsModel;
    self.goodsTitleLabel.text = @"这里是产品名称只显示两行多出的文字不显示多出的文字不显示多出";
    self.goodsIdLabel.text = @"商品编号：14732012832835";
    self.goodsTypeLabel.text = @"零件";
    self.goodsNumTF.text = [NSString stringWithFormat:@"%@", @(goodsModel.goodsNum)];
    [self setUnitPriceText:goodsModel.salePrice goodsUnit:@"把"];
    
    [self.goodsTypeLabel sizeToFit];
    CGFloat typeWidth = self.goodsTypeLabel.width + dis(20);
    [self.goodsTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(dis(10));
        make.bottom.equalTo(self.goodsImageView.mas_bottom).offset(dis(-29));
        make.width.equalTo(@(typeWidth));
        make.height.equalTo(@(dis(16)));
        make.width.lessThanOrEqualTo(@(dis(100.0)));
    }];
    
}

#pragma mark - UIButton Actions

- (void)minusButtonAction:(UIButton *)minusBtn {
    if (self.minusButtonBlock) {
        self.minusButtonBlock();
    }
}

- (void)addButtonAction:(UIButton *)addBtn {
    if (self.addButtonBlock) {
        self.addButtonBlock();
    }
}

- (void)selectedButtonAction:(UIButton *)selectedBtn {
    self.shopGoodsModel.isSelected = !self.shopGoodsModel.isSelected;
    if (self.selectedButtonBlock) {
        self.selectedButtonBlock(self.shopGoodsModel.isSelected);
    }
}

@end

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
    self.goodsIdLabel.textAlignment = NSTextAlignmentRight;
    self.goodsIdLabel.font = kFont12;
    self.goodsIdLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    [self addSubview:self.goodsIdLabel];
    
    self.separator = [[UIView alloc] initWithFrame:CGRectZero];
    self.separator.backgroundColor = [UIColor zl_lineColor];
    [self addSubview:self.separator];
    
    self.selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectedButton.backgroundColor = [UIColor redColor];
    [self addSubview:self.selectedButton];
    
    self.goodsImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.goodsImageView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.goodsImageView];
    
    self.goodsTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.goodsTitleLabel.font = kBoldFont14;
    self.goodsTitleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.goodsTitleLabel.numberOfLines = 2;
    [self addSubview:self.goodsTitleLabel];
    
    self.goodsTypeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.goodsTypeLabel.font = kFont14;
    self.goodsTypeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    [self addSubview:self.goodsTypeLabel];
    
    self.goodsPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.goodsPriceLabel.font = kFont15;
    self.goodsPriceLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    [self addSubview:self.goodsPriceLabel];
    
    self.numChangeView = [[UIView alloc] initWithFrame:CGRectZero];
    self.numChangeView.layer.cornerRadius = 2;
    self.numChangeView.layer.borderColor = [UIColor colorWithHexString:@"#CCCCCC"].CGColor;
    self.numChangeView.layer.borderWidth = 0.5;
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.numChangeView];
    
    UIButton *minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    minusBtn.backgroundColor = [UIColor redColor];
    [self.numChangeView addSubview:minusBtn];
    [minusBtn setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
    [minusBtn addTarget:self action:@selector(minusButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    minusBtn.tag = 11;
    self.minusButton = minusBtn;
    
    UITextField *goodsNumTF = [[UITextField alloc] init];
    [self.numChangeView addSubview:goodsNumTF];
    goodsNumTF.textAlignment = NSTextAlignmentCenter;
    goodsNumTF.text = @"1";
    goodsNumTF.font = [UIFont systemFontOfSize:14];
    goodsNumTF.textColor = [UIColor colorWithHexString:@"#666666"];
    self.goodsNumTF = goodsNumTF;
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.backgroundColor = [UIColor greenColor];
    [self.numChangeView addSubview:addBtn];
    [addBtn setImage:[UIImage imageNamed:@"3"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.tag = 12;
    self.addButton = addBtn;
    [self setupData:nil];
}

- (void)setSubviewsFrame:(BOOL )enableSelected {
    if (enableSelected) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 7;
        self.layer.cornerRadius = 10;
        self.goodsIdLabel.frame = kRect(159, 10, 176, 17);
        self.separator.frame = kRect(10, 37, 325, 0.5);
        self.selectedButton.frame = kRect(10, 83, 18, 18);
        self.goodsImageView.frame = kRect(38, 53, 80, 80);
        kWeakSelf(weakSelf);
        [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.separator.mas_bottom).offset(dis(14));
            make.left.equalTo(weakSelf.goodsImageView.mas_right).offset(dis(10));
            make.right.equalTo(weakSelf.mas_right).offset(dis(-10));
            make.height.lessThanOrEqualTo(@(dis(40.0)));
        }];
        [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.goodsImageView.mas_right).offset(dis(10));
            make.bottom.equalTo(weakSelf.mas_bottom).offset(dis(-16));
            make.width.lessThanOrEqualTo(@(dis(100.0)));
        }];
        
        [self.goodsTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.goodsImageView.mas_right).offset(dis(10));
            make.bottom.equalTo(weakSelf.goodsPriceLabel.mas_top).offset(dis(-12));
            make.right.equalTo(weakSelf.mas_right).offset(dis(-10));
        }];
        
        [self.numChangeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).offset(dis(-10));
            make.bottom.equalTo(weakSelf.mas_bottom).offset(dis(-15));
            make.width.mas_equalTo(dis(83));
            make.height.mas_equalTo(dis(24));
        }];
        
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.numChangeView.mas_right);
            make.bottom.equalTo(weakSelf.numChangeView.mas_bottom);
            make.width.mas_equalTo(dis(24));
            make.height.mas_equalTo(dis(24));
        }];
        
        [self.goodsNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.addButton.mas_left);
            make.bottom.equalTo(weakSelf.numChangeView.mas_bottom);
            make.width.mas_equalTo(dis(35));
            make.height.mas_equalTo(dis(24));
        }];
        
        [self.minusButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.goodsNumTF.mas_left);
            make.bottom.equalTo(weakSelf.numChangeView.mas_bottom);
            make.width.mas_equalTo(dis(24));
            make.height.mas_equalTo(dis(24));
        }];
    } else {
        self.selectedButton.hidden = YES;
        self.goodsIdLabel.frame = kRect(184, 15, 176, 17);
        self.separator.hidden = YES;
        self.selectedButton.hidden = YES;
        self.goodsImageView.frame = kRect(15, 45, 80, 80);
        kWeakSelf(weakSelf);
        [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf).offset(dis(44));
            make.left.equalTo(weakSelf.goodsImageView.mas_right).offset(dis(10));
            make.right.equalTo(weakSelf.mas_right).offset(dis(-15));
            make.height.lessThanOrEqualTo(@(dis(40.0)));
        }];
        [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.goodsImageView.mas_right).offset(dis(10));
            make.bottom.equalTo(weakSelf.mas_bottom).offset(dis(-16));
            make.width.lessThanOrEqualTo(@(dis(100.0)));
        }];
        
        [self.goodsTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.goodsImageView.mas_right).offset(dis(10));
            make.bottom.equalTo(weakSelf.goodsPriceLabel.mas_top).offset(dis(-12));
            make.right.equalTo(weakSelf.mas_right).offset(dis(-10));
        }];
        
        [self.numChangeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).offset(dis(-15));
            make.bottom.equalTo(weakSelf.mas_bottom).offset(dis(-15));
            make.width.mas_equalTo(dis(83));
            make.height.mas_equalTo(dis(24));
        }];
        
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.numChangeView.mas_right);
            make.bottom.equalTo(weakSelf.numChangeView.mas_bottom);
            make.width.mas_equalTo(dis(24));
            make.height.mas_equalTo(dis(24));
        }];
        
        [self.goodsNumTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.addButton.mas_left);
            make.bottom.equalTo(weakSelf.numChangeView.mas_bottom);
            make.width.mas_equalTo(dis(35));
            make.height.mas_equalTo(dis(24));
        }];
        
        [self.minusButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.goodsNumTF.mas_left);
            make.bottom.equalTo(weakSelf.numChangeView.mas_bottom);
            make.width.mas_equalTo(dis(24));
            make.height.mas_equalTo(dis(24));
        }];
    }
}

- (void)setUnitPriceText:(CGFloat)price goodsUnit:(NSString *)goodsUnit{
    NSString *priceStr = [NSString stringWithFormat:@"¥%.2f/%@", price, goodsUnit];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:priceStr attributes: @{NSFontAttributeName: kFont14 ,NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Mediu" size: 15] ? [UIFont fontWithName:@"PingFangSC-Mediu" size: 15] :kFont15 , NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#333333"]} range:NSMakeRange(0, priceStr.length - goodsUnit.length - 1)];
    [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"苹方-简 常规体" size: 14] ? [UIFont fontWithName:@"苹方-简 常规体" size: 14] : kFont14, NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#999999"]} range:NSMakeRange(priceStr.length - goodsUnit.length - 1, goodsUnit.length + 1)];
    self.goodsPriceLabel.attributedText = string;
}

- (void)setupData:(ZLShopGoodsModel *)goodsModel {
    self.goodsTitleLabel.text = @"这里是产品名称只显示两行多出的文字不显示多出的文字不显示多出";
    self.goodsIdLabel.text = @"商品编号：14732012832835";
    self.goodsPriceLabel.text = @"￥233.00/把";
    self.goodsTypeLabel.text = @"分类：零件";
    self.goodsNumTF.text = [NSString stringWithFormat:@"%@", @(goodsModel.goodsNum)];
    if (goodsModel.isSelected) {
        self.selectedButton.backgroundColor = [UIColor greenColor];
    } else {
        self.selectedButton.backgroundColor = [UIColor yellowColor];
    }
    [self setUnitPriceText:2330.00 goodsUnit:@"把"];
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

@end

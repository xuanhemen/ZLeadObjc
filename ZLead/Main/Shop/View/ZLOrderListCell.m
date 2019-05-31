//
//  ZLOrderListCell.m
//  ZLead
//
//  Created by dmy on 2019/5/29.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLOrderListCell.h"

@interface ZLOrderListCell ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UILabel *nicknameLabel;
@property (nonatomic, strong) UILabel *orderIdLabel;
@property (nonatomic, strong) UILabel *orderStatusLabel;
@property (nonatomic, strong) UILabel *orderTimeLabel;
@property (nonatomic, strong) UIView *hLine;
@property (nonatomic, strong) UIImageView *goodsImageView;
@property (nonatomic, strong) UILabel *goodsNameLabel;
@property (nonatomic, strong) UILabel *goodsUnitPriceLabel;
@property (nonatomic, strong) UILabel *goodsNumLabel;
@property (nonatomic, strong) UILabel *totalNumLabel;
@property (nonatomic, strong) UILabel *totalPriceLabel;
@property (nonatomic, strong) UILabel *transExpenseLabel;
@property (nonatomic, strong) UIButton *moreButton;
@end

@implementation ZLOrderListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        [self settingSubviewsLayout];
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupViews {
    self.containerView = [[UIView alloc] initWithFrame:CGRectZero];
    self.containerView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.containerView.layer.cornerRadius = 10;
    self.containerView.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:241/255.0 blue:215/255.0 alpha:0.26].CGColor;
    self.containerView.layer.shadowOffset = CGSizeMake(0,5);
    self.containerView.layer.shadowOpacity = 1;
    [self addSubview:self.containerView];
    
    self.nicknameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.nicknameLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    self.nicknameLabel.text = @"昵称";
    self.nicknameLabel.font = kFont14;
    [self.containerView addSubview:self.nicknameLabel];
    
    self.orderIdLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.orderIdLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    self.orderIdLabel.font = kFont12;
    self.orderIdLabel.text = @"订单号：";
    [self.containerView addSubview:self.orderIdLabel];
    
    self.orderStatusLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.orderStatusLabel.textColor = [UIColor colorWithHexString:@"#FFB223"];
    self.orderStatusLabel.font = kFont14;
    [self.containerView addSubview:self.orderStatusLabel];
    
    self.orderTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.orderTimeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    self.orderTimeLabel.font = kFont12;
    [self.containerView addSubview:self.orderTimeLabel];
    
    self.hLine = [[UIView alloc] initWithFrame:CGRectZero];
    self.hLine.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [self.containerView addSubview:self.hLine];
    
    self.goodsImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.containerView addSubview:self.goodsImageView];
    
    self.goodsNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.goodsNameLabel.numberOfLines = 2;
    self.goodsNumLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.containerView addSubview:self.goodsNameLabel];
    
    self.goodsUnitPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.goodsUnitPriceLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.goodsUnitPriceLabel.font = kFont16;
    [self.containerView addSubview:self.goodsUnitPriceLabel];

    self.goodsNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.goodsNumLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    self.goodsNumLabel.font = kFont13;
    [self.containerView addSubview:self.goodsNumLabel];
    
    self.transExpenseLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.transExpenseLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    self.transExpenseLabel.font = kFont14;
    [self.containerView addSubview:self.transExpenseLabel];
    
    self.totalNumLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.totalNumLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    self.totalNumLabel.font = kFont13;
    [self.containerView addSubview:self.totalNumLabel];
    
    self.totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.totalPriceLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.totalPriceLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.containerView addSubview:self.totalPriceLabel];
    
    self.moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.containerView addSubview:self.moreButton];
}

- (void)settingSubviewsLayout {
    kWeakSelf(weakSelf)
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(dis(10));
        make.left.equalTo(weakSelf).offset(dis(15));
        make.right.equalTo(weakSelf).offset(dis(-15));
        make.height.greaterThanOrEqualTo(@270);
    }];
    
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.containerView).offset(dis(15));
        make.left.equalTo(weakSelf.containerView).offset(dis(10));
        make.width.lessThanOrEqualTo(@250);
        make.height.mas_equalTo(dis(20));
    }];
    
    [self.orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.containerView).offset(dis(15));
        make.right.equalTo(weakSelf.containerView).offset(dis(-10));
        make.height.mas_equalTo(dis(20));
    }];
    
    [self.orderIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nicknameLabel.mas_bottom).offset(dis(5));
        make.left.equalTo(weakSelf.containerView).offset(dis(10));
        make.height.mas_equalTo(dis(17));
        make.width.lessThanOrEqualTo(@200);
    }];
    
    [self.orderTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderIdLabel.mas_top);
        make.right.equalTo(weakSelf.containerView).offset(dis(-15));
        make.height.mas_equalTo(dis(17));
        make.width.lessThanOrEqualTo(@135);
    }];
    
    [self.hLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.orderIdLabel.mas_bottom).offset(dis(15));
        make.left.equalTo(weakSelf.containerView);
        make.right.equalTo(weakSelf.containerView);
        make.height.mas_equalTo(1);
    }];
    
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.hLine.mas_bottom).offset(dis(16));
        make.left.equalTo(weakSelf.containerView).offset(dis(10));
        make.width.mas_equalTo(dis(73));
        make.height.mas_equalTo(dis(79));
    }];
    
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.hLine.mas_bottom).offset(dis(20));
        make.left.equalTo(weakSelf.goodsImageView.mas_right).offset(dis(12));
        make.right.equalTo(weakSelf.containerView).offset(dis(-10));
    }];
    
    [self.goodsUnitPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.hLine.mas_bottom).offset(dis(85));
        make.left.equalTo(weakSelf.goodsNameLabel);
        make.height.mas_equalTo(dis(22));
        make.width.lessThanOrEqualTo(@(dis(80)));
    }];
    
    [self.goodsNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.hLine.mas_bottom).offset(dis(87));
        make.left.equalTo(weakSelf.goodsUnitPriceLabel.mas_right).offset(dis(29));
        make.height.mas_equalTo(dis(18));
        make.width.lessThanOrEqualTo(@(dis(41)));
    }];
    
    [self.transExpenseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.hLine.mas_bottom).offset(dis(87));
        make.right.equalTo(weakSelf.containerView).offset(dis(-10));
        make.height.mas_equalTo(dis(20));
        make.width.lessThanOrEqualTo(@(dis(80)));
    }];
    
    [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.hLine.mas_bottom).offset(dis(137));
        make.right.equalTo(weakSelf.containerView).offset(dis(-10));
        make.bottom.equalTo(weakSelf.mas_bottom).offset(dis(-37));
        make.height.mas_equalTo(dis(22));
        make.width.lessThanOrEqualTo(@(dis(200)));
    }];
    
    [self.totalNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.hLine.mas_bottom).offset(dis(137));
        make.right.equalTo(weakSelf.totalPriceLabel.mas_left);
        make.bottom.equalTo(weakSelf.containerView.mas_bottom).offset(dis(-39));
        make.height.mas_equalTo(dis(22));
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.containerView);
        make.bottom.equalTo(weakSelf.containerView);
        make.height.mas_equalTo(dis(24));
        make.width.mas_equalTo(dis(24));
    }];
    
}

- (NSMutableAttributedString *)setPreText:(NSString *)preText preTextColor:(UIColor *)preTextColor lastText:(NSString *)lastText lastTextColor:(UIColor *)lastTextColor {
    NSString *wholeStr = [NSString stringWithFormat:@"%@%@", preText, lastText];
    NSMutableAttributedString *wholeAttrStr = [[NSMutableAttributedString alloc] initWithString:wholeStr attributes: @{NSFontAttributeName: kFont14 ,NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    [wholeAttrStr addAttributes:@{NSFontAttributeName: kFont14 , NSForegroundColorAttributeName: preTextColor} range:NSMakeRange(0, preText.length)];
    [wholeAttrStr addAttributes:@{NSFontAttributeName: kFont14, NSForegroundColorAttributeName: lastTextColor} range:NSMakeRange(preText.length, lastText.length)];
    return wholeAttrStr;
}

- (void)setupData:(id)dataModel {
    self.orderIdLabel.text = @"订单号：aaaaasd11111111111";
    self.orderStatusLabel.text = @"待发货";
    self.orderTimeLabel.text = @"2019-04-24 15:23:18";
    self.goodsImageView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    self.goodsNameLabel.text = @"陈小初杂品店的产品的名称产品的名称产品的名称产品的名称产品的名称陈小初杂品店的产品的名称产品的名称产品的名称产品的名称产品的名称";
    self.goodsUnitPriceLabel.text = @"￥3900.00";
    self.goodsNumLabel.text = @"X1000";
    self.transExpenseLabel.text = @"运费：￥0.00";
    self.totalNumLabel.text = @"共10件商品，合计：";
    self.totalPriceLabel.text = @"39,000.00";
    self.moreButton.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    self.nicknameLabel.attributedText = [self setPreText:@"昵称：" preTextColor:[UIColor colorWithHexString:@"#999999"] lastText:@"陈小初" lastTextColor:[UIColor colorWithHexString:@"#333333"]];
}

+ (CGFloat)heightForCell {
    return dis(280);
}

@end

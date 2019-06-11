//
//  ZLBatchSetClassifyView.m
//  ZLead
//
//  Created by dmy on 2019/6/11.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBatchSetClassifyView.h"

@interface ZLBatchSetClassifyView ()
@property (nonatomic, strong) UILabel *goodsNumLabel;
@property (nonatomic, strong) UIButton *batchSetButton;
@property (nonatomic, assign) NSInteger selectedGoodsNum;
@end

@implementation ZLBatchSetClassifyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    self.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    self.layer.shadowOffset = CGSizeMake(0,-4);
    self.layer.shadowOpacity = 1;
    self.layer.shadowRadius = 4;
    self.goodsNumLabel.text = [NSString stringWithFormat:@"共 %@ 件商品", @(self.selectedGoodsNum)];
    self.goodsNumLabel.frame = CGRectMake(dis(15), 0, dis(150), dis(50));
    self.batchSetButton.frame = CGRectMake(dis(209), dis(5), dis(161), dis(40));
    [self goodsNumLabelAttributedText];
}

- (UILabel *)goodsNumLabel {
    if (!_goodsNumLabel) {
        _goodsNumLabel = [[UILabel alloc] init];
        _goodsNumLabel.font = kFont14;
        _goodsNumLabel.textColor = [UIColor colorWithHexString:@"#666666"];
//        _goodsNumLabel.attributedText
        [self addSubview:_goodsNumLabel];
    }
    return _goodsNumLabel;
}

- (UIButton *)batchSetButton {
    if (!_batchSetButton) {
        _batchSetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _batchSetButton.backgroundColor = [UIColor zl_mainColor];
        _batchSetButton.titleLabel.font = kFont16;
        [_batchSetButton setTitle:@"批量设置分类" forState:UIControlStateNormal];
        [_batchSetButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _batchSetButton.layer.cornerRadius = 2;
        [_batchSetButton addTarget:self action:@selector(batchSetButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_batchSetButton];
    }
    return _batchSetButton;
}

- (void)goodsNumLabelAttributedText {
    NSString *wholeGoodsNumStr = [NSString stringWithFormat:@"共 %@ 件商品", @(_selectedGoodsNum)];
    NSString *goodsNumStr = [NSString stringWithFormat:@" %@ ", @(_selectedGoodsNum)];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:wholeGoodsNumStr attributes: @{NSFontAttributeName: kFont14 ,NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    [string addAttributes:@{NSFontAttributeName: kFont14 , NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#666666"]} range:NSMakeRange(0, 1)];
    [string addAttributes:@{NSFontAttributeName: kFont14 , NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#FF3A3A"]} range:NSMakeRange(1, goodsNumStr.length)];
    [string addAttributes:@{NSFontAttributeName: kFont14, NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#666666"]} range:NSMakeRange(goodsNumStr.length, wholeGoodsNumStr.length - goodsNumStr.length)];
    self.goodsNumLabel.attributedText = string;
}

- (void)setSelectedGoodsNum:(NSInteger )num {
    _selectedGoodsNum = num;
    [self goodsNumLabelAttributedText];
}

- (void)batchSetButtonAction {
    if (self.batchSetClassifyBlock) {
        self.batchSetClassifyBlock();
    }
}

@end

//
//  ZLGoodsBillView.m
//  ZLead
//
//  Created by dmy on 2019/5/28.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLGoodsBillView.h"
#import "ZLGoodsBillCell.h"
#import "ZLPaymentMethodCell.h"

@interface ZLGoodsBillView ()
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *calculateButton;
@end

@implementation ZLGoodsBillView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.billTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWith, kScreenHeight - (dis(51) + kSafeHeight)) style:UITableViewStylePlain];
    self.billTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.billTableView.backgroundColor = [UIColor clearColor];
    [self.billTableView registerClass:[ZLGoodsBillCell class] forCellReuseIdentifier:@"ZLGoodsBillCell"];
    [self.billTableView registerClass:[ZLPaymentMethodCell class] forCellReuseIdentifier:@"ZLPaymentMethodCell"];
    [self addSubview:self.billTableView];
    
    [self createBottomView];
}

- (void)createBottomView {
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    self.bottomView.frame = CGRectMake(0, kScreenHeight - dis(51) - kSafeHeight,kScreenWith, dis(51) + kSafeHeight);
    self.bottomView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    [self addSubview:self.bottomView];
    
    self.calculateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.calculateButton setTitle:@"去结算" forState:UIControlStateNormal];
    [self.calculateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.calculateButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.calculateButton.frame = kRect(269,5,96,41);
    self.calculateButton.backgroundColor = [UIColor colorWithHexString:@"#FFB223"];
    self.calculateButton.layer.cornerRadius = 24;
    [self.bottomView addSubview:self.calculateButton];
    
    self.totalPriceLabel = [[UILabel alloc] init];
    self.totalPriceLabel.frame = kRect(10, 0, 248, 51);
    self.totalPriceLabel.textAlignment = NSTextAlignmentRight;
    [self.bottomView addSubview:self.totalPriceLabel];
   
    
    [self setPriceText:21300.00];
}

- (void)setPriceText:(CGFloat)price {
    NSString *priceStr = [NSString stringWithFormat:@"合计：¥ %@", @(price)];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:priceStr attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 14] ? [UIFont fontWithName:@"PingFangSC-Regular" size: 14] : kFont14 ,NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
    [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"苹方-简 常规体" size: 12] ? [UIFont fontWithName:@"苹方-简 常规体" size: 12] :kFont12, NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#333333"]} range:NSMakeRange(0, 3)];
    [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"苹方-简 中粗体" size: 16] ? [UIFont fontWithName:@"苹方-简 中粗体" size: 16] : kFont16, NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:96/255.0 blue:3/255.0 alpha:1.0]} range:NSMakeRange(3, priceStr.length - 3)];
    self.totalPriceLabel.attributedText = string;
}

//#pragma mark - UIButton Actions
//
//- (void)allSelectedButtonAction:(UIButton *)allSelectedBtn {
//    allSelectedBtn.selected = !allSelectedBtn.selected;
//    if (self.allSelectedBlock) {
//        self.allSelectedBlock(allSelectedBtn.isSelected);
//    }
//}

@end

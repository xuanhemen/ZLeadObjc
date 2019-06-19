//
//  ZLMakeOrderView.m
//  ZLead
//
//  Created by dmy on 2019/5/28.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLMakeOrderView.h"
#import "ZLShoppingCartCell.h"
#import "ZLGoodsTypeSelectedView.h"
#import "ZLShopGoodsSearchBarView.h"

@interface ZLMakeOrderView ()
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *calculateButton;
@property (nonatomic, strong) ZLGoodsTypeSelectedView *typeSelectedView;
@property (nonatomic, strong) ZLShopGoodsSearchBarView *searchView;
@end

@implementation ZLMakeOrderView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        self.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    }
    return self;
}

- (void)setupViews {
    self.searchView = [[ZLShopGoodsSearchBarView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, dis(50))];
    self.searchView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.searchView];
    
    self.goodsListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarHeight + dis(50), kScreenWidth, kScreenHeight - (dis(50) + kSafeHeight)) style:UITableViewStylePlain];
    self.goodsListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.goodsListTableView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    self.goodsListTableView.backgroundView = nil;
    [self.goodsListTableView registerClass:[ZLShoppingCartCell class] forCellReuseIdentifier:@"ZLShoppingCartCell"];
    [self addSubview:self.goodsListTableView];
    
    [self createBottomView];
    
//    self.typeSelectedView = [[ZLGoodsTypeSelectedView alloc] initWithFrame:CGRectMake(0, self.searchView.bottom, kScreenWidth, dis(42))];
//    self.typeSelectedView.backgroundColor = [UIColor whiteColor];
//    self.typeSelectedView.resetButtonBlock = ^{
//
//    };
//
//    self.typeSelectedView.sureButtonBlock = ^(NSString * _Nonnull fType, NSString * _Nonnull sType, NSString * _Nonnull tType) {
//
//    };
//    [self addSubview:self.typeSelectedView];
}

- (void)createBottomView {
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    self.bottomView.frame = CGRectMake(0, kScreenHeight - dis(51) - kSafeHeight,kScreenWidth, dis(51) + kSafeHeight);
    self.bottomView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    [self addSubview:self.bottomView];
    
    self.allSelectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.allSelectedButton.frame = kRect(15, 17, 18, 18);
    [self.allSelectedButton addTarget:self action:@selector(allSelectedButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.allSelectedButton];
    
    UILabel *allSelectedLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.allSelectedButton.right + 6, 0, 100, dis(51))];
    allSelectedLabel.text = @"全选";
    allSelectedLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size: 13];
    allSelectedLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [self.bottomView addSubview:allSelectedLabel];
    
    self.calculateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.calculateButton setTitle:@"去结算" forState:UIControlStateNormal];
    [self.calculateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.calculateButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.calculateButton.frame = kRect(269,5,96,41);
    self.calculateButton.backgroundColor = [UIColor colorWithHexString:@"#FFB223"];
    self.calculateButton.layer.cornerRadius = dis(20);
    [self.calculateButton addTarget:self action:@selector(calculateButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.calculateButton];
}

#pragma mark - UIButton Actions

- (void)allSelectedButtonAction:(UIButton *)allSelectedBtn {
    allSelectedBtn.selected = !allSelectedBtn.selected;
    if (self.allSelectedBlock) {
        self.allSelectedBlock(allSelectedBtn.isSelected);
    }
}

- (void)calculateButtonAction {
    if (self.calculateButtonBlock) {
        self.calculateButtonBlock();
    }
}

@end

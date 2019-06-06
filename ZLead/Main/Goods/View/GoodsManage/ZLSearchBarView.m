//
//  ZLSearchBarView.m
//  ZLead
//
//  Created by dmy on 2019/6/6.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLSearchBarView.h"

@interface ZLSearchBarView ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIButton *manageButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) UIButton *addButton;
@end

@implementation ZLSearchBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    self.backButton.frame = CGRectMake(0, 0, dis(29), 30);
    [self.backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.backButton];
    
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, dis(276), 30)];
    self.containerView.backgroundColor = [UIColor colorWithHexString:@"#F1F1F1"];
    self.containerView.layer.cornerRadius = 15;
    [self addSubview:self.containerView];
    
    UIImageView *searchImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_search"]];
    searchImgV.frame = CGRectMake(15, 8.5, 13, 13);
    [self.containerView addSubview:searchImgV];
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(dis(33), 0, kScreenWidth - dis(130), 30)];
    self.searchTextField.placeholder = @"输入搜索商品的关键词";
    self.searchTextField.font = kFont13;
    [self.containerView addSubview:self.searchTextField];
    
    self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.searchButton.frame = CGRectMake(kScreenWidth - dis(60), 0, dis(60), 30);
    self.searchButton.titleLabel.font = kFont15;
    [self.searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchButton setTitleColor:[UIColor colorWithHexString:@"#F79A1E"] forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.searchButton];
    
    
    self.manageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.manageButton setTitle:@"管理" forState:UIControlStateNormal];
    [self.manageButton setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    self.manageButton.titleLabel.font = kFont15;
    [self addSubview:self.manageButton];
    self.manageButton.hidden = YES;
    [self.manageButton addTarget:self action:@selector(managerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addButton setImage:[UIImage imageNamed:@"goods-add-icon-gray"] forState:UIControlStateNormal];
    [self addSubview:self.addButton];
    [self.addButton addTarget:self action:@selector(addGoodsButtonAction) forControlEvents:UIControlEventTouchUpInside];
    self.addButton.hidden = YES;
    
}

- (void)changeSearchBarViewStyle:(BOOL)enableManage {
    if (!enableManage) {
        self.containerView.frame = CGRectMake(dis(29), 0, dis(276), 30);
        self.searchTextField.frame = CGRectMake(dis(33), 0, dis(243), 30);
        self.searchButton.frame = CGRectMake(self.containerView.right, 0, dis(50), 30);
        self.manageButton.hidden = YES;
        self.addButton.hidden = YES;
        self.searchButton.hidden = NO;
    } else {
        self.containerView.frame = CGRectMake(dis(29), 0, dis(233), 30);
        self.searchTextField.frame = CGRectMake(dis(33), 0, dis(243), 30);
        self.manageButton.frame = CGRectMake(self.containerView.right + dis(10), 0, dis(37), 30);
        self.addButton.frame = CGRectMake(self.manageButton.right + dis(5), 0, dis(37), 30);
        self.manageButton.hidden = NO;
        self.addButton.hidden = NO;
        self.searchButton.hidden = YES;
    }
}

#pragma mark - UIButton Actions

- (void)backButtonAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(backPreviousPage)]) {
        [self.delegate backPreviousPage];
    }
}

- (void)searchButtonAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchGoods)]) {
        [self.delegate searchGoods];
    }
}

- (void)addGoodsButtonAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(addGoods)]) {
        [self.delegate addGoods];
    }
}

- (void)managerButtonAction:(UIButton *)manageBtn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(manageGoods:)]) {
        [self.delegate manageGoods:manageBtn];
    }
}

@end

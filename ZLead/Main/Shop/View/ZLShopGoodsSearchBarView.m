//
//  ZLShopGoodsSearchBarView.m
//  ZLead
//
//  Created by dmy on 2019/5/29.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLShopGoodsSearchBarView.h"

@interface ZLShopGoodsSearchBarView ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIImageView *searchIcon;
@end

@implementation ZLShopGoodsSearchBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UIView *containerView = [[UIView alloc] initWithFrame:kRect(15, 15, 345, 30)];
    containerView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    containerView.layer.cornerRadius = dis(15);
    [self addSubview:containerView];
    
    self.searchIcon = [[UIImageView alloc] initWithFrame:kRect(12, 8, 13, 13)];
    self.searchIcon.image = [UIImage imageNamed:@"icon_search"];
    [containerView addSubview:self.searchIcon];
    
//    self.searchTextField = [[UITextField alloc] initWithFrame:kRect(31, 0, 315, 30)];
//    self.searchTextField.delegate = self;
//    self.searchTextField.font = kFont14;
//    self.searchTextField.placeholder = @"搜索商品名称/编号";
//    [containerView addSubview:self.searchTextField];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = kRect(31, 0, 315, 30);
    [searchButton setTitle:@"搜索商品名称/编号" forState:UIControlStateNormal];
    searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [searchButton setTitleColor:[UIColor colorWithHexString:@"#CCCCCC"] forState:UIControlStateNormal];
    searchButton.titleLabel.font = kFont12;
    [searchButton addTarget:self action:@selector(searchButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:searchButton];
}

#pragma mark - UIButton Actions

- (void)searchButtonAction:(UIButton *)searchBtn {
    if (self.startSearchBlock) {
        self.startSearchBlock();
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.startSearchBlock) {
        self.startSearchBlock();
    }
}

@end

//
//  ZLShopGoodsSearchBarView.m
//  ZLead
//
//  Created by dmy on 2019/5/29.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLShopGoodsSearchBarView.h"

@interface ZLShopGoodsSearchBarView ()
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UIImageView *searchIcon;
@end

@implementation ZLShopGoodsSearchBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    UIView *containerView = [[UIView alloc] initWithFrame:kRect(15, 6, 345, 30)];
    containerView.backgroundColor = [UIColor colorWithHexString:@"#F7F7F7"];
    containerView.layer.cornerRadius = dis(15);
    [self addSubview:containerView];
    
    self.searchIcon = [[UIImageView alloc] initWithFrame:kRect(12, 10, 9, 9)];
    [containerView addSubview:self.searchIcon];
    
    self.searchTextField = [[UITextField alloc] initWithFrame:kRect(25, 0, 315, 30)];
    self.searchTextField.font = kFont14;
    self.searchTextField.placeholder = @"搜索商品名称/编号";
    [containerView addSubview:self.searchTextField];
}

@end

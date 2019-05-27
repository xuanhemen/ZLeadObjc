//
//  ZLShopListCell.m
//  ZLead
//
//  Created by dmy on 2019/5/25.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLShopListCell.h"
@interface ZLShopListCell ()
@property (nonatomic, strong) UIImageView *shopLogo;
@property (nonatomic, strong) UILabel *shopNameLabel;
@property (nonatomic, strong) UILabel *shopTypeLabel;
@property (nonatomic, strong) UILabel *todayIncomeLabel;
@property (nonatomic, strong) UIImageView *authenticationIcon;
@end

@implementation ZLShopListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupViews {
    
    kWeakSelf(weakSelf)
    
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor whiteColor];
    containerView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    containerView.layer.cornerRadius = 4;
    containerView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.05].CGColor;
    containerView.layer.shadowOffset = CGSizeMake(0,0);
    containerView.layer.shadowOpacity = 1;
    containerView.layer.shadowRadius = 4;
    [self addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(15);
        make.right.equalTo(weakSelf).offset(-15);
        make.height.mas_equalTo(80);
        make.top.equalTo(weakSelf).offset(10);
    }];
    
    self.shopLogo = [[UIImageView alloc] init];
    self.shopLogo.backgroundColor = [UIColor colorWithHexString:@"#E76B00"];
    [containerView addSubview:self.shopLogo];
    
    self.shopNameLabel = [[UILabel alloc] init];
    self.shopNameLabel.text = @"店铺名称";
    self.shopNameLabel.font = [UIFont boldSystemFontOfSize:14];
    [containerView addSubview:self.shopNameLabel];
    
    self.shopTypeLabel = [[UILabel alloc] init];
    self.shopTypeLabel.text = @"个人小店";
    self.shopTypeLabel.font = [UIFont systemFontOfSize:11];
    self.shopTypeLabel.textColor = [UIColor colorWithHexString:@"#FFB223"];
    self.shopTypeLabel.layer.borderColor = [UIColor colorWithHexString:@"#FFB223"].CGColor;
    self.shopTypeLabel.layer.borderWidth = 1;
    self.shopTypeLabel.textAlignment = NSTextAlignmentCenter;
    self.shopTypeLabel.layer.cornerRadius = 8;
    self.shopTypeLabel.layer.masksToBounds = YES;
    [containerView addSubview:self.shopTypeLabel];
    
    self.todayIncomeLabel = [[UILabel alloc] init];
    self.todayIncomeLabel.text = @"今日收入：100000.00元";
    self.todayIncomeLabel.font = [UIFont systemFontOfSize:12];
    self.todayIncomeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    [containerView addSubview:self.todayIncomeLabel];
    
    self.authenticationIcon = [[UIImageView alloc] init];
    self.authenticationIcon.backgroundColor = [UIColor colorWithHexString:@"#E76B00"];
    [containerView addSubview:self.authenticationIcon];
    
    [self.shopLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(containerView).offset(8);
        make.left.mas_equalTo(containerView).offset(10);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(60);
    }];
    self.shopLogo.layer.cornerRadius = 30;
    self.shopLogo.layer.masksToBounds = YES;
    
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopLogo).offset(7);
        make.left.equalTo(self.shopLogo.mas_right).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    [self.shopTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopNameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.shopLogo.mas_right).offset(10);
        make.width.mas_equalTo(61);
        make.height.mas_equalTo(16);
    }];
    
    [self.todayIncomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shopNameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.shopTypeLabel.mas_right).offset(15);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(16);
    }];
    
    [self.authenticationIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(containerView).offset(14);
        make.right.equalTo(containerView);
        make.width.mas_equalTo(68);
        make.height.mas_equalTo(20);
    }];
}

+ (CGFloat)heightForCell {
    return 90;
}

@end

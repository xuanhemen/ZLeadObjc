//
//  ZLShopBusinessMenuCell.m
//  ZLead
//
//  Created by dmy on 2019/5/25.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLShopBusinessMenuCell.h"

#define kZLShopBusinessMenuCellHeight dis(123)

@interface ZLShopBusinessMenuCell ()

@end

@implementation ZLShopBusinessMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
        self.backgroundColor = [UIColor clearColor];
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
        make.left.equalTo(weakSelf).offset(dis(15));
        make.right.equalTo(weakSelf).offset(dis(-15));
        make.height.mas_equalTo(dis(100));
        make.top.equalTo(weakSelf).offset(dis(15));
    }];
    
    NSArray *titles = @[@"订单管理", @"一键开单", @"线下收款", @"敬请期待"];
    NSArray *icons = @[@"shop-order-manage", @"shop-make-order", @"shop-offline-pay", @"shop-coming-soon"];
    CGFloat singleMenuViewWidth = (kScreenWidth-dis(30))/4;
    UIView *tempSingleMenuView = nil;
    UIView *tempTitleLabel = nil;
    for (int i = 0; i < titles.count; i ++) {
        UIView *singleMenuView = [[UIView alloc] init];
        singleMenuView.tag = 100 + i;
        [containerView addSubview:singleMenuView];
        UITapGestureRecognizer *menuTapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleMenuViewTap:)];
        [singleMenuView addGestureRecognizer:menuTapGes];
        if (i == 0) {
            [singleMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.height.mas_equalTo(dis(100));
                make.width.mas_equalTo(singleMenuViewWidth);
                make.top.equalTo(containerView);
            }];
        } else  {
            [singleMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tempSingleMenuView.mas_right);
                make.height.mas_equalTo(dis(100));
                make.width.mas_equalTo(singleMenuViewWidth);
                make.top.equalTo(containerView);
            }];
        }
        tempSingleMenuView = singleMenuView;
        
        UIImageView *icon = [[UIImageView alloc] init];
        icon.image = [UIImage imageNamed:icons[i]];
        [singleMenuView addSubview:icon];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textColor = [UIColor colorWithHexString:@"#5B5F6C"];
        titleLabel.text = titles[i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [singleMenuView addSubview:titleLabel];
        
        if (i == 0) {
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.right.equalTo(singleMenuView);
                make.height.mas_equalTo(dis(17));
                make.width.mas_equalTo(singleMenuViewWidth);
                make.bottom.equalTo(singleMenuView.mas_bottom).offset(dis(-12));
            }];
        } else {
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(tempTitleLabel.mas_right);
                make.height.mas_equalTo(dis(17));
                make.width.mas_equalTo(singleMenuViewWidth);
                make.bottom.equalTo(singleMenuView.mas_bottom).offset(dis(-12));
            }];
        }
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(titleLabel.mas_centerX);
            make.height.mas_equalTo(dis(43));
            make.width.mas_equalTo(dis(43));
            make.top.equalTo(singleMenuView).offset(dis(19));
        }];
        
        
        tempTitleLabel = titleLabel;
    }
}

+ (CGFloat)heightForCell {
    return kZLShopBusinessMenuCellHeight;
}

#pragma mark - UITapGestureRecognizer Method

- (void)singleMenuViewTap:(UITapGestureRecognizer *)menuGes {
    if (self.shopBusinessBlock) {
        self.shopBusinessBlock(menuGes.view.tag - 100);
    }
}

@end

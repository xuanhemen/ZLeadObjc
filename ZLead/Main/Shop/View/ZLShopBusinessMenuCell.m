//
//  ZLShopBusinessMenuCell.m
//  ZLead
//
//  Created by dmy on 2019/5/25.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLShopBusinessMenuCell.h"

#define kZLShopBusinessMenuCellHeight 123

@interface ZLShopBusinessMenuCell ()

@end

@implementation ZLShopBusinessMenuCell

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
        make.height.mas_equalTo(100);
        make.top.equalTo(weakSelf).offset(15);
    }];
    
    NSArray *titles = @[@"订单管理", @"一键开单", @"线下收款", @"敬请期待"];
//    NSArray *icons = @[@"订单管理", @"一键开单", @"线下收款", @"敬请期待"];
    CGFloat singleMenuViewWidth = (ScreenWidth-30)/4;
    UIView *tempSingleMenuView = nil;
    UIView *tempTitleLabel = nil;
    for (int i = 0; i < titles.count; i ++) {
        UIView *singleMenuView = [[UIView alloc] init];
        [containerView addSubview:singleMenuView];
        if (i == 0) {
            [singleMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.height.mas_equalTo(100);
                make.width.mas_equalTo(singleMenuViewWidth);
                make.top.equalTo(containerView);
            }];
        } else  {
            [singleMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(tempSingleMenuView.mas_right);
                make.height.mas_equalTo(100);
                make.width.mas_equalTo(singleMenuViewWidth);
                make.top.equalTo(containerView);
            }];
        }
        tempSingleMenuView = singleMenuView;
        
        UIImageView *icon = [[UIImageView alloc] init];
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
                make.height.mas_equalTo(17);
                make.width.mas_equalTo(singleMenuViewWidth);
                make.bottom.equalTo(singleMenuView.mas_bottom).offset(-12);
            }];
        } else {
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(tempTitleLabel.mas_right);
                make.height.mas_equalTo(17);
                make.width.mas_equalTo(singleMenuViewWidth);
                make.bottom.equalTo(singleMenuView.mas_bottom).offset(-12);
            }];
        }
        
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(titleLabel.mas_centerX);
            make.height.mas_equalTo(43);
            make.width.mas_equalTo(43);
            make.top.equalTo(singleMenuView).offset(19);
        }];
        
        
        tempTitleLabel = titleLabel;
    }
}

+ (CGFloat)heightForCell {
    return kZLShopBusinessMenuCellHeight;
}
@end

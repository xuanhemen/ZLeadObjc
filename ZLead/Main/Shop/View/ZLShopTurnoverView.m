//
//  ZLShopTurnoverView.m
//  ZLead
//
//  Created by dmy on 2019/5/25.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLShopTurnoverView.h"
#import "ZLMarqueeView.h"

@interface ZLShopTurnoverView ()
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *turnoverValueLabel;
@property (nonatomic, strong) UILabel *todayturnoverTextLabel;
@property (nonatomic, strong) UILabel *orderTitleLabel;
@property (nonatomic, strong) UILabel *orderNumLabel;
@property (nonatomic, strong) UILabel *payTitleLabel;
@property (nonatomic, strong) UILabel *payNumLabel;
@property (nonatomic, strong) UILabel *vistorumTitleLabel;
@property (nonatomic, strong) UILabel *vistorumLabel;
@property (nonatomic, strong) ZLMarqueeView *notificationView;
@end

@implementation ZLShopTurnoverView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.bgImageView.backgroundColor = [UIColor colorWithHexString:@"#FFA700"];
    self.bgImageView.layer.cornerRadius = 4;
    [self addSubview:self.bgImageView];
    
    self.todayturnoverTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.todayturnoverTextLabel.text = @"今日营业额(元)";
    self.todayturnoverTextLabel.font = [UIFont systemFontOfSize:14];
    self.todayturnoverTextLabel.textColor = [UIColor whiteColor];
    [self.bgImageView addSubview:self.todayturnoverTextLabel];
    
    self.turnoverValueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.turnoverValueLabel.text = @"00.00";
    self.turnoverValueLabel.font = [UIFont systemFontOfSize:32];
    self.turnoverValueLabel.textColor = [UIColor whiteColor];
    [self.bgImageView addSubview:self.turnoverValueLabel];
    
    for (int i = 0; i < 3; i ++) {
        UILabel *numLabel = [[UILabel alloc] init];
        numLabel.font = [UIFont systemFontOfSize:20];
        numLabel.text = @"0";
        numLabel.textColor = [UIColor whiteColor];
        [self.bgImageView addSubview:numLabel];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:11];
        titleLabel.textColor = [UIColor whiteColor];
        [self.bgImageView addSubview:titleLabel];
        
        if (i == 0) {
            self.orderTitleLabel = titleLabel;
            self.orderTitleLabel.text = @"付款订单数";
            self.orderNumLabel = numLabel;
        } else if (i == 1) {
            self.payTitleLabel = titleLabel;
            self.payTitleLabel.text = @"付款件数";
            self.payNumLabel = numLabel;
        } else {
            self.vistorumTitleLabel = titleLabel;
            self.vistorumTitleLabel.text = @"到访人数";
            self.vistorumLabel = numLabel;
        }
    }
    
    [self settingSubViewLayout];
}

- (void)settingSubViewLayout {
    __weak __typeof(self) weakSelf = self;
    __weak __typeof(self.bgImageView) weakBgImageView = self.bgImageView;
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(15);
        make.right.equalTo(weakSelf).offset(-15);
        make.height.mas_equalTo(160);
        make.top.equalTo(weakSelf).offset(15);
    }];
    
    [self.todayturnoverTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakBgImageView).offset(20);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
        make.top.equalTo(weakBgImageView).offset(12);
    }];
    
    [self.turnoverValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.todayturnoverTextLabel).priorityHigh();
        make.right.equalTo(weakBgImageView).offset(-20).priorityHigh();
        make.height.mas_equalTo(45);
        make.top.equalTo(weakSelf.todayturnoverTextLabel.mas_bottom);
    }];
    
    CGFloat labelWidth = (ScreenWidth - 70)/3;
    [self.orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.todayturnoverTextLabel).priorityHigh();
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(28);
        make.top.equalTo(weakSelf.turnoverValueLabel.mas_bottom).offset(14);
    }];
    
    [self.payNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.orderNumLabel.mas_right);
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(28);
        make.top.equalTo(weakSelf.orderNumLabel);
    }];
    
    [self.vistorumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.payNumLabel.mas_right);
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(28);
        make.top.equalTo(weakSelf.orderNumLabel);
    }];

    [self.orderTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.todayturnoverTextLabel).priorityHigh();
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(15);
        make.top.equalTo(weakSelf.orderNumLabel.mas_bottom).offset(2);
    }];
    
    [self.payTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.orderTitleLabel.mas_right);
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(15);
        make.top.equalTo(weakSelf.orderNumLabel.mas_bottom).offset(2);
    }];
    
    [self.vistorumTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.payTitleLabel.mas_right);
        make.width.mas_equalTo(labelWidth);
        make.height.mas_equalTo(15);
        make.top.equalTo(weakSelf.orderNumLabel.mas_bottom).offset(2);
    }];
    
    [self addSubview:self.notificationView];
}

#pragma mark - Lazy Methods

- (ZLMarqueeView *)notificationView {
    if (!_notificationView) {
        ZLMarqueeView *marqueeView =[[ZLMarqueeView alloc] initWithFrame:CGRectMake(10, 180, dis(400), 48) withTitle:@[@"1.本月大拍卖优惠：今日03:34开抢", @"2.第二条通知。。。。", @"3.第三条通知。。。。", @"end"]];
        marqueeView.titleColor = [UIColor colorWithHexString:@"#664D38"];
        marqueeView.titleFont = [UIFont systemFontOfSize:11];
        __weak ZLMarqueeView *marquee = marqueeView;
        marqueeView.handlerTitleClickCallBack = ^(NSInteger index){
            DLog(@"%@----%zd",marquee.titleArr[index-1],index);
        };
        _notificationView = marqueeView;
    }
    return _notificationView;
    
}


@end

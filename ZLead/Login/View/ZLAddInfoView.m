//
//  ZLAddInfoView.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/30.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddInfoView.h"

@implementation ZLAddInfoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}
- (void)initView {
    
    UIView *oneView = [[UIView alloc] init];
    oneView.frame = kRect(30, 0, kScreenWith-60, 50);
    [self addSubview:oneView];
    CALayer *oneLayer = [CALayer layer];
    oneLayer.backgroundColor = [UIColor grayColor].CGColor;
    oneLayer.frame = kRect(0, oneView.frame.size.height-0.3, oneView.frame.size.width, 0.3);
    [oneView.layer addSublayer:oneLayer];
    
    UIButton *twoView = [UIButton buttonWithType:UIButtonTypeCustom];
    twoView.frame = kRect(30, 50, kScreenWith-60, 50);
    [self addSubview:twoView];
    CALayer *towLayer = [CALayer layer];
    towLayer.backgroundColor = [UIColor grayColor].CGColor;
    towLayer.frame = kRect(0, twoView.frame.size.height-0.3, twoView.frame.size.width, 0.3);
    [twoView.layer addSublayer:towLayer];
    
    
    UIView *thirdView = [[UIView alloc] init];
    thirdView.frame = kRect(30, 100, kScreenWith-60, 50);
    [self addSubview:thirdView];
    CALayer *thirdLayer = [CALayer layer];
    thirdLayer.backgroundColor = [UIColor grayColor].CGColor;
    thirdLayer.frame = kRect(0, thirdView.frame.size.height-0.3, thirdView.frame.size.width, 0.3);
    [thirdView.layer addSublayer:thirdLayer];
    
    UILabel *name = [[UILabel alloc] init];
    name.text = @"店铺名称";
    name.font = kFont16;
    [oneView addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.superview);
        make.centerY.equalTo(name.superview);
    }];
    UILabel *symbol = [[UILabel alloc] init];
    symbol.text = @"*";
    symbol.textColor = [UIColor redColor];
    symbol.font = kFont16;
    [oneView addSubview:symbol];
    [symbol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_right).offset(5);
        make.centerY.equalTo(name.superview);
    }];
    UITextField *nameField = [[UITextField alloc] init];
    nameField.placeholder = @"请输入您的店铺名称（必填）";
    [oneView addSubview:nameField];
    [nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_right).offset(20);
        make.centerY.equalTo(name);
    }];
    
    UILabel *area = [[UILabel alloc] init];
    area.text = @"选择地区";
    area.font = kFont16;
    [twoView addSubview:area];
    [area mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(area.superview);
        make.centerY.equalTo(area.superview);
    }];
    UILabel *areaLable = [[UILabel alloc] init];
    areaLable.text = @"请选择省市区";
    areaLable.textColor = lightColor;
    areaLable.font = kFont17;
    [twoView addSubview:areaLable];
    [areaLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(area.mas_right).offset(20);
        make.centerY.equalTo(area);
    }];

    UIImageView *arrowView = [[UIImageView alloc] init];
    arrowView.image = image(@"personalshop");
    [twoView addSubview:arrowView];
    [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(arrowView.superview);
        make.right.equalTo(arrowView.superview);
    }];
    
    UILabel *address = [[UILabel alloc] init];
    address.text = @"详细地址";
    address.font = kFont16;
    [thirdView addSubview:address];
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(address.superview);
        make.centerY.equalTo(address.superview);
    }];
    UITextField *addressField = [[UITextField alloc] init];
    addressField.placeholder = @"请输入详细地址";
    [thirdView addSubview:addressField];
    [addressField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(address.mas_right).offset(20);
        make.centerY.equalTo(address);
    }];
}
@end

//
//  ZLAddInfoView.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/30.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddInfoView.h"
#import "MOFSPickerManager.h"
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
    oneView.frame = kRect(30, 0, kScreenWidth-60, 50);
    [self addSubview:oneView];
    CALayer *oneLayer = [CALayer layer];
    oneLayer.backgroundColor = [UIColor grayColor].CGColor;
    oneLayer.frame = kRect(0, oneView.frame.size.height-0.3, oneView.frame.size.width, 0.3);
    [oneView.layer addSublayer:oneLayer];
    
    UIButton *twoView = [UIButton buttonWithType:UIButtonTypeCustom];
    twoView.frame = kRect(30, 50, kScreenWidth-60, 50);
    [self addSubview:twoView];
    CALayer *towLayer = [CALayer layer];
    towLayer.backgroundColor = [UIColor grayColor].CGColor;
    towLayer.frame = kRect(0, twoView.frame.size.height-0.3, twoView.frame.size.width, 0.3);
    [twoView.layer addSublayer:towLayer];
    
    
    
    UIView *thirdView = [[UIView alloc] init];
    thirdView.frame = kRect(30, 100, kScreenWidth-60, 50);
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
    _nameField = [[UITextField alloc] init];
    _nameField.placeholder = @"请输入您的店铺名称（必填）";
    [oneView addSubview:_nameField];
    [_nameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(name.mas_right).offset(20);
        make.right.equalTo(self.nameField.superview);
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
    _areaLable = [[UILabel alloc] init];
    _areaLable.text = @"请选择省市区";
    _areaLable.textColor = lightColor;
    _areaLable.font = kFont17;
    [twoView addSubview:_areaLable];
    [_areaLable mas_makeConstraints:^(MASConstraintMaker *make) {
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
    _addressField = [[UITextField alloc] init];
    _addressField.placeholder = @"请输入详细地址";
    [thirdView addSubview:_addressField];
    [_addressField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(thirdView).offset(dis(85));
        make.centerY.equalTo(address);
        make.right.equalTo(self.addressField.superview);
    }];
    
    [[twoView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [[MOFSPickerManager shareManger] showMOFSAddressPickerWithTitle:nil cancelTitle:@"取消" commitTitle:@"完成" commitBlock:^(NSString *address, NSString *zipcode) {
            self.areaLable.text = address; //用于显示
            zipcode = [zipcode stringByReplacingOccurrencesOfString:@"-" withString:@"."];
            self.areaCode = zipcode; //省市编码
            self.areaLable.textColor = [UIColor grayColor];
        } cancelBlock:^{
            
        }];
    }];
}
@end

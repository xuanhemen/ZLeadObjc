//
//  ZLAddStoreVC.m
//  ZLead
//
//  Created by qzwh on 2019/5/28.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddStoreVC.h"

@interface ZLAddStoreVC ()

@property (nonatomic, strong)UIView *containerView;

@property (nonatomic, strong)UITextField *nameTextF;
@property (nonatomic, strong)UITextField *storeTextF;
@property (nonatomic, strong)UITextField *areaTextF;
@property (nonatomic, strong)UITextField *addressTextF;

@property (nonatomic, strong)UIButton *submitBtn;

@end

@implementation ZLAddStoreVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
}

- (void)setup {
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(kNavBarHeight);
    }];
    
    [self.nameTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(25);
        make.right.equalTo(self.containerView).offset(-10);
        make.top.equalTo(self.containerView);
        make.height.mas_equalTo(50);
    }];
    
    UIView *line1V = [[UIView alloc] init];
    line1V.backgroundColor = [UIColor zl_lineColor];
    [self.containerView addSubview:line1V];
    [line1V mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameTextF);
        make.right.equalTo(self.containerView);
        make.top.equalTo(self.nameTextF.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    [self.storeTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.nameTextF);
        make.top.equalTo(line1V);
    }];
    
    UIView *line2V = [[UIView alloc] init];
    line2V.backgroundColor = [UIColor zl_lineColor];
    [self.containerView addSubview:line2V];
    [line2V mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(line1V);
        make.top.equalTo(self.storeTextF.mas_bottom);
    }];
    
    [self.areaTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.nameTextF);
        make.top.equalTo(line2V);
    }];
    
    UIView *line3V = [[UIView alloc] init];
    line3V.backgroundColor = [UIColor zl_lineColor];
    [self.containerView addSubview:line3V];
    [line3V mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(line1V);
        make.top.equalTo(self.areaTextF.mas_bottom);
    }];
    
    [self.addressTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.nameTextF);
        make.top.equalTo(line3V);
        make.bottom.equalTo(self.containerView);
    }];
    
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.top.equalTo(self.containerView.mas_bottom).offset(60);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(dis(45));
    }];
}

#pragma mark - lazy load
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_containerView];
    }
    return _containerView;
}

- (UITextField *)nameTextF {
    if (!_nameTextF) {
        _nameTextF = [[UITextField alloc] init];
        _nameTextF.placeholder = @"请输入您的真实姓名（必填）";
        _nameTextF.font = kFont14;
        [self.containerView addSubview:_nameTextF];
        
        UILabel *nameLbl = [self createCustomLblWithText:@"姓名*"];
        _nameTextF.leftView = nameLbl;
        [_nameTextF setLeftViewMode:UITextFieldViewModeAlways];
    }
    return _nameTextF;
}

- (UITextField *)storeTextF {
    if (!_storeTextF) {
        _storeTextF = [[UITextField alloc] init];
        _storeTextF.placeholder = @"店铺名称";
        _storeTextF.font = kFont14;
        [self.containerView addSubview:_storeTextF];
        
        UILabel *storeLbl = [self createCustomLblWithText:@"店铺名称"];
        _storeTextF.leftView = storeLbl;
        [_storeTextF setLeftViewMode:UITextFieldViewModeAlways];
    }
    return _storeTextF;
}

- (UITextField *)areaTextF {
    if (!_areaTextF) {
        _areaTextF = [[UITextField alloc] init];
        _areaTextF.placeholder = @"请选择地区";
        _areaTextF.font = kFont14;
        [self.containerView addSubview:_areaTextF];
        
        UILabel *areaLbl = [self createCustomLblWithText:@"选择地区"];
        _areaTextF.leftView = areaLbl;
        [_areaTextF setLeftViewMode:UITextFieldViewModeAlways];
    }
    return _areaTextF;
}

- (UITextField *)addressTextF {
    if (!_addressTextF) {
        _addressTextF = [[UITextField alloc] init];
        _addressTextF.placeholder = @"请输入详细地址";
        _addressTextF.font = kFont14;
        [self.containerView addSubview:_addressTextF];
        
        UILabel *addressLbl = [self createCustomLblWithText:@"详细地址"];
        _addressTextF.leftView = addressLbl;
        [_addressTextF setLeftViewMode:UITextFieldViewModeAlways];
    }
    return _addressTextF;
}

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"添加" forState:UIControlStateNormal];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"#FFB223"];
        _submitBtn.layer.cornerRadius = dis(45)/2;
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_submitBtn];
    }
    return _submitBtn;
}

- (UILabel *)createCustomLblWithText:(NSString *)text {
    UILabel *lbl = [[UILabel alloc] init];
    lbl.frame = CGRectMake(0, 0, 100, 30);
//    lbl.text = text;
    NSMutableAttributedString *mStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange range = [text rangeOfString:@"*"];
    [mStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range: range];
    lbl.attributedText = mStr;
    lbl.font = kFont14;
    return lbl;
}

@end

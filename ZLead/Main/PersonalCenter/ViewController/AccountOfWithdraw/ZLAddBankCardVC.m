//
//  ZLAddBankCardVC.m
//  ZLead
//
//  Created by qzwh on 2019/5/27.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddBankCardVC.h"

@interface ZLAddBankCardVC ()<UITextFieldDelegate>

@property (nonatomic, strong)UIView *containerView;
@property (nonatomic, strong)UITextField *nameTextF;
@property (nonatomic, strong)UITextField *bankTextF;
@property (nonatomic, strong)UITextField *bankNumTextF;
@property (nonatomic, strong)UITextField *phoneTextF;
@property (nonatomic, strong)UITextField *verifyTextF;

@property (nonatomic, strong)UIButton *verifyBtn;
@property (nonatomic, strong)UIButton *submitBtn;

@end

@implementation ZLAddBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置银行卡";
    [self setup];
}

- (void)setup {
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(kNavBarHeight);
    }];
    
    [self.nameTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView);
        make.left.equalTo(self.containerView).offset(25);
        make.right.equalTo(self.containerView).offset(-10);
        make.height.mas_equalTo(dis(50));
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
    
    [self.bankTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1V);
        make.left.right.height.equalTo(self.nameTextF);
    }];
    
    UIView *line2V = [[UIView alloc] init];
    line2V.backgroundColor = [UIColor zl_lineColor];
    [self.containerView addSubview:line2V];
    [line2V mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(line1V);
        make.top.equalTo(self.bankTextF.mas_bottom);
    }];
    
    [self.bankNumTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2V);
        make.left.right.height.equalTo(self.nameTextF);
    }];
    
    UIView *line3V = [[UIView alloc] init];
    line3V.backgroundColor = [UIColor zl_lineColor];
    [self.containerView addSubview:line3V];
    [line3V mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(line1V);
        make.top.equalTo(self.bankNumTextF.mas_bottom);
    }];
    
    [self.phoneTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line3V);
        make.left.right.height.equalTo(self.nameTextF);
    }];
    
    UIView *line4V = [[UIView alloc] init];
    line4V.backgroundColor = [UIColor zl_lineColor];
    [self.containerView addSubview:line4V];
    [line4V mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(line1V);
        make.top.equalTo(self.phoneTextF.mas_bottom);
    }];
    
    [self.verifyTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line4V);
        make.left.right.height.equalTo(self.nameTextF);
        make.bottom.equalTo(self.containerView);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.containerView.mas_bottom).offset(dis(60));
        make.height.mas_equalTo(dis(45));
    }];
}

- (void)tapGesture:(UITapGestureRecognizer *)tapG {
    NSLog(@"12345");
}

#pragma mark - textFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.bankTextF) {
        return NO;
    }
    return YES;
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
        _nameTextF.placeholder = @"持卡人姓名";
        _nameTextF.font = kFont14;
        [self.containerView addSubview:_nameTextF];
        
        UILabel *nameLbl = [self createCustomLblWithText:@"姓名"];
        _nameTextF.leftView = nameLbl;
        _nameTextF.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return _nameTextF;
}

- (UITextField *)bankTextF {
    if (!_bankTextF) {
        _bankTextF = [[UITextField alloc] init];
        _bankTextF.placeholder = @"选择开户行";
        _bankTextF.font = kFont14;
        [self.containerView addSubview:_bankTextF];
        
        UILabel *bankLbl = [self createCustomLblWithText:@"开户行"];
        _bankTextF.leftView = bankLbl;
        _bankTextF.leftViewMode = UITextFieldViewModeAlways;
        
        UIImageView *goImgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_jump"]];
        
        _bankTextF.rightView = goImgV;
        _bankTextF.rightViewMode = UITextFieldViewModeAlways;
        
        _bankTextF.delegate = self;
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [_bankTextF addGestureRecognizer:tapG];
    }
    return _bankTextF;
}

- (UITextField *)bankNumTextF {
    if (!_bankNumTextF) {
        _bankNumTextF = [[UITextField alloc] init];
        _bankNumTextF.placeholder = @"16～19位银行卡号";
        _bankNumTextF.font = kFont14;
        [self.containerView addSubview:_bankNumTextF];
        
        UILabel *bankNumLbl = [self createCustomLblWithText:@"银行卡号"];
        _bankNumTextF.leftView = bankNumLbl;
        _bankNumTextF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _bankNumTextF;
}

- (UITextField *)phoneTextF {
    if (!_phoneTextF) {
        _phoneTextF = [[UITextField alloc] init];
        _phoneTextF.placeholder = @"phone";
        _phoneTextF.font = kFont14;
        [self.containerView addSubview:_phoneTextF];
        
        UILabel *phoneLbl = [self createCustomLblWithText:@"预留手机号"];
        _phoneTextF.leftView = phoneLbl;
        [_phoneTextF setLeftViewMode:UITextFieldViewModeAlways];
    }
    return _phoneTextF;
}

- (UITextField *)verifyTextF {
    if (!_verifyTextF) {
        _verifyTextF = [[UITextField alloc] init];
        _verifyTextF.placeholder = @"手机验证码";
        _verifyTextF.font = kFont14;
        [self.containerView addSubview:_verifyTextF];
        
        UILabel *verifyLbl = [self createCustomLblWithText:@"验证码"];
        _verifyTextF.leftView = verifyLbl;
        [_verifyTextF setLeftViewMode:UITextFieldViewModeAlways];
        
        _verifyTextF.rightView = self.verifyBtn;
        [_verifyTextF setRightViewMode:UITextFieldViewModeAlways];
    }
    return _verifyTextF;
}

- (UIButton *)verifyBtn {
    if (!_verifyBtn) {
        _verifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _verifyBtn.frame = CGRectMake(0, 0, 80, 30);
        _verifyBtn.titleLabel.font = kFont14;
        [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verifyBtn setTitleColor:[UIColor colorWithHexString:@"#008EFF"] forState:UIControlStateNormal];
    }
    return _verifyBtn;
}

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        _submitBtn.layer.cornerRadius = dis(45)/2;
        [_submitBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor colorWithHexString:@"#BBBBBB"] forState:UIControlStateNormal];
        [self.view addSubview:_submitBtn];
    }
    return _submitBtn;
}

- (UILabel *)createCustomLblWithText:(NSString *)text {
    UILabel *lbl = [[UILabel alloc] init];
    lbl.frame = CGRectMake(0, 0, 100, 30);
    lbl.text = text;
    lbl.font = kFont14;
    return lbl;
}


@end

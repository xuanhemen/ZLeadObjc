//
//  ZLSetWechatVC.m
//  ZLead
//
//  Created by qzwh on 2019/5/27.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLSetWechatVC.h"

@interface ZLSetWechatVC ()<UITextFieldDelegate>

@property (nonatomic, strong)UIView *containerView;
@property (nonatomic, strong)UITextField *accountTextF;
@property (nonatomic, strong)UIView *line1View;
@property (nonatomic, strong)UITextField *phoneTextF;
@property (nonatomic, strong)UIView *line2View;
@property (nonatomic, strong)UITextField *verifyTextF;

@property (nonatomic, strong)UIButton *authBtn;
@property (nonatomic, strong)UIButton *verifyBtn;

@property (nonatomic, strong)UIButton *submitBtn;

@end

@implementation ZLSetWechatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.type == AccountTypeAlipay ? @"设置支付宝": @"设置微信";
    [self setup];
}

- (void)setup {
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kNavBarHeight);
        make.left.right.equalTo(self.view);
    }];
    
    [self.accountTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(dis(25));
        make.top.equalTo(self.containerView);
        make.height.mas_equalTo(dis(50));
        make.right.equalTo(self.containerView).offset(dis(-10));
    }];
    
    [self.line1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accountTextF);
        make.right.equalTo(self.containerView);
        make.top.equalTo(self.accountTextF.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    [self.phoneTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(self.accountTextF);
        make.top.equalTo(self.line1View);
        make.right.equalTo(self.accountTextF);
    }];
    
    [self.line2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.line1View);
        make.top.equalTo(self.phoneTextF.mas_bottom);
    }];
    
    [self.verifyTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.equalTo(self.accountTextF);
        make.top.equalTo(self.line2View);
        make.bottom.equalTo(self.containerView);
        make.right.equalTo(self.accountTextF);
    }];
    
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(25);
        make.top.equalTo(self.containerView.mas_bottom).offset(dis(60));
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(dis(45));
    }];
}

#pragma mark - action
- (void)authBtnClicked:(UIButton *)sender {
    NSLog(@"点击了授权");
}

- (void)verifyBtnClicked:(UIButton *)sender {
    NSLog(@"发送验证码");
}

#pragma mark - delegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.accountTextF) {
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

- (UIView *)line1View {
    if (!_line1View) {
        _line1View = [[UIView alloc] init];
        _line1View.backgroundColor = [UIColor zl_lineColor];
        [self.containerView addSubview:_line1View];
    }
    return _line1View;
}

- (UIView *)line2View {
    if (!_line2View) {
        _line2View = [[UIView alloc] init];
        _line2View.backgroundColor = [UIColor zl_lineColor];
        [self.containerView addSubview:_line2View];
    }
    return _line2View;
}

- (UITextField *)accountTextF {
    if (!_accountTextF) {
        _accountTextF = [[UITextField alloc] init];
        _accountTextF.font = kFont14;
        [self.containerView addSubview:_accountTextF];
        NSString *text = self.type == AccountTypeAlipay ? @"支付宝": @"微信号";
        _accountTextF.leftView = [self createCustomLblWithText:text];
        _accountTextF.leftViewMode = UITextFieldViewModeAlways;
        _accountTextF.placeholder = @"account";
        _accountTextF.rightView = self.authBtn;
        _accountTextF.rightViewMode = UITextFieldViewModeAlways;
        _accountTextF.delegate = self;
    }
    return _accountTextF;
}

- (UITextField *)phoneTextF {
    if (!_phoneTextF) {
        _phoneTextF = [[UITextField alloc] init];
        _phoneTextF.font = kFont14;
        [self.containerView addSubview:_phoneTextF];
        _phoneTextF.leftView = [self createCustomLblWithText:@"预留手机号"];
        _phoneTextF.leftViewMode = UITextFieldViewModeAlways;
        _phoneTextF.placeholder = @"phone";
    }
    return _phoneTextF;
}

- (UITextField *)verifyTextF {
    if (!_verifyTextF) {
        _verifyTextF = [[UITextField alloc] init];
        _verifyTextF.font = kFont14;
        [self.containerView addSubview:_verifyTextF];
        _verifyTextF.leftView = [self createCustomLblWithText:@"验证码"];
        _verifyTextF.leftViewMode = UITextFieldViewModeAlways;
        _verifyTextF.placeholder = @"verify";
        _verifyTextF.rightView = self.verifyBtn;
        _verifyTextF.rightViewMode = UITextFieldViewModeAlways;
    }
    return _verifyTextF;
}

- (UIButton *)authBtn {
    if (!_authBtn) {
        _authBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _authBtn.frame = CGRectMake(0, 0, 50, 30);
        _authBtn.titleLabel.font = kFont14;
        [_authBtn setTitle:@"授权" forState:UIControlStateNormal];
        [_authBtn setTitleColor:[UIColor colorWithHexString:@"#008EFF"] forState:UIControlStateNormal];
        [_authBtn addTarget:self action:@selector(authBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _authBtn;
}

- (UIButton *)verifyBtn {
    if (!_verifyBtn) {
        _verifyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _verifyBtn.frame = CGRectMake(0, 0, 80, 30);
        _verifyBtn.titleLabel.font = kFont14;
        [_verifyBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verifyBtn setTitleColor:[UIColor colorWithHexString:@"#008EFF"] forState:UIControlStateNormal];
        [_verifyBtn addTarget:self action:@selector(verifyBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
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

#pragma mark - private
- (UILabel *)createCustomLblWithText:(NSString *)text {
    UILabel *lbl = [[UILabel alloc] init];
    lbl.frame = CGRectMake(0, 0, 100, 30);
    lbl.text = text;
    lbl.font = kFont14;
    return lbl;
}


@end


//
//  ZLInputView.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/25.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLInputView.h"

@implementation ZLInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.userField]; //添加用户输入框
        [self addSubview:self.pwField]; //添加密码输入框
    }
    return self;
}
- (CustomTextField *)userField{
    if (!_userField) {
        _userField = [[CustomTextField alloc] init];
        UIImageView * leftView = [[UIImageView alloc] init];
        leftView.image = image(@"userImg");
        _userField.leftView = leftView;
        _userField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _userField.keyboardType = UIKeyboardTypeNumberPad;
        _userField.placeholder = @"请输入手机号";
        _userField.clearsOnBeginEditing = NO;
        [self addSubview:_userField];
        
    }
    return _userField;
}
- (CustomTextField *)pwField{
    if (!_pwField) {
        _pwField = [[CustomTextField alloc]init];
        UIImageView * leftView = [[UIImageView alloc] init];
        leftView.image = image(@"passwordImg");
        _pwField.leftView = leftView;
        _pwField.rightView = [self rightBtnView];
        _pwField.rightViewMode=UITextFieldViewModeAlways;
        _pwField.keyboardType = UIKeyboardTypeTwitter;
        _pwField.clearsOnBeginEditing = NO;
        _pwField.secureTextEntry = YES;
        _pwField.placeholder = @"请输入密码";
        [self addSubview:_pwField];
    }
    return _userField;
}
- (UIButton *)rightBtnView{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [btn setTitleColor:lightColor forState:UIControlStateNormal];
    btn.titleLabel.font = kFont16;
    return btn;
}
- (void)layoutSubviews{
    _userField.frame = kRect(25, 0, kScreenWith-50, self.frame.size.height/2);
    _pwField.frame = kRect(25, self.frame.size.height/2, kScreenWith-50, self.frame.size.height/2);
}
@end

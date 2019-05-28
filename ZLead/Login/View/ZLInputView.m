
//
//  ZLInputView.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/25.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLInputView.h"
@interface ZLInputView ()

@end
@implementation ZLInputView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame viewModel:(ZLLoginViewModel *)viewModel{
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
        _pwField.rightView = self.rightBtnView; //右视图
        _pwField.rightViewMode=UITextFieldViewModeAlways;
        _pwField.keyboardType = UIKeyboardTypeTwitter;
        _pwField.clearsOnBeginEditing = NO;
        _pwField.secureTextEntry = YES;
        _pwField.placeholder = @"请输入验证码";
        [self addSubview:_pwField];
    }
    return _userField;
}
- (UIButton *)rightBtnView{
    if (!_rightBtnView) {
        _rightBtnView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtnView setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_rightBtnView setTitleColor:lightColor forState:UIControlStateNormal];
        _rightBtnView.titleLabel.font = kFont16;
    }
      return _rightBtnView;
}
- (void)layoutSubviews{
    _userField.frame = kRect(25, 0, kScreenWith-50, self.frame.size.height/2);
    _pwField.frame = kRect(25, self.frame.size.height/2, kScreenWith-50, self.frame.size.height/2);
}
- (void)changeStyle:(BOOL)isSelected{
    if (isSelected) { //账号密码登录
        UIImageView * leftView = [[UIImageView alloc] init];
        leftView.image = image(@"secImg");
        _pwField.leftView = leftView;
        _pwField.placeholder = @"请输入密码";
        [_rightBtnView setTitle:@"忘记密码" forState:UIControlStateNormal];
    }else{ //验证码登录
        UIImageView * leftView = [[UIImageView alloc] init];
        leftView.image = image(@"passwordImg");
        _pwField.leftView = leftView;
        _pwField.placeholder = @"请输入验证码";
        [_rightBtnView setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    
}
@end

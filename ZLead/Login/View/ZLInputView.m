
//
//  ZLInputView.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/25.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLInputView.h"

@interface ZLInputView ()


@property (nonatomic, copy) NSString *str; // <#annotation#>
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
        self.viewModel = viewModel;
        [self addSubview:self.userField]; //添加用户输入框
        [self addSubview:self.pwField]; //添加密码输入框
        RAC(self.rightBtnView.titleLabel,text) = [RACObserve(self.viewModel, seconds) map:^id _Nullable(id  _Nullable value) {
            if (value == nil || value == [NSNull null]) {
                [self.rightBtnView setTitle:@"获取验证码" forState:UIControlStateNormal];
            }else{
                [self.rightBtnView setTitle:value forState:UIControlStateNormal];
            }
            
            return [value description];
        }];
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
        kWeakSelf(weakSelf)
        [[_userField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
          if (value.length == 11) {
              weakSelf.rightBtnView.enabled = YES;
              [weakSelf.rightBtnView setTitleColor:hex(@"#FFB223") forState:UIControlStateNormal];
             
             }
          if (value.length > 11) { //过滤判断条件
                weakSelf.userField.text = [weakSelf.userField.text substringToIndex:11];
                [weakSelf showMsg:@"目前只支持11位手机号"];
          }else if (value.length < 11){
              weakSelf.rightBtnView.enabled = NO;
              [weakSelf.rightBtnView setTitleColor:lightColor forState:UIControlStateNormal];
              
          }
                return value.length <= 11;
        
            }] subscribeNext:^(NSString * _Nullable x) {
                self.viewModel.phoneNumber = x;
                //订阅逻辑区域
                NSLog(@"filter过滤后的订阅内容：%@",x);
            }];
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
        _pwField.placeholder = @"请输入验证码";
        kWeakSelf(weakSelf)
        [[_pwField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
            if ([weakSelf.pwField.placeholder isEqualToString:@"请输入验证码"]) {
                if (value.length==4 && weakSelf.userField.text.length==11) {
                    if (self.changeLoginState) {
                        self.changeLoginState(YES);
                    }
                } else if (value.length>4) {
                    weakSelf.pwField.text = [weakSelf.pwField.text substringToIndex:4];
                    [self showMsg:@"验证码只能是四位"];
                } else if (value.length<4) {
                    if (self.changeLoginState) {
                        self.changeLoginState(NO);
                    }
                }
            }else if ([weakSelf.pwField.placeholder isEqualToString:@"请输入密码"]){
                if (value.length==6 && weakSelf.userField.text.length==11) {
                    if (self.changeLoginState) {
                        self.changeLoginState(YES);
                    }
                }else if (value.length<6) {
                    if (self.changeLoginState) {
                        self.changeLoginState(NO);
                    }
                }else if (value.length>20) {
                    weakSelf.pwField.text = [weakSelf.pwField.text substringToIndex:20];
                    [self showMsg:@"密码最多20位"];
                }
            }
            return YES;
        }] subscribeNext:^(NSString * _Nullable x) {
            self.viewModel.authCode = x;
        }];
        [self addSubview:_pwField];
    }
    return _pwField;
}
- (UIButton *)rightBtnView{
    if (!_rightBtnView) {
        _rightBtnView = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtnView setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_rightBtnView setTitleColor:lightColor forState:UIControlStateNormal];
        _rightBtnView.titleLabel.font = kFont16;
        _rightBtnView.enabled = NO;
        [[_rightBtnView rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self.viewModel.getCode sendNext:x]; //获取验证码或忘记密码
            
        }];
    }
      return _rightBtnView;
}
- (void)layoutSubviews{
    _userField.frame = kRect(25, 0, kScreenWidth-50, self.frame.size.height/2);
    _pwField.frame = kRect(25, self.frame.size.height/2, kScreenWidth-50, self.frame.size.height/2);
}
- (void)changeStyle:(BOOL)isSelected{
    _pwField.text = @""; //切换账号密码登录之后，输入框置空
    if (isSelected) { //账号密码登录
        UIImageView * leftView = [[UIImageView alloc] init];
        leftView.image = image(@"secImg");
        _pwField.leftView = leftView;
        _pwField.secureTextEntry = YES;
        _pwField.placeholder = @"请输入密码";
        [_rightBtnView setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_rightBtnView setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _rightBtnView.enabled = YES;
        
    }else{ //验证码登录
        UIImageView * leftView = [[UIImageView alloc] init];
        leftView.image = image(@"passwordImg");
        _pwField.leftView = leftView;
         _pwField.secureTextEntry = NO;
        _pwField.placeholder = @"请输入验证码";
        [_rightBtnView setTitle:@"获取验证码" forState:UIControlStateNormal];
        if (self.userField.text.length == 11) {
            [_rightBtnView setTitleColor:hex(@"#FFB223") forState:UIControlStateNormal];
        }else{
            [_rightBtnView setTitleColor:lightColor forState:UIControlStateNormal];
        }
        
    }
    
}


@end

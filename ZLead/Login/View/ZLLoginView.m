//
//  ZLLoginView.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/23.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLLoginView.h"
#import "ZLInputView.h"

@interface ZLLoginView ()


@property (nonatomic, strong) UIImageView *logoView; // logo

@property (nonatomic, strong) ZLInputView *tfView; // 输入视图

@property (nonatomic, strong) UIButton *login; // 登录

@property (nonatomic, strong) ZLLoginViewModel *viewModel; // viewModel

@end
@implementation ZLLoginView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame viewModel:(ZLLoginViewModel *)viewModel style:(LogStyle)style{
    self = [super initWithFrame:frame];
    if (self) {
        self.viewModel = viewModel;
        self.style = style;
        [self initView]; //配置登录视图
        [self addGesture]; //添加手势，取消键盘
        
        
    }
    return self;
}
- (void)initView{
    [self addSubview:self.logoView]; //添加logo
    [self addSubview:self.tfView]; //添加输入视图
    [self addSubview:self.pwLogin]; //账户密码登录
    if (self.style == LogStyleLogin) {
        [self addSubview:self.rsBtn]; //去注册
    }
    [self addSubview:self.login]; //去登录
}
-(UIImageView *)logoView{
    if (!_logoView) {
        _logoView = [[UIImageView alloc] init];
        _logoView.image = image(@"分组");
        _logoView.frame = kRect((kScreenWidth-90)/2, 110, 90, 90);
        [self addSubview:_logoView];
    }
    return _logoView;
}
- (ZLInputView *)tfView{
    if (!_tfView) {
        _tfView = [[ZLInputView alloc] initWithFrame:CGRectZero viewModel:self.viewModel];
        kWeakSelf(weakSelf)
        _tfView.changeLoginState = ^(BOOL selecte) {
            if (selecte) {
                weakSelf.login.enabled = YES;
                weakSelf.login.alpha = 1;
            }else{
                 weakSelf.login.enabled = NO;
                 weakSelf.login.alpha = 0.3;
            }
        };
        [self addSubview:_tfView];
        [_tfView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.logoView.mas_bottom).offset(dis(80));
            make.size.mas_equalTo(CGSizeMake(kScreenWidth, dis(120)));
        }];
    }
    return _tfView;
}
- (UIButton *)pwLogin{
    if (!_pwLogin) {
        _pwLogin = [UIButton buttonWithType:UIButtonTypeCustom];
        if (self.style == LogStyleLogin) {
            [_pwLogin setTitle:@"账号密码登录" forState:UIControlStateNormal];
            [_pwLogin setTitle:@"验证码登录" forState:UIControlStateSelected];
        }else{
            [_pwLogin setTitle:@"已有账户，去登录" forState:UIControlStateNormal];
        }
        [_pwLogin setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _pwLogin.titleLabel.font = kFont16;
        [[_pwLogin rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.style == LogStyleLogin) { //登录
                UIButton *btn = x;
                btn.selected = !btn.selected;
                if (btn.selected == YES) {
                    [self.tfView changeStyle:YES]; //账号密码登录，改变输入框样式
                }else{
                    [self.tfView changeStyle:NO]; //验证码登录，改变输入框样式
                }
            }else if (self.style == LogStyleRegister){ //注册
                [self.viewModel.goLogin sendNext:x];
            }
           
            
        }];
        [self addSubview:_pwLogin];
        [_pwLogin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.tfView).offset(dis(25));
            make.top.equalTo(self.tfView.mas_bottom).offset(dis(25));
        }];
    }
    return _pwLogin;
}
- (UIButton *)rsBtn{
    if (!_rsBtn) {
        _rsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rsBtn setTitle:@"去注册 >" forState:UIControlStateNormal];
        [_rsBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _rsBtn.titleLabel.font = kFont16;
        [[_rsBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self.viewModel.goRegister sendNext:x]; 
        }];
        [self addSubview:_rsBtn];
        [_rsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.tfView).offset(-dis(25));
            make.top.equalTo(self.tfView.mas_bottom).offset(dis(25));
        }];
    }
    return _rsBtn;
}
- (UIButton *)login{
    if (!_login) {
        _login = [UIButton buttonWithType:UIButtonTypeCustom];
        _login.alpha = 0.3;
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = kRect(0, 0, kScreenWidth-50, 50);
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1, 0);
        gradientLayer.locations = @[@(0.5),@(1.0)];//渐变点
        [gradientLayer setColors:@[(id)[hex(@"#FFD94F") CGColor],(id)[hex(@"#F7981C") CGColor]]];//渐变数组
        [_login.layer addSublayer:gradientLayer];
        _login.layer.masksToBounds = YES;
        _login.layer.cornerRadius = dis(25);
        _login.enabled = NO;
        if (self.style == LogStyleLogin) {
           [_login setTitle:@"登录" forState:UIControlStateNormal];
        }else{
            [_login setTitle:@"注册" forState:UIControlStateNormal];
        }
        [_login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _login.titleLabel.font = kFont16;
        [[_login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self.viewModel.login sendNext:x]; 
        }];
        [self addSubview:_login];
        [_login mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.pwLogin.mas_bottom).offset(dis(60));
            make.centerX.equalTo(self);
            make.size.mas_equalTo(kSize(kScreenWidth-50, 50));
        }];
    }
    return _login;
}
- (void)addGesture {
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
    [[tapGesture rac_gestureSignal] subscribeNext:^(id x) {
        [self endEditing:YES];
    }];
    [self addGestureRecognizer:tapGesture];
}
@end

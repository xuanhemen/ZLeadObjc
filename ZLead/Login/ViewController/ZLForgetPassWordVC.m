//
//  ZLForgetPassWordVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/30.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLForgetPassWordVC.h"
#import "ZLInputView.h"
#import "ZLLoginViewModel.h"
#import "ZLSetPasswordVC.h"
#import "ZLBaseViewController+Func.h"
@interface ZLForgetPassWordVC ()

@property (nonatomic, strong) ZLInputView *tfView; // 输入视图

@property (nonatomic, strong) ZLLoginViewModel *viewModel; //

@property (nonatomic, strong) UIButton *nextBtn; // 去设置新密码
@end

@implementation ZLForgetPassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView]; //初始化视图
    // Do any additional setup after loading the view.
}
- (void)initView {
    UILabel *title = [[UILabel alloc] init];
    title.text = @"找回密码";
    title.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(dis(120));
        make.left.equalTo(self.view).offset(dis(30));
    }];
    [self.view addSubview:self.tfView];
    [self.view addSubview:self.nextBtn];
    [self addBackBtn]; //添加返回按钮
}
- (ZLLoginViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[ZLLoginViewModel alloc] init];
    }
    return _viewModel;
}
- (ZLInputView *)tfView{
    if (!_tfView) {
        _tfView = [[ZLInputView alloc] initWithFrame:CGRectZero viewModel:self.viewModel];
        kWeakSelf(weakSelf)
        _tfView.changeLoginState = ^(BOOL selecte) {
            if (selecte) {
                weakSelf.nextBtn.enabled = YES;
                weakSelf.nextBtn.backgroundColor = hex(@"#F7981C");
            }else{
                weakSelf.nextBtn.enabled = NO;
                weakSelf.nextBtn.backgroundColor = COLOR(249, 222, 172, 1);
            }
        };
        [self.view addSubview:_tfView];
        [_tfView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(dis(170));
            make.size.mas_equalTo(CGSizeMake(kScreenWith, dis(120)));
        }];
    }
    return _tfView;
}
- (UIButton *)nextBtn {
    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextBtn.backgroundColor = COLOR(249, 222, 172, 1);
    _nextBtn.layer.masksToBounds = YES;
    _nextBtn.layer.cornerRadius = dis(25);
    _nextBtn.enabled = NO;
    [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextBtn.titleLabel.font = kFont16;
    [[_nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ZLSetPasswordVC *svc = [[ZLSetPasswordVC alloc] init];
        svc.style = SetPWStyleForgetSet;
        [self.navigationController pushViewController:svc animated:YES];
    }];
    [self.view addSubview:_nextBtn];
    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tfView.mas_bottom).offset(dis(60));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(kSize(kScreenWith-50, 50));
    }];
    return _nextBtn;
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

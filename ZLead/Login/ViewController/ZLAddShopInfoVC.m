//
//  ZLAddShopInfoVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/29.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddShopInfoVC.h"
#import "ZLAddInfoView.h"
#import "ZLTabBarController.h"
#import "ZLBaseViewController+Func.h"
@interface ZLAddShopInfoVC ()


@property (nonatomic, strong) ZLAddInfoView *infoView; //输入视图

@property (nonatomic, strong) UIButton *completeBtn; // 登录
@end

@implementation ZLAddShopInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self initView]; //初始化视图
    
    // Do any additional setup after loading the view.
}
- (void)initView {
    
    [self addBackBtn]; //添加返回按钮
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"补充店铺信息";
    title.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(dis(120));
        make.left.equalTo(self.view).offset(dis(30));
    }];
    [self.view addSubview:_infoView];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(dis(30));
        make.size.mas_equalTo(CGSizeMake(kScreenWith, dis(150)));
    }];
    
    _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _completeBtn.backgroundColor = COLOR(249, 222, 172, 1);
    _completeBtn.layer.masksToBounds = YES;
    _completeBtn.layer.cornerRadius = dis(25);
    _completeBtn.enabled = NO;
    [_completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _completeBtn.titleLabel.font = kFont16;
    [[_completeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ZLTabBarController *tvc = [[ZLTabBarController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tvc;
    }];
    [self.view addSubview:_completeBtn];
    [_completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoView.mas_bottom).offset(dis(60));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(kSize(kScreenWith-50, 50));
    }];
}
- (ZLAddInfoView *)infoView {
    if (!_infoView) {
        _infoView = [[ZLAddInfoView alloc] init];
        [self.view addSubview:_infoView];
        [[_infoView.nameField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
            NSLog(@"%@",value);
            if (!IsStrEmpty(value) && !IsStrEmpty(self.infoView.addressField.text) && !IsStrEmpty(self.infoView.areaLable.text)) {
                self.completeBtn.enabled = YES;
                self.completeBtn.backgroundColor = hex(@"#F7981C");
            }else{
                self.completeBtn.enabled = NO;
                self.completeBtn.backgroundColor = COLOR(249, 222, 172, 1);
            }
            return YES;
        }] subscribeNext:^(NSString * _Nullable x) {
            
        }];
        [[_infoView.addressField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
            NSLog(@"%@",value);
            if (!IsStrEmpty(value) && !IsStrEmpty(self.infoView.nameField.text) && !IsStrEmpty(self.infoView.areaLable.text)) {
                self.completeBtn.enabled = YES;
                self.completeBtn.backgroundColor = hex(@"#F7981C");
            }else{
                self.completeBtn.enabled = NO;
                self.completeBtn.backgroundColor = COLOR(249, 222, 172, 1);
            }
            return YES;
        }] subscribeNext:^(NSString * _Nullable x) {
            
        }];
    }
    return _infoView;
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

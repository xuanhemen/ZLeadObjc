//
//  ZLAddWayVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/4.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddWayVC.h"
#import "ZLAddCustomGoodsVC.h"
#import "ZLAddPlatformVC.h"
@interface ZLAddWayVC ()


@property (nonatomic, strong) UIButton *platformAdd; // 从平台添加商品
@property (nonatomic, strong) UIButton *customAdd; // 从平台添加商品

@property (nonatomic, strong) UILabel *platformLb; // 平台添加
@property (nonatomic, strong) UILabel *customLb; // 平台添加

@end

@implementation ZLAddWayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"请选择添加商品方式";
    [self initView]; //添加视图
    
    // Do any additional setup after loading the view.
}
- (void)initView {
    
    [self.view addSubview:self.platformAdd];
    [self.view addSubview:self.customAdd];
    [self.platformAdd addSubview:self.platformLb];
    [self.customAdd addSubview:self.customLb];
}
- (UIButton *)platformAdd {
    if (!_platformAdd) {
        _platformAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        [_platformAdd setBackgroundImage:image(@"addGoods") forState:UIControlStateNormal];
        [[_platformAdd rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ZLAddPlatformVC *vc = [[ZLAddPlatformVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [self.view addSubview:_platformAdd];
        [_platformAdd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.view).offset(dis(200));
           
        }];
    }
    return _platformAdd;
    
}
- (UIButton *)customAdd {
    if (!_customAdd) {
        _customAdd = [UIButton buttonWithType:UIButtonTypeCustom];
        [_customAdd setBackgroundImage:image(@"addCustomGoods") forState:UIControlStateNormal];
        [[_customAdd rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            ZLAddCustomGoodsVC *vc = [[ZLAddCustomGoodsVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        [self.view addSubview:_customAdd];
        [_customAdd mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.platformAdd.mas_bottom).offset(dis(30));
    
        }];
    }
    return _customAdd;
    
}
- (UILabel *)platformLb {
    if (!_platformLb) {
        _platformLb = [[UILabel alloc] init];
        _platformLb.text = @"从平台添加商品";
        _platformLb.textColor = [UIColor whiteColor];
        _platformLb.font = [UIFont boldSystemFontOfSize:18];
        [_platformAdd addSubview:_platformLb];
        [_platformLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.platformAdd);
            make.left.equalTo(self.platformAdd).offset(dis(105));
        }];
    }
    return _platformLb;
    
}
- (UILabel *)customLb {
    if (!_customLb) {
        _customLb = [[UILabel alloc] init];
        _customLb.text = @"自主添加商品";
        _customLb.textColor = [UIColor whiteColor];
        _customLb.font = [UIFont boldSystemFontOfSize:18];
        [_customAdd addSubview:_customLb];
        [_customLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.customAdd);
            make.left.equalTo(self.customAdd).offset(dis(105));
        }];
    }
    return _customLb;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
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

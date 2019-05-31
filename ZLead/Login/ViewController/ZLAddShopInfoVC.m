//
//  ZLAddShopInfoVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/29.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddShopInfoVC.h"
#import "ZLAddInfoView.h"
@interface ZLAddShopInfoVC ()


@property (nonatomic, strong) ZLAddInfoView *infoView; //
@end

@implementation ZLAddShopInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, dis(150)));
    }];
    
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    completeBtn.backgroundColor = COLOR(249, 222, 172, 1);
    completeBtn.layer.masksToBounds = YES;
    completeBtn.layer.cornerRadius = dis(25);
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    completeBtn.titleLabel.font = kFont16;
    [[completeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
    }];
    [self.view addSubview:completeBtn];
    [completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoView.mas_bottom).offset(dis(60));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(kSize(kScreenWidth-50, 50));
    }];
    // Do any additional setup after loading the view.
}
- (ZLAddInfoView *)infoView {
    if (!_infoView) {
        _infoView = [[ZLAddInfoView alloc] init];
        [self.view addSubview:_infoView];
    }
    return _infoView;
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

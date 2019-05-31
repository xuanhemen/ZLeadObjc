//
//  ZLLoginVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/23.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLLoginVC.h"

#import "ZLLoginViewModel.h"
@interface ZLLoginVC ()




@property (nonatomic, strong) ZLLoginViewModel *viewModel; //

@end

@implementation ZLLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.loginView]; //添加登录视图
    [self.viewModel jumpFromController:self]; //处理跳转事件
    // Do any additional setup after loading the view.
}
- (ZLLoginViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[ZLLoginViewModel alloc] init];
    }
    return _viewModel;
}
- (ZLLoginView *)loginView {
    if (!_loginView) {
        if ([self.indentifier isEqualToString:@"register"]) {
             _loginView = [[ZLLoginView alloc] initWithFrame:self.view.frame viewModel:self.viewModel style:LogStyleRegister];
        } else {
           _loginView = [[ZLLoginView alloc] initWithFrame:self.view.frame viewModel:self.viewModel style:LogStyleLogin];
        }
    }
    return _loginView;
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

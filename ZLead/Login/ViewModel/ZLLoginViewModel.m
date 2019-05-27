//
//  ZLLoginViewModel.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/23.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLLoginViewModel.h"
#import "ZLLoginVC.h"
#import "ZLTabBarController.h"

@implementation ZLLoginViewModel


-(instancetype)init{
    self = [super init];
    if (self) {
        [self registerSignalAndSubscribe]; //注册并且订阅信号
    }
    return self;
}
-(void)registerSignalAndSubscribe{
    self.goRegister = [RACSubject subject]; //注册新号
    self.goLogin = [RACSubject subject]; //切回登录界面
    self.login = [RACSubject subject]; //登录
    [self getVerificationCode]; //获取验证码或忘记密码
}
-(void)jumpFromController:(UIViewController *)vc{
  
    [self.goRegister subscribeNext:^(id  _Nullable x) {
        ZLLoginVC *lvc = [[ZLLoginVC alloc] init];
        lvc.indentifier = @"register";
        [vc presentViewController:lvc animated:YES completion:nil];
        
    }];
    [self.goLogin subscribeNext:^(id  _Nullable x) {
        [vc dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.login subscribeNext:^(id  _Nullable x) {
        ZLTabBarController *tvc = [[ZLTabBarController alloc] init];
        [UIApplication sharedApplication].keyWindow.rootViewController = tvc;
    }];
}
- (void)getVerificationCode{
    self.getCode = [RACSubject subject]; //获取验证码
    [self.getCode subscribeNext:^(id  _Nullable x) {
        UIButton *btn = x;
        NSString *title = btn.titleLabel.text; 
        if ([title isEqualToString:@"获取验证码"]) { //调用获取验证码接口
            [self showMsg:@"获取验证码"];
        }else if ([title isEqualToString:@"忘记密码"]){ //忘记密码
            
        }
    }];
}
@end

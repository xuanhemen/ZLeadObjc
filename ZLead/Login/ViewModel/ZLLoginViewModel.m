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
#import "ZLNavigationController.h"
#import "NSString+Function.h"
#import "ZLSetPasswordVC.h"


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
        ZLNavigationController *zvc = [[ZLNavigationController alloc] initWithRootViewController:lvc];
        [vc presentViewController:zvc animated:YES completion:nil];
        
    }];
    [self.goLogin subscribeNext:^(id  _Nullable x) {
        [vc dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.login subscribeNext:^(id  _Nullable x) {
        UIButton *btn = x;
        if ([btn.titleLabel.text isEqualToString:@"登录"]) {
            BOOL isTrue = [NSString validatePhoneNumber:self.phoneNumber];
            if (!isTrue) {
                [self showMsg:@"手机号格式不正确"];
                return;
            }
            ZLTabBarController *tvc = [[ZLTabBarController alloc] init];
            [UIApplication sharedApplication].keyWindow.rootViewController = tvc;
        }else if ([btn.titleLabel.text isEqualToString:@"注册"]){
            BOOL isTrue = [NSString validatePhoneNumber:self.phoneNumber];
            if (!isTrue) {
                [self showMsg:@"手机号格式不正确"];
                return;
            }
            ZLSetPasswordVC *svc = [[ZLSetPasswordVC alloc] init];
            [vc.navigationController pushViewController:svc animated:YES];
        }
       
        
    }];
}
- (void)getVerificationCode{
    self.getCode = [RACSubject subject]; //获取验证码
    [self.getCode subscribeNext:^(id  _Nullable x) {
        UIButton *btn = x;
        NSString *title = btn.titleLabel.text; 
        if ([title isEqualToString:@"获取验证码"]) { //调用获取验证码接口
            BOOL isTrue = [NSString validatePhoneNumber:self.phoneNumber];
            if (isTrue) {
                [self showMsg:@"发送验证码"];
            }else{
                [self showMsg:@"手机号格式不正确"];
            }
          
        }else if ([title isEqualToString:@"忘记密码"]){ //忘记密码
            
        }
    }];
}

@end

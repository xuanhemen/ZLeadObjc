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
#import "ZLForgetPassWordVC.h"

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
    self.forgetPassword = [RACSubject subject]; //忘记密码
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
            if (self.gcdTimer) {
                dispatch_source_cancel(self.gcdTimer); //取消定时器
            }
            
            NSDictionary *params;
            if (self.authCode.length>=6) {
                params = @{@"userName":self.phoneNumber,@"password":self.authCode}; //此时authCode是密码
            }else{
                params = @{@"userName":self.phoneNumber,@"code":self.authCode};  //此时authCode是验证码
            }
           
            [NetManager postWithURLString:@"ZlwUser/login" parameters:params success:^(NSDictionary * _Nonnull response) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loginState"];
                ZLTabBarController *tvc = [[ZLTabBarController alloc] init];
                [UIApplication sharedApplication].keyWindow.rootViewController = tvc;

            } failure:^(NSDictionary * _Nonnull errorMsg) {
                
            }];
            
            
        }else if ([btn.titleLabel.text isEqualToString:@"注册"]){ //跳转到设置密码
            BOOL isTrue = [NSString validatePhoneNumber:self.phoneNumber];
            if (!isTrue) {
                [self showMsg:@"手机号格式不正确"];
                return;
            }
            NSDictionary *params = @{@"phone":self.phoneNumber,@"code":self.authCode};
            [NetManager postWithURLString:@"common/checkSmsCode" parameters:params success:^(NSDictionary * _Nonnull response) {
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"loginState"];
                ZLSetPasswordVC *svc = [[ZLSetPasswordVC alloc] init];
                svc.style = SetPWStyleNewSet;
                svc.phoneNumber = self.phoneNumber;
                [vc.navigationController pushViewController:svc animated:YES];
            } failure:^(NSDictionary * _Nonnull errorMsg) {
                
            }];
            
        }
       
        
    }];
    [self.forgetPassword subscribeNext:^(id  _Nullable x) { //跳转到找回密码
        ZLForgetPassWordVC *fvc = [[ZLForgetPassWordVC alloc] init];
        [vc.navigationController pushViewController:fvc animated:YES];
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
               
                __block int totalSec = 60;
                self.gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
                dispatch_source_set_timer(self.gcdTimer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
                dispatch_source_set_event_handler(self.gcdTimer, ^{
                    
                    NSString *sec = [NSString stringWithFormat:@"%d s",totalSec--];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.seconds = sec;
                        if (totalSec == 0) {
                            dispatch_source_cancel(self.gcdTimer);
                            [self showMsg:@"验证码失效，请重新获取验证码"];
                            self.seconds = @"获取验证码";
                        }
                    });
                    
                });
                
                dispatch_resume(self.gcdTimer);  // 启动任务，GCD计时器创建后需要手动启动
                
                
                [self showMsg:@"验证码已发送，请注意查收"];
                NSDictionary *params = @{@"phone":self.phoneNumber,@"serviceId":@"1"};
                [NetManager postWithURLString:@"common/getPhoneValidateCode" parameters:params success:^(NSDictionary * _Nonnull response) {

                } failure:^(NSDictionary * _Nonnull errorMsg) {

                }];
                
                
                
            }else{
                [self showMsg:@"手机号格式不正确"];
            }
          
        }else if ([title isEqualToString:@"忘记密码"]){ //忘记密码
            [self.forgetPassword sendNext:@"忘记密码"];
            
        }
    }];
}

@end

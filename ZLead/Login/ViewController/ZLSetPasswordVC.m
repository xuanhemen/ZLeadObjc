//
//  ZLSetPasswordVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/28.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLSetPasswordVC.h"
#import "ZLAddShopInfoVC.h"
#import "ZLTabBarController.h"
#import "ZLBaseViewController+Func.h"
@interface ZLSetPasswordVC ()

@end

@implementation ZLSetPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView]; //添加视图
}
- (void)initView {
    
    [self addBackBtn];
    
    UILabel *title = [[UILabel alloc] init];
    if (self.style == SetPWStyleNewSet) {
        title.text = @"请设置登录密码";
    }else{
        title.text = @"请重新设置登录密码";
    }
    title.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(dis(100));
        make.left.equalTo(self.view).offset(dis(30));
    }];
    UITextField *firstField = [[UITextField alloc] init];
    firstField.rightViewMode=UITextFieldViewModeAlways;
    firstField.keyboardType = UIKeyboardTypeTwitter;
    firstField.clearsOnBeginEditing = NO;
    firstField.clearButtonMode = UITextFieldViewModeWhileEditing;
    firstField.placeholder = @"请设置6-20位登录密码";
    [self.view addSubview:firstField];
    [firstField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(title.mas_bottom).offset(dis(30));
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(kSize(kScreenWidth-60, 60));
    }];
    CALayer *bottomLayer = [CALayer layer];
    bottomLayer.backgroundColor = lightColor.CGColor;
    bottomLayer.frame = kRect(0, 59.7, kScreenWidth-60, 0.3);
    [firstField.layer addSublayer:bottomLayer];
    UITextField *secField = [[UITextField alloc] init];
    secField.placeholder = @"请再次确认登录密码";
    [self.view addSubview:secField];
    [secField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstField.mas_bottom).offset(1);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(kSize(kScreenWidth-60, 60));
    }];
    CALayer *secLayer = [CALayer layer];
    secLayer.backgroundColor = lightColor.CGColor;
    secLayer.frame = kRect(0, 59.7, kScreenWidth-60, 0.3);
    [firstField.layer addSublayer:secLayer];
    [secField.layer addSublayer:secLayer];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.backgroundColor = COLOR(249, 222, 172, 1);
    nextBtn.enabled = NO;
    if (self.style == SetPWStyleNewSet) {
        [nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    }else{
         [nextBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
    
    [nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
       
        BOOL isTrue =  [self cheackPass:firstField.text];
        BOOL isYes =  [self cheackPass:secField.text];
        BOOL isEqual = [firstField.text isEqualToString:secField.text];
        if (isTrue && isYes) {
            if (isEqual) { //跳转到补充店铺信息
                NSString *url;
                NSDictionary *params;
                if (self.style == SetPWStyleNewSet) {
                    url = @"ZlwUser/setPassword";
                    params = @{@"phone":self.phoneNumber,@"password":firstField.text};
                }else{
                    url = @"ZlwUser/resetPassword";
                    params = @{@"phone":self.phoneNumber,@"password":firstField.text,@"code":self.code};
                }
                [NetManager postWithURLString:url parameters:params success:^(NSDictionary * _Nonnull response) {
                    if (self.style == SetPWStyleNewSet) {
                        kUserInfo.userID = [response objectForKey:@"userId"];
                    }
                    
                    if (self.style == SetPWStyleNewSet) {
                        ZLAddShopInfoVC *avc = [[ZLAddShopInfoVC alloc] init];
                        [self.navigationController pushViewController:avc animated:YES];
                    }else{
                        ZLTabBarController *tvc = [[ZLTabBarController alloc] init];
                        [UIApplication sharedApplication].keyWindow.rootViewController = tvc;
                    }
            
                } failure:^(NSDictionary * _Nonnull errorMsg) {
                    
                }];
                
               
            }else{
               [self showMsg:@"密码不一致"];
            }
        }else{
            [self showMsg:@"密码格式不正确"];
        }
        
    }];
    [self.view addSubview:nextBtn];
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secField.mas_bottom).offset(dis(60));
        make.size.mas_equalTo(kSize(kScreenWidth-60, 50));
        make.centerX.equalTo(self.view);
    }];
    nextBtn.layer.masksToBounds = YES;
    nextBtn.layer.cornerRadius = dis(25);
    
    [[firstField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        if (value.length>=6 && secField.text.length>=6) {
            nextBtn.enabled = YES;
            nextBtn.backgroundColor = hex(@"#F7981C");
        }
        if (value.length>20) {
            firstField.text = [firstField.text substringToIndex:20];
            [self showMsg:@"密码最多20位"];
        }
        return YES;
    }] subscribeNext:^(NSString * _Nullable x) {
        
    }];
    [[secField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        if (value.length>=6 && firstField.text.length>=6) {
           
            nextBtn.enabled = YES;
            nextBtn.backgroundColor = hex(@"#F7981C");
        }
        if (value.length>20) {
            secField.text = [secField.text substringToIndex:20];
            [self showMsg:@"密码最多20位"];
        }
        return YES;
    }] subscribeNext:^(NSString * _Nullable x) {

    }];
    
}
/** 验证密码格式 */
- (BOOL)cheackPass:(NSString *)string {
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z`~!@#$%^&*()+=|{}':;',//[//].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
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

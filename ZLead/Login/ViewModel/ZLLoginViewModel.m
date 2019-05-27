//
//  ZLLoginViewModel.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/23.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLLoginViewModel.h"
#import "ZLLoginVC.h"
@implementation ZLLoginViewModel

-(instancetype)init{
    self = [super init];
    if (self) {
        self.goRegister = [RACSubject subject]; //注册新号
        self.goLogin = [RACSubject subject]; //登录
    }
    return self;
}
-(void)jumpFromController:(UIViewController *)vc{
    [self.goRegister subscribeNext:^(id  _Nullable x) {
        ZLLoginVC *lvc = [[ZLLoginVC alloc] init];
        lvc.indentifier = @"register";
        [vc presentViewController:lvc animated:YES completion:nil];
    }];
    [self.goLogin subscribeNext:^(id  _Nullable x) {
        
    }];
    
    
}
@end

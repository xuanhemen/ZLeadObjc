//
//  ZLBaseViewController+Func.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/30.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBaseViewController+Func.h"

@implementation ZLBaseViewController (Func)

- (UIButton *)addBackBtn {
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:image(@"shopback") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(60);
        make.left.equalTo(self.view).offset(25);
    }];
    return backBtn;
}
/** 返回上一个界面 */
- (void)backBtnClicked {
    [self.navigationController popViewControllerAnimated:YES];
}
@end

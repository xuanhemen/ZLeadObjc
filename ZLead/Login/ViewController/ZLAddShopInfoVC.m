//
//  ZLAddShopInfoVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/29.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddShopInfoVC.h"

@interface ZLAddShopInfoVC ()

@end

@implementation ZLAddShopInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *title = [[UILabel alloc] init];
    title.text = @"请设置登录密码";
    title.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(dis(100));
        make.left.equalTo(self.view).offset(dis(30));
    }];
    // Do any additional setup after loading the view.
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

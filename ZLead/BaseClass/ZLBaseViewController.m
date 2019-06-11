//
//  ZLBaseViewController.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/22.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLBaseViewController.h"

@interface ZLBaseViewController ()

@end

@implementation ZLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor zl_bgColor]; //背景颜色
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]}forState:UIControlStateNormal];
   
    // Do any additional setup after loading the view.

}

- (void)configNavigationBar {
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 2, 60, 44);
    [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    leftButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}
@end

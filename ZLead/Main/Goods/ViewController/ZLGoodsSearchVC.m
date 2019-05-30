//
//  ZLGoodsSearchVC.m
//  ZLead
//
//  Created by qzwh on 2019/5/30.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLGoodsSearchVC.h"

@interface ZLGoodsSearchVC ()

@end

@implementation ZLGoodsSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self styleForNav];
}

- (void)styleForNav {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWith, 40)];
    view.backgroundColor = [UIColor cyanColor];
    self.navigationItem.titleView = view;
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

//
//  ZLMoreSpeVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/12.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLMoreSpeVC.h"

@interface ZLMoreSpeVC ()

@end

@implementation ZLMoreSpeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加多规格";
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor blackColor]}];
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

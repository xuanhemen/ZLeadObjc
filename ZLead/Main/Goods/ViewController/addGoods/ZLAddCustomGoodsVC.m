//
//  ZLAddCustomGoodsVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/6/5.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLAddCustomGoodsVC.h"
#import "ZLAddGoodsView.h"
#import "ZLAddGoodsViewModel.h"

//#define width 200*kp
@interface ZLAddCustomGoodsVC ()

@property (nonatomic, strong) ZLAddGoodsView *addView; // 自定义商品视图

@property (nonatomic, strong) ZLAddGoodsViewModel *viewModel; // 数据源

@property (nonatomic, strong) ZLAddGoodsImgView *addImgView; // 添加图片视图

@property (nonatomic, strong) ZLAddImgViewModel *addImgViewModel; // 添加图片数据源

@end

@implementation ZLAddCustomGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加商品";
    [self.view addSubview:self.addView]; //添加商品视图
    [self.addImgViewModel jumpFromController:self]; //处理跳转事件
    [self.viewModel jumpFromController:self]; //处理跳转事件
    // Do any additional setup after loading the view.
}
- (ZLAddGoodsView *)addView {
    if (!_addView) {
        _addView = [[ZLAddGoodsView alloc] initWithFrame:self.view.frame viewModel:self.viewModel];
        _addView.tableView.tableHeaderView = self.addImgView;
    }
    return _addView;
}
- (ZLAddGoodsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ZLAddGoodsViewModel alloc] init];
    }
    return _viewModel;
    
}
- (ZLAddGoodsImgView *)addImgView {
    if (!_addImgView) {
        _addImgView = [[ZLAddGoodsImgView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200*kp) viewModel:self.addImgViewModel];
    }
    return _addImgView;
}
- (ZLAddImgViewModel *)addImgViewModel {
    if (!_addImgViewModel) {
        _addImgViewModel = [[ZLAddImgViewModel alloc] init];
        kWeakSelf(weakSelf)
        [_addImgViewModel.refreshImgEvent subscribeNext:^(id  _Nullable x) {
            NSNumber *count = x;
            if ([count integerValue]>3) {
                weakSelf.addImgView.frame = CGRectMake(0, 0, kScreenWidth, 200*kp+(kScreenWidth-10)/3);
                weakSelf.addView.tableView.tableHeaderView = self.addImgView;
            }
        }];
    }
    return _addImgViewModel;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor blackColor]}];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)willMoveToParentViewController:(UIViewController *)parent {
    [super willMoveToParentViewController:parent];
    if (!parent) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        self.navigationController.navigationBar.barTintColor = [UIColor zl_mainColor];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18], NSForegroundColorAttributeName:[UIColor whiteColor]}];
    }
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

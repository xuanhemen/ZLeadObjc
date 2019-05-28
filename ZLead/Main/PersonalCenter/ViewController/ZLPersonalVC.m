//
//  ZLPersonalVC.m
//  ZLead
//
//  Created by 董建伟 on 2019/5/22.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLPersonalVC.h"
#import "ZLPerHeaderView.h"
#import "ZLPerButtonView.h"
#import "ZLPerListView.h"
#import "ZLPerShareView.h"

#import "ZLPerAccountVC.h"
#import "ZLShopListVC.h"
#import "ZLPerWithdrawVC.h"
#import "ZLPerAccountOfWithdrawVC.h"

@interface ZLPersonalVC ()

@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)UIView *containerView;
@property (nonatomic, strong)ZLPerHeaderView *headerV;
@property (nonatomic, strong)ZLPerButtonView *btnV;
@property (nonatomic, strong)ZLPerListView *listV;
@property (nonatomic, strong)ZLPerShareView *shareV;

/** <#注释#> */
@property (nonatomic, copy)NSArray *listArr;

@end

@implementation ZLPersonalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)setup {
    self.scrollView.backgroundColor = [UIColor colorWithWhite:247/255.0 alpha:1.0];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.containerView.backgroundColor = [UIColor colorWithWhite:247/255.0 alpha:1.0];
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    [self.headerV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.containerView);
        make.height.mas_equalTo(dis(146) + kNavBarHeight);
    }];
    
    [self.btnV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.containerView).offset(15);
        make.right.equalTo(self.containerView).offset(-15);
        make.top.equalTo(self.headerV.mas_bottom).offset(-66);
        make.height.mas_equalTo(dis(125));
    }];
    
    self.listV.listArr = self.listArr;
    [self.listV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.btnV);
        make.top.equalTo(self.btnV.mas_bottom).offset(10);
    }];
    
    [self.shareV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.btnV);
        make.top.equalTo(self.listV.mas_bottom).offset(10);
        make.height.mas_equalTo(dis(80));
        make.bottom.equalTo(self.containerView).offset(-20);
    }];
    
    [self.view layoutIfNeeded];
    //    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 1050);
    
    [self dealBlock];
}

- (void)dealBlock {
    @weakify(self)
    [self.btnV setPerButtonBlock:^(NSInteger index) {
        @strongify(self)
        if (index == 0) {
            ZLPerAccountVC *accountVc = [[ZLPerAccountVC alloc] init];
            [self.navigationController pushViewController:accountVc animated:YES];
            return;
        }
        if (index == 1) {
            ZLShopListVC *shopListVc = [[ZLShopListVC alloc] init];
            [self.navigationController pushViewController:shopListVc animated:YES];
            return;
        }
        if (index == 2) {
            ZLPerAccountOfWithdrawVC *accOfWithdrawVc = [[ZLPerAccountOfWithdrawVC alloc] init];
            [self.navigationController pushViewController:accOfWithdrawVc animated:YES];
            return;
        }
        if (index == 3) {
            ZLPerWithdrawVC *withdrawVc = [[ZLPerWithdrawVC alloc] init];
            [self.navigationController pushViewController:withdrawVc animated:YES];
            return;
        }
    }];
}

#pragma mark - getter
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        [self.scrollView addSubview:_containerView];
    }
    return _containerView;
}

- (ZLPerHeaderView *)headerV {
    if (!_headerV) {
        _headerV = [[ZLPerHeaderView alloc] init];
        [self.containerView addSubview:_headerV];
    }
    return _headerV;
}

- (ZLPerButtonView *)btnV {
    if (!_btnV) {
        _btnV = [[ZLPerButtonView alloc] init];
        [self.view addSubview:_btnV];
    }
    return _btnV;
}

- (ZLPerListView *)listV {
    if (!_listV) {
        _listV = [[ZLPerListView alloc] init];
        [self.view addSubview:_listV];
    }
    return _listV;
}

- (ZLPerShareView *)shareV {
    if (!_shareV) {
        _shareV = [[ZLPerShareView alloc] init];
        [self.view addSubview:_shareV];
    }
    return _shareV;
}

- (NSArray *)listArr {
    if (!_listArr) {
        _listArr = @[@{@"icon": @"", @"topic": @"帮助与反馈"},
                     @{@"icon": @"", @"topic": @"关于我们"},
                     @{@"icon": @"", @"topic": @"为我们评分"},
                     @{@"icon": @"", @"topic": @"店长交流群"}];
    }
    return _listArr;
}

@end

//
//  ZLGoodsSearchVC.m
//  ZLead
//
//  Created by qzwh on 2019/5/30.
//  Copyright © 2019年 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLGoodsSearchVC.h"
#import "ZLSearchHistoryView.h"
#import "ZLGoodsSearchResultVC.h"
#import "ZLGoodsSearchResultView.h"
#import "ZLSearchBarView.h"
#import "ZLGoodsListCell.h"

#import "ZLGoodsModel.h"

@interface ZLGoodsSearchVC ()<SearchTagDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, ZLSearchBarViewDelegate>
@property (nonatomic, strong) ZLSearchHistoryView *historyView;
@property (nonatomic, strong) ZLGoodsSearchResultView *searchResultView;
@property (nonatomic, strong) ZLSearchBarView *searchBarView;
@property (nonatomic, assign) BOOL allowEdit;
@property (nonatomic, strong) NSMutableArray *goodsList;
@property (nonatomic, assign) BOOL isAllSelected;
@end

@implementation ZLGoodsSearchVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self styleForNav];
    
    [self.view addSubview:self.historyView];
    [self.view addSubview:self.searchResultView];
    self.searchResultView.hidden = YES;
    [self config];
    [self setupData];
    
    self.historyView.tags = @[@"锤子",@"见过见过见过见过见过见过见过见过见过见过见过见过见过见过见过见过见过见过见过见过见过",@"膜拜单车",@"微信支付",@"Q",@"王者",@"蓝淋网",@"阿珂",@"半生",@"猎场",@"QQ空间",@"王者荣耀助手",@"斯卡哈复健科",@"安抚",@"沙发上",@"日打的费",@"问问",@"无人区",@"阿斯废弃物人情味",@"沙发上"];
}


- (void)styleForNav {
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.titleView = [self searchBarView];
}

#pragma mark - Init

- (NSMutableArray *)goodsList {
    if (!_goodsList) {
        _goodsList = [[NSMutableArray alloc] init];
    }
    return _goodsList;
}

#pragma mark - config

- (void)config {
    self.searchResultView.resultTableView.delegate = self;
    self.searchResultView.resultTableView.dataSource = self;
    kWeakSelf(weakSelf);
    self.searchResultView.bottomManagerView.allSelectedBlock = ^(BOOL isSelected) {
        [weakSelf allSelected:isSelected];
    };
    self.searchResultView.bottomManagerView.topBlock = ^{
        for (int i = 0; i < 10; i++) {
            ZLGoodsModel *goodsModel = [weakSelf.goodsList objectAtIndex:i];
            goodsModel.goodsNum = i+1;
            if (goodsModel.isSelected) {
                goodsModel.top = YES;
            }
            [weakSelf.goodsList addObject:goodsModel];
        }
        [weakSelf.searchResultView.resultTableView reloadData];
        [weakSelf.searchResultView.bottomManagerView refreshCanelTopButton:YES];
    };
    self.searchResultView.bottomManagerView.cancelTopBlock = ^{
        int topCount = 0;
        for (int i = 0; i < 10; i++) {
            ZLGoodsModel *goodsModel = [weakSelf.goodsList objectAtIndex:i];
            goodsModel.goodsNum = i+1;
            if (goodsModel.isSelected) {
                goodsModel.top = NO;
            }
            [weakSelf.goodsList addObject:goodsModel];
        }
        [weakSelf.searchResultView.resultTableView reloadData];
        [weakSelf.searchResultView.bottomManagerView refreshCanelTopButton:topCount ? YES : NO];
    };
}

#pragma mark - delegate

- (void)handleSelectTag:(NSString *)keyword {
    NSLog(@"%@", keyword);
    [self searchGoods];
}

- (void)deleteData {
    
}

#pragma mark - lazy load

- (ZLSearchHistoryView *)historyView {
    if (!_historyView) {
        _historyView = [[ZLSearchHistoryView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, 0)];
        _historyView.delegate = self;
    }
    return _historyView;
}

- (ZLGoodsSearchResultView *)searchResultView {
    if (!_searchResultView) {
        _searchResultView = [[ZLGoodsSearchResultView alloc] initWithFrame:CGRectMake(0, kNavBarHeight, kScreenWidth, kScreenHeight - kNavBarHeight)];
    }
    return _searchResultView;
}

- (ZLSearchBarView *)searchBarView {
    if (!_searchBarView) {
        _searchBarView = [[ZLSearchBarView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        _searchBarView.searchTextField.delegate = self;
        _searchBarView.delegate = self;
        [_searchBarView changeSearchBarViewStyle:NO];
    }
    
    return _searchBarView;
}

#pragma mark - setupData

- (void)setupData {
    for (int i = 0; i < 10; i++) {
        ZLGoodsModel *goodsModel = [[ZLGoodsModel alloc] init];
        goodsModel.goodsNum = i+1;
        goodsModel.top = NO;
        [self.goodsList addObject:goodsModel];
    }
    [self.searchResultView.resultTableView reloadData];
}

#pragma mark - private Method

/**
 是否全选
 */
- (void)judgeIsAllSelected {
    NSInteger count = 0;
    BOOL enabelCancelTop = NO;
    for (ZLGoodsModel *goodsModel in self.goodsList) {
        if (goodsModel.isSelected) {
            count ++;
            if (goodsModel.top) {
                enabelCancelTop = YES;
            }
        }
    }
    if (count == self.goodsList.count) {
        self.searchResultView.bottomManagerView.allSelectedButton.selected = YES;
        self.isAllSelected = YES;
    } else {
        self.searchResultView.bottomManagerView.allSelectedButton.selected = NO;
        self.isAllSelected = NO;
    }
    if (count > 0) {
        [self.searchResultView.bottomManagerView refreshUnShelveButton:YES];
        [self.searchResultView.bottomManagerView refreshDelButton:YES];
        [self.searchResultView.bottomManagerView refreshTopButton:YES];
    } else {
        [self.searchResultView.bottomManagerView refreshUnShelveButton:NO];
        [self.searchResultView.bottomManagerView refreshDelButton:NO];
        [self.searchResultView.bottomManagerView refreshTopButton:NO];
    }
    if (enabelCancelTop) {
        [self.searchResultView.bottomManagerView refreshCanelTopButton:enabelCancelTop];
    }
}

- (void)allSelected:(BOOL )isSelected {
    for (int i = 0; i < 10; i++) {
        ZLGoodsModel *goodsModel = [self.goodsList objectAtIndex:i];
        goodsModel.goodsNum = i+1;
        goodsModel.isSelected = isSelected;
        [self.goodsList addObject:goodsModel];
    }
    [self.searchResultView.resultTableView reloadData];
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    ZLGoodsSearchResultVC *searchResultVC = [[ZLGoodsSearchResultVC alloc] init];
//    [self.navigationController pushViewController:searchResultVC animated:NO];
    [self searchGoods];
    return YES;
}

#pragma mark - UIButton Actions


- (void)pop {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)managerButtonAction:(UIBarButtonItem *)sender {
    sender.title = self.allowEdit ? @"管理": @"完成";
    self.allowEdit = !self.allowEdit;
    self.searchResultView.bottomManagerView.hidden = !self.allowEdit;
    self.isAllSelected = NO;
    [self.searchResultView.bottomManagerView reset];
    //    [self judgeIsAllSelected];
}

- (void)addGoodsButtonAction {
    
}

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return dis(130);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLGoodsListCell *cell = [ZLGoodsListCell listCellWithTableView:tableView];
    cell.allowEdit = self.allowEdit;
    [cell setupData:[self.goodsList objectAtIndex:indexPath.row]];
    kWeakSelf(weakSelf);
    cell.selectedButtonBlock = ^(BOOL isSelected) {
        ZLGoodsModel *goodsModel = [weakSelf.goodsList objectAtIndex:indexPath.row];
        goodsModel.isSelected = isSelected;
        [weakSelf judgeIsAllSelected];
    };
    return cell;
}

#pragma mark - ZLSearchBarViewDelegate

- (void)backPreviousPage {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)searchGoods {
    self.historyView.hidden = YES;
    self.searchResultView.hidden = NO;
    [self.searchBarView changeSearchBarViewStyle:YES];
    [self.searchBarView.searchTextField resignFirstResponder];
}

- (void)manageGoods:(UIButton *)manageBtn {
    [manageBtn setTitle:self.allowEdit ? @"管理": @"完成" forState:UIControlStateNormal];
    self.allowEdit = !self.allowEdit;
    self.searchResultView.bottomManagerView.hidden = !self.allowEdit;
    self.isAllSelected = NO;
    [self.searchResultView.bottomManagerView reset];
    [self.searchResultView.resultTableView reloadData];
}

- (void)addGoods {
    
}

@end

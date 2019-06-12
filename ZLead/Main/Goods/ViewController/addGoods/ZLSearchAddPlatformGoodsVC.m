//
//  ZLSearchAddCustomGoodsVC.m
//  ZLead
//
//  Created by dmy on 2019/6/12.
//  Copyright © 2019 Beijing tai chi HuaQing information systems co., LTD. All rights reserved.
//

#import "ZLSearchAddPlatformGoodsVC.h"
#import "ZLSearchHistoryView.h"
#import "ZLGoodsSearchResultVC.h"
#import "ZLSearchAddPlatformGoodsView.h"
#import "ZLBatchSetClassifyView.h"
#import "ZLSearchBarView.h"
#import "ZLAddPlatformGoodsCell.h"
#import "ZLFilterView.h"

#import "ZLGoodsModel.h"
#import "ZLFilterDataModel.h"

@interface ZLSearchAddPlatformGoodsVC ()<SearchTagDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, ZLSearchBarViewDelegate, ZLAddPlatformGoodsCellDelegate>
@property (nonatomic, strong) ZLSearchHistoryView *historyView;
@property (nonatomic, strong) ZLSearchAddPlatformGoodsView *searchResultView;
@property (nonatomic, strong) ZLSearchBarView *searchBarView;
@property (nonatomic, assign) BOOL allowEdit;
@property (nonatomic, strong) NSMutableArray *goodsList;
@property (nonatomic, assign) BOOL isAllSelected;
@property (nonatomic, strong) ZLFilterView *filterView;
@property (nonatomic, strong) ZLFilterDataModel *filterDataModel;
@property (nonatomic, assign) NSInteger goodsTotalNum;
@end

@implementation ZLSearchAddPlatformGoodsVC

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
    [self.searchResultView.batchSetClassifyView setSelectedGoodsNum:0];
    self.searchResultView.hidden = YES;
    [self config];
    [self setupData];
    
    self.historyView.tags = @[@"锤子",@"见过见过见过见过见过见过见过见过见过见过见过见过见过见过见过见过见过见过见过见过见过",@"膜拜单车",@"微信支付",@"Q",@"王者",@"蓝淋网",@"阿珂",@"半生",@"猎场",@"QQ空间",@"王者荣耀助手",@"斯卡哈复健科",@"安抚",@"沙发上",@"日打的费",@"问问",@"无人区",@"阿斯废弃物人情味",@"沙发上"];
}


- (void)styleForNav {
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.titleView = self.searchBarView;
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
    [self.searchResultView.resultTableView registerClass:[ZLAddPlatformGoodsCell class] forCellReuseIdentifier:@"ZLAddPlatformGoodsCell"];
    kWeakSelf(weakSelf)
    self.searchResultView.batchSetClassifyView.batchSetClassifyBlock = ^{
        weakSelf.filterView = [ZLFilterView createFilterViewWidthConfiguration:weakSelf.filterDataModel pushDirection:ZLFilterViewPushDirectionFromRight  filterViewBlock:^(NSString * _Nonnull firstClassify, NSString * _Nonnull secondClassify, NSString * _Nonnull thirdClassify) {
            DLog(@"批量设置分类");
            [weakSelf batchSetClassify:firstClassify secondClassify:secondClassify thirdClassify:thirdClassify];
        }];
        weakSelf.filterView.durationTime = 0.5;
        [weakSelf.filterView show];
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

- (ZLSearchAddPlatformGoodsView *)searchResultView {
    if (!_searchResultView) {
        _searchResultView = [[ZLSearchAddPlatformGoodsView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    }
    return _searchResultView;
}

- (ZLSearchBarView *)searchBarView {
    if (!_searchBarView) {
        _searchBarView = [[ZLSearchBarView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
        _searchBarView.searchTextField.delegate = self;
        _searchBarView.delegate = self;
        [_searchBarView changeSearchBarViewStyle:NO];
        [_searchBarView configRightButtonsForAddGoodsPlatform];
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

- (void)calculateGoodsTotalNum {
    NSInteger count = 0;
    for (int i = 0; i < 10; i++) {
        ZLGoodsModel *goodsModel = [self.goodsList objectAtIndex:i];
        if (goodsModel.isSelected) {
            count ++;
        }
    }
    self.goodsTotalNum = count;
}

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

- (void)batchSetClassify:(NSString *)firstClassify secondClassify:(NSString *)secondClassify thirdClassify:(NSString *)thirdClassify {
    for (int i = 0; i < self.goodsList.count; i++) {
        ZLGoodsModel *goodsModel = [self.goodsList objectAtIndex:i];
        if (goodsModel.isSelected) {
            goodsModel.goodsClassName1 = firstClassify;
            goodsModel.goodsClassName2 = secondClassify;
        }
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

#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return [ZLAddPlatformGoodsCell heightForCell:[self.goodsList objectAtIndex:indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZLAddPlatformGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZLAddPlatformGoodsCell"];
    cell.delegate = self;
    [cell setupData:[self.goodsList objectAtIndex:indexPath.row]];
    kWeakSelf(weakSelf);
    cell.selectedButtonBlock = ^(ZLAddPlatformGoodsCell * _Nonnull cell, BOOL isSelected) {
        ZLGoodsModel *goodsModel = [weakSelf.goodsList objectAtIndex:indexPath.row];
        goodsModel.isSelected = !goodsModel.isSelected;
        [weakSelf calculateGoodsTotalNum];
        [weakSelf.searchResultView.resultTableView beginUpdates];
        [weakSelf.searchResultView.resultTableView  reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [weakSelf.searchResultView.resultTableView  endUpdates];
    };
    return cell;
}

#pragma mark - ZLSearchBarViewDelegate

- (void)backPreviousPage {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchGoods {
    self.historyView.hidden = YES;
    self.searchResultView.hidden = NO;
    [self.searchBarView changeSearchBarViewStyle:YES];
    [self.searchBarView.searchTextField resignFirstResponder];
}

- (void)manageGoods:(UIButton *)manageBtn {
    [self.searchResultView.resultTableView reloadData];
}

- (void)addGoods {
    
}

#pragma mark - ZLAddPlatformGoodsCellDelegate

- (void)addPlatformGoodsCell:(ZLAddPlatformGoodsCell *)cell goodsNameChanged:(NSString *)goodsName {
    NSIndexPath *indexPath = [self.searchResultView.resultTableView indexPathForCell:cell];
    ZLGoodsModel *goodsModel = [self.goodsList objectAtIndex:indexPath.row];
    goodsModel.goodsName = goodsName;
}

- (void)addPlatformGoodsCell:(ZLAddPlatformGoodsCell *)cell goodsNumChanged:(NSInteger )goodsNum {
    NSIndexPath *indexPath = [self.searchResultView.resultTableView indexPathForCell:cell];
    ZLGoodsModel *goodsModel = [self.goodsList objectAtIndex:indexPath.row];
    goodsModel.goodsNum = goodsNum;
}

- (void)addPlatformGoodsCell:(ZLAddPlatformGoodsCell *)cell goodsNumOnlinePriceChanged:(CGFloat )onlinePrice {
    //    NSIndexPath *indexPath = [self.goodsListTableView indexPathForCell:cell];
    //    ZLGoodsModel *goodsModel = [self.goodsList objectAtIndex:indexPath.row];
    //    goodsModel.goodsNum = goodsNum;
    //    [self.goodsListTableView beginUpdates];
    //    [self.goodsListTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    //    [self.goodsListTableView endUpdates];
}

- (void)addPlatformGoodsCell:(ZLAddPlatformGoodsCell *)cell goodsNumOfflinePriceChanged:(CGFloat )offlinePrice {
    
}

- (void)addPlatformGoodsCell:(ZLAddPlatformGoodsCell *)cell shopClassifyNameButton:(UIButton *)classifyNameButton {
    kWeakSelf(weakSelf)
    self.filterView = [ZLFilterView createFilterViewWidthConfiguration:self.filterDataModel pushDirection:ZLFilterViewPushDirectionFromRight  filterViewBlock:^(NSString * _Nonnull firstClassify, NSString * _Nonnull secondClassify, NSString * _Nonnull thirdClassify) {
        [classifyNameButton setTitle:@"选择了分类" forState:UIControlStateNormal];
        NSIndexPath *indexPath = [weakSelf.searchResultView.resultTableView indexPathForCell:cell];
        ZLGoodsModel *goodsModel = [weakSelf.goodsList objectAtIndex:indexPath.row];
        goodsModel.goodsClassName1 = @"";//设置分类
        goodsModel.goodsClassName2 = @"";//设置分类
        [cell setupData:goodsModel];
    }];
    self.filterView.durationTime = 0.5;
    [self.filterView show];
}


@end
